From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: Re: SeLinux integration
Date: Mon, 18 Aug 2008 14:47:13 +0200
Message-ID: <48A96F51.6090404@jaeger.mine.nu>
References: <6341D084-1A83-4C0F-8C45-943916612D48@gmx.de>	 <48A93696.6010500@jaeger.mine.nu> <1219060960.13808.20.camel@desktop.local.neuhalfen.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jens Neuhalfen <JensNeuhalfen@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 18 14:48:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV49n-0005vX-7b
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 14:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbYHRMrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 08:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbYHRMrU
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 08:47:20 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:60501 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751940AbYHRMrT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 08:47:19 -0400
Received: (qmail 10295 invoked from network); 18 Aug 2008 12:47:17 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 18 Aug 2008 12:47:17 -0000
Received: (qmail 3110 invoked from network); 18 Aug 2008 12:47:13 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 18 Aug 2008 12:47:13 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <1219060960.13808.20.camel@desktop.local.neuhalfen.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92703>

Jens Neuhalfen wrote:
> The repository is my current development repository which, naturally (?), is based on the 'blessed' repository. My understanding of git was, that anyone with a copy of the blessed git repository can 'pull' from my repository and gets my branches with git transmitting just my changes over the net. Then he/she/it can switch to 'my' branch and test the policy/init-script.
>
> Did I get something wrong there? I thought that this is a/the normal way of using git. 
>   

Well I'm sure you could use it this way; but check for yourself, if you 
start gitk on your repository, one has to first figure out where to find 
you work, i.e. one has to follow the right parent in your commits to see 
all of them; it's certainly possible but I guess not very inviting for 
people who just want to *look* at your work (as opposed to simply try it 
out). I'll readily admit that I just wanted to look, not try it out. But 
maybe I'm not the only one with this as his/her primary aim.

> You are right with the commits and their rather terse messages, though the code are not ready for release or an integration review. The plan was: Get some feedback on the current state, refine the code and then send the patches to the list. 
>   

Ok, maybe how you're doing it is just fine, I'll leave it to others to 
judge. But still you should be aware that it's common practice with Git 
to first clean up private history before publishing it. The history can 
explain the code much better than is possible by just looking at the 
latest committed version, and since with Git it is possible to rework 
the history as long at it is private, people frequently do it, so that 
the readers can get most out of it. (This is more akin to patch sets, 
where each patch does a certain thing -- versus work steps, which 
documents how you created the changes. The latter documentation is 
really only of interest for you, for others it's the intended changes 
which matter. So you could "git branch my_selinux_prepublish_1" to keep 
the latter history in case you want to look at it again later, then do 
the history cleanup as I've suggested and publish that instead. And 
continue to work on that reworked branch, actually.)

> Christian, have you been able to test the policy? I am very curious, how it works on other machines (say, gentoo) or with other setups (strict-policy is completely untested, although I don't think that anyone really uses it).

I don't have any SELinux setup here. I'm playing with the thought of 
looking into it, that's why the subject of your mail has catched my 
attention.

Thanks,
Christian.
