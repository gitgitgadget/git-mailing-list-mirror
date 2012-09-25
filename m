From: Max Horn <postbox@quendi.de>
Subject: Re: Can git pull from a mercurial repository?
Date: Tue, 25 Sep 2012 16:15:18 +0200
Message-ID: <37D17798-4BDC-433D-A9B4-49F4352754D9@quendi.de>
References: <k39lir$gpm$1@ger.gmane.org> <50585F10.3080307@op5.se> <000a01cd959a$d8cd0730$8a671590$@schmitz-digital.de>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "'Andreas Ericsson'" <ae@op5.se>, <git@vger.kernel.org>
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Tue Sep 25 16:40:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGWJZ-0000Oo-C6
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 16:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755002Ab2IYOkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 10:40:36 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:41139 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752501Ab2IYOkf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 10:40:35 -0400
X-Greylist: delayed 1512 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Sep 2012 10:40:35 EDT
Received: from 77-22-74-244-dynip.superkabel.de ([77.22.74.244] helo=zanovar.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1TGVux-0001w8-0j; Tue, 25 Sep 2012 16:15:19 +0200
In-Reply-To: <000a01cd959a$d8cd0730$8a671590$@schmitz-digital.de>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;postbox@quendi.de;1348584035;2657c9d4;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206360>

Hi there,


On 18.09.2012, at 14:40, Joachim Schmitz wrote:

>> From: Andreas Ericsson [mailto:ae@op5.se]
>> Sent: Tuesday, September 18, 2012 1:46 PM
>> To: Joachim Schmitz
>> Cc: git@vger.kernel.org
>> Subject: Re: Can git pull from a mercurial repository?
>> 
>> On 09/18/2012 01:22 PM, Joachim Schmitz wrote:
>>> Is there an easy way to get git to clone/pull from a Mercurial repository?
>>> 
>> 
>> Yes. Google "git remote helpers" and you'll most likely find it.
> 
> Well, I found a few. No idea how to get them to work though (so far for the 'easy' part of my question)

I think there is a lot of demand for a "git-hg" bridge, a way to seemlessly access a Mercurial repository as if it was a git repository. A converse to hg-git <http://hg-git.github.com/>

As you discovered, there are several attempts to this. A recent overview over some of them can be found here:

  https://github.com/dubiousjim/yagh/blob/master/README.md

Another remark:


> 
> It seems https://github.com/rfk/git-remote-hg requires Python 2.5 (and I only have 2.4), also I have no idea how to get it installed
> https://github.com/SRabbelier/git is 3 years old, apparently never made it into git, guess for a reason? 
> Then I found https://github.com/fingolfin/git/commits/remote-hg, looks very confusing to me...

This is mine, and I am sorry that it causes confusion -- but in fact, my goal it is kind of a continuation of the https://github.com/SRabbelier/git code. OR rather, it collects code others wrote to improve that codebase, and I just added a few fixes that made it work for me.

In particular, I tried to figure out the reasons for why it never made it into git, and in the process, created this Wiki page: <https://github.com/msysgit/msysgit/wiki/Guide-to-git-remote-hg>. Which attempts to document how to use this code, and what needs to be done. My hope was that perhaps more people would be interested in this, and in helping out with it, but so far no such luck. 

My goals were noble, but you are the second person who considers this work to be confusing, so if that is what the majority thinks, I am willing to remove that text again (or rather, hide it away in some private repository).


Cheers,
Max