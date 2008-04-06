From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add interactive option in rebase command completion list.
Date: Sun, 6 Apr 2008 15:09:27 -0400
Message-ID: <20080406190927.GH10274@spearce.org>
References: <1207503144-3008-1-git-send-email-pascal@obry.net> <7vprt2sv60.fsf@gitster.siamese.dyndns.org> <47F91A77.5080207@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Pascal Obry <pascal.obry@gmail.com>, git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Sun Apr 06 21:10:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiaG0-0003cT-0C
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 21:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbYDFTJl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Apr 2008 15:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752439AbYDFTJl
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 15:09:41 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60196 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbYDFTJk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2008 15:09:40 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JiaEz-0001HZ-Fm; Sun, 06 Apr 2008 15:09:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D9EE720FBAE; Sun,  6 Apr 2008 15:09:27 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <47F91A77.5080207@obry.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78916>

Pascal Obry <pascal@obry.net> wrote:
> Junio C Hamano a =C3=A9crit :
> >Pascal Obry <pascal.obry@gmail.com> writes:
> >
> >>-		__gitcomp "--onto --merge --strategy"
> >>+		__gitcomp "--onto --merge --strategy --interactive"
> >
> >I personally do not think this is worth it where a single "-i" is en=
ough.
>=20
> I like unambiguous name (I do prefer --interactive instead of -i). It=
 is=20
> painful to enter so the bash completion come quite handy here. The pa=
tch=20
> is safe, simple and clean, I see no reason to not include it.

I agree with Pascal here, include the option.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

--=20
Shawn.
