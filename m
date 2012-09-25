From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: Can git pull from a mercurial repository?
Date: Tue, 25 Sep 2012 16:42:35 +0200
Message-ID: <002401cd9b2c$0168bcc0$043a3640$@schmitz-digital.de>
References: <k39lir$gpm$1@ger.gmane.org> <50585F10.3080307@op5.se> <000a01cd959a$d8cd0730$8a671590$@schmitz-digital.de> <37D17798-4BDC-433D-A9B4-49F4352754D9@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Andreas Ericsson'" <ae@op5.se>, <git@vger.kernel.org>
To: "'Max Horn'" <postbox@quendi.de>
X-From: git-owner@vger.kernel.org Tue Sep 25 16:42:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGWLi-0001bi-QQ
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 16:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852Ab2IYOmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 10:42:50 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:54335 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603Ab2IYOmt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 10:42:49 -0400
Received: from DualCore (dsdf-4db53c2e.pool.mediaWays.net [77.181.60.46])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0La0V7-1Tjr0k0GE9-00lOgM; Tue, 25 Sep 2012 16:42:47 +0200
In-Reply-To: <37D17798-4BDC-433D-A9B4-49F4352754D9@quendi.de>
X-Mailer: Microsoft Outlook 14.0
thread-index: AQGhEpNGyEwugTaQMUDb1fc5WliObQHoH3lpAwxm1UkBakq6SJfBN2Zg
Content-Language: de
X-Provags-ID: V02:K0:kg6ksJZNySn7ZviNPXN7rgLmn1h3NjO0BcHzJR6BZUY
 2Qz510vyCYFEySKmCIe9nwKXlKt3Dljd1IuJMPCtJ0LPTZsQ1W
 zx9PbmKg13vH1Y7stD6IQemAd6I2p5uMqZJeeFHVC6yQKykczV
 HXWH70DDdi+u5YSB0qdr2iD3+Dd1/+bS+/78rjaXxoQl0tff7W
 v5fQT4E6NkmF40gG82uAbOaMsSJDvBKLPR3w71IotlhXF8IITJ
 hU/y8YMEk7cTwCTBMDdFT/3LDfDULwl1fMFiP0L+dAaOxS9rv5
 KWfiPPhrkQviduD7TdRWdsk6CAw1GKtKw8EieyqfquZjtaeuXF
 +N3vmZjp1pM7FO3tfam2NgcL/70pG0smXdL005/nA9B5kkenVe
 thUd2X+eje1+Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206361>

> From: Max Horn [mailto:postbox@quendi.de]
> Sent: Tuesday, September 25, 2012 4:15 PM
> To: Joachim Schmitz
> Cc: 'Andreas Ericsson'; git@vger.kernel.org
> Subject: Re: Can git pull from a mercurial repository?
> 
> Hi there,
> 
> 
> On 18.09.2012, at 14:40, Joachim Schmitz wrote:
> 
> >> From: Andreas Ericsson [mailto:ae@op5.se]
> >> Sent: Tuesday, September 18, 2012 1:46 PM
> >> To: Joachim Schmitz
> >> Cc: git@vger.kernel.org
> >> Subject: Re: Can git pull from a mercurial repository?
> >>
> >> On 09/18/2012 01:22 PM, Joachim Schmitz wrote:
> >>> Is there an easy way to get git to clone/pull from a Mercurial repository?
> >>>
> >>
> >> Yes. Google "git remote helpers" and you'll most likely find it.
> >
> > Well, I found a few. No idea how to get them to work though (so far for the 'easy' part of my question)
> 
> I think there is a lot of demand for a "git-hg" bridge, a way to seemlessly access a Mercurial repository as if it was a git
repository. A
> converse to hg-git <http://hg-git.github.com/>
> 
> As you discovered, there are several attempts to this. A recent overview over some of them can be found here:
> 
>   https://github.com/dubiousjim/yagh/blob/master/README.md
> 
> Another remark:
> 
> 
> >
> > It seems https://github.com/rfk/git-remote-hg requires Python 2.5 (and I only have 2.4), also I have no idea how to get it
installed
> > https://github.com/SRabbelier/git is 3 years old, apparently never made it into git, guess for a reason?
> > Then I found https://github.com/fingolfin/git/commits/remote-hg, looks very confusing to me...
> 
> This is mine, and I am sorry that it causes confusion -- but in fact, my goal it is kind of a continuation of the
> https://github.com/SRabbelier/git code. OR rather, it collects code others wrote to improve that codebase, and I just added a few
fixes
> that made it work for me.
> 
> In particular, I tried to figure out the reasons for why it never made it into git, and in the process, created this Wiki page:
> <https://github.com/msysgit/msysgit/wiki/Guide-to-git-remote-hg>. Which attempts to document how to use this code, and what needs
to
> be done. My hope was that perhaps more people would be interested in this, and in helping out with it, but so far no such luck.

Ah, with that pages it gets much clearer! Only how should anyone know that https://github.com/fingolfin/git/commits/remote-hg is
related in any form or shape with https://github.com/msysgit/msysgit/wiki/Guide-to-git-remote-hg?
I'm afraid it still won't help me much though, as I guess it too requites Python 2.5 or later, as it uses the Mercuroal Python API
(and that actually may be the reason why it never made it into git? I believe to have read somewhere that git tries to restrict
itself to Python 2.4)

> My goals were noble, but you are the second person who considers this work to be confusing, so if that is what the majority
thinks, I am
> willing to remove that text again (or rather, hide it away in some private repository).

No, please don't. Rather make that clear on https://github.com/fingolfin/git/commits/remote-hg ...

Bye, Jojo
