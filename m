From: Lukasz Palczewski <l.palczewski@prevac.pl>
Subject: Re: Restart submodule update --recursive
Date: Tue, 02 Nov 2010 09:18:19 +0100
Message-ID: <4CCFC94B.2010708@prevac.pl>
References: <loom.20101028T090353-376@post.gmane.org> <20101028181515.GB14212@burratino> <loom.20101029T085153-262@post.gmane.org> <20101029091202.GA26442@burratino>, <4CCAB20A.1000408@prevac.pl> <212962199.646095.1288423075790.JavaMail.fmail@mwmweb046>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 02 09:19:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDC5N-0003nw-OU
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 09:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805Ab0KBITL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 04:19:11 -0400
Received: from mailmxout.mailmx.agnat.pl ([193.239.44.238]:44134 "EHLO
	mailmxout.mailmx.agnat.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715Ab0KBITJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 04:19:09 -0400
Received: from smtp.agnat.pl ([193.239.44.82])
	by mailmxout.mailmx.agnat.pl with esmtp (Exim 4.72)
	(envelope-from <l.palczewski@prevac.pl>)
	id 1PDC5B-00074g-6i
	for git@vger.kernel.org; Tue, 02 Nov 2010 09:19:05 +0100
Received: from [83.18.121.37] (helo=mail.prevac.pl)
	by smtp.agnat.pl with esmtpa (Exim 4.71)
	(envelope-from <l.palczewski@prevac.pl>)
	id 1PDC5B-000746-0z
	for git@vger.kernel.org; Tue, 02 Nov 2010 09:19:05 +0100
Received: (qmail 20258 invoked by uid 1008); 2 Nov 2010 09:19:04 +0100
Received: from jlatkowski.prevac.eu.local (HELO ?127.0.0.1?) (prevac0005@192.168.0.91)
  by mail.prevac.pl with SMTP; 2 Nov 2010 09:19:04 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; pl; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <212962199.646095.1288423075790.JavaMail.fmail@mwmweb046>
X-Authenticated-Id: prevac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160507>

Jens Lehmann wrote:
>> Let me know if this change will be in next version of git.
> Sorry I'm coming late into this thread,but I'm still traveling.
>
> Lukasz, maybe you could wait until I finish the recursive checkout I am
> currently working on? Because then there will be no need to run
> "git submodule update" anymore, but "git checkout" will update
> submodules recursively too. And it will only fail if the checkout would
> overwrite your local modifications, not just because the submodule is
> modified in some way, and in this case it won't start at all instead of stopping
> somewhere in between (you can test that new behavior by checking
> out the branch "enhance_git_for_submodules" of my github repo:
> http://github.com/jlehmann/git-submod-enhancements ).
>
> Would that solve your problem?

Hi Jens,
Well I will wait for it and see if it does, but it will not solve all 
the problems.
Once I had a problem, when someone forgot to push a commit in the 
submodule, but pushed a commit in the main repository. Becouse of it, I 
could not update that repository. If this problem occours, I will have 
to update all the submodules with the one command "git submodules update 
--recursive" (when someone finally pushes the submodule). If the "git 
checkout" updates the rest ( not updated) submodules, but not check the 
ones, that were updated earlier, then it will work for me.
