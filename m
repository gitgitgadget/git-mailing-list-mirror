From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: [PATCH] git add -e documentation: rephrase note
Date: Mon, 19 Oct 2009 11:42:03 -0600
Organization: icecavern.net
Message-ID: <200910191142.03446.wjl@icecavern.net>
References: <20091014222628.GK6115@genesis.frugalware.org> <20091019063446.GA1457@coredump.intra.peff.net> <7vaazn7tg4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Miklos Vajna <vmiklos@frugalware.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 19:42:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzwFY-0006b2-1q
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 19:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545AbZJSRmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 13:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbZJSRmQ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 13:42:16 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:37166 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753787AbZJSRmP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 13:42:15 -0400
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 4B429359E4;
	Mon, 19 Oct 2009 19:42:15 +0200 (CEST)
User-Agent: KMail/1.12.0 (Linux/2.6.29-2-amd64; KDE/4.3.0; x86_64; ; )
In-Reply-To: <7vaazn7tg4.fsf@alter.siamese.dyndns.org>
X-Face: #;qMWg=Msk*d]z]X1P2-t9]~6+RoGF$nJo89f%|Y`^whfl3Wj$X2Q_1u)ZAW@Hx|g)J]!)
 =?utf-8?q?=0A=09Br0=3FK3Imj?=)np=]r*QN,Q8].V99^Og'xl-d9FM~$yaSGB"mfXb>x[QNi[()
 =?utf-8?q?oob=60/4M42=26We=0A=09cC1jq=3DQ=5CS?=@ck\>H@
 =?utf-8?q?t=26Y7Y=3Apub=3DHOWqY=7D-d=5CwrCxvsTo7k1Ek=7DqQO=5D5=7EngK=5E=25?=
 =?utf-8?q?cT5IzmmG=5BQ=0A=09Nha=7D=5DAmI=60R-6m84VcWT4=236c?=)1`>t{$~l6:gZMtv18ge'!d[Yk-/?T3>C5O-|6On4(
 =?utf-8?q?N=7BAV=23=0A=094Eyw52=5B=3A=25Z?=>#"c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130719>

On Monday 19 October 2009 01:07:23 Junio C Hamano wrote:
> That is Ok; the comment was not about stage vs add.
>
> > But beyond that, yes, you are right that removing a "+" line may have a
> > different conceptual meaning to the user depending on the surrounding
> > text. I wonder if such a "check-list" document really makes much sense,
> > given that using "-e" at all means you need to understand the patch
> > format and what makes sense (i.e., anybody who understands 'patch'
> > knows that you can't just delete context lines and expect it to apply).
>
> Yeah, that is really what I wanted people who are in this discussion to
> eventually realize ;-)

Comment from the peanut gallery:

I still think a quick summary checklist is useful even for a seasoned 
developer that is intimate with the 'patch' format, as it lets users know 
what git will do with your patch modifications.

For example, when I first tried "add -e", my first thought was: "Awesome, 
but, I wonder if git will do the right thing if I modify the patch in THIS 
way ...". Fortunately, git did the right thing, but I wasn't really sure 
until I tried it.
