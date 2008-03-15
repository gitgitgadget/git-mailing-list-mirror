From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Update Japanese translation
Date: Sat, 15 Mar 2008 02:27:35 -0400
Message-ID: <20080315062734.GG8410@spearce.org>
References: <200803141303.m2ED3nUj016918@mi1.bluebottle.com> <20080315050840.GF8410@spearce.org> <7vlk4ko7px.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 15 07:28:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaPsR-0006NH-MI
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 07:28:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbYCOG1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 02:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbYCOG1l
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 02:27:41 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49474 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbYCOG1k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 02:27:40 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JaPrj-0006RX-Nf; Sat, 15 Mar 2008 02:27:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 15B8320FBAE; Sat, 15 Mar 2008 02:27:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vlk4ko7px.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77314>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> >>  "Report-Msgid-Bugs-To: \n"
> >> -"POT-Creation-Date: 2007-11-24 10:36+0100\n"
> >> -"PO-Revision-Date: 2007-12-05 06:12+0900\n"
> >> +"POT-Creation-Date: 2008-02-16 21:24+0100\n"
> >> +"PO-Revision-Date: 2008-03-14 20:32+0900\n"
> >
> > Unfortunately this patch does not apply after Peter's regeneration
> > of the POT file (0212242d66):
> >
> >   "POT-Creation-Date: 2008-03-14 07:18+0100\n"
> 
> Here is the guide to your translators, in your po/README:
 
>             $ msgmerge -U po/af.po po/git-gui.pot

Gah, I forgot about that.
 
> Shawn, I think you guys should nail down the workflow right first, and
> then mention the above a bit more prominently to avoid future accidents
> like this.
> 
> It is perfectly fine if Peter regenerated the POT file for everybody as
> the i18n coordinator, but the thing is, I think that regeneration should
> have been done *before* you asked for translators to send in the
> translation updates, not _after_ they have fetched from you in response to
> your call for help and started working.

Yes.  I clearly dropped the ball on that one.  I did try by asking
for assistance _before_ a tagged release, but I failed to make sure
the POT was up to date first.

> It appears the patch was done on top of 48ed49f, so I would imagine a
> sensible approach would be for _you_ to do:
> 
>     $ git checkout 48ed49f
...
>     $ msgmerge -U po/ja.po po/git-gui.pot
>     $ git commit -m 'Adjusted older translation to updated POT' po/ja.po

Done, and now on repo.or.cz, master branch.  I did actually try to
go back to that version, apply it, and merge it forward, but I forgot
about msgmerge as a means of dealing with a conflicted PO file.

> Then ask Nana to re-fetch and fix that up.  At least that would reduce the
> need for re-translation.

Nana, hopefully a re-fetch will be easier to fix up.  :)

-- 
Shawn.
