From: Yann Dirson <ydirson@free.fr>
Subject: Re: What's cooking in git.git (Nov 2010, #01; Tue, 9)
Date: Wed, 10 Nov 2010 21:35:16 +0100
Message-ID: <20101110203516.GE8911@home.lan>
References: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
 <AANLkTi=F6768YZdR4H-vcnHgknV=roHG249dzbNRJVXR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 21:35:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGHOD-0005kS-SO
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 21:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172Ab0KJUfZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Nov 2010 15:35:25 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:41191 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755341Ab0KJUfY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 15:35:24 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 7B700D48131;
	Wed, 10 Nov 2010 21:35:17 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PGHO0-0005TH-9u; Wed, 10 Nov 2010 21:35:16 +0100
Content-Disposition: inline
In-Reply-To: <AANLkTi=F6768YZdR4H-vcnHgknV=roHG249dzbNRJVXR@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161183>

On Tue, Nov 09, 2010 at 11:17:07PM +0100, Erik Faye-Lund wrote:
> On Tue, Nov 9, 2010 at 8:53 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> > * yd/dir-rename (2010-10-29) 5 commits
> > =A0- Allow hiding renames of individual files involved in a directo=
ry rename.
> > =A0- Unified diff output format for bulk moves.
> > =A0- Add testcases for the --detect-bulk-moves diffcore flag.
> > =A0- Raw diff output format for bulk moves.
> > =A0- Introduce bulk-move detection in diffcore.
> >
>=20
> This series currently breaks the Windows build of 'pu', as we lack
> memrchr there. Jonathan Nieder posted a patch
> (<20101015051750.GA21830@burratino>) that adds a memrchr
> implementation. This should probably either be rebased on top of that
> patch, or re-rolled.
>=20
> While 'pu' not building on Windows might not be a big deal, it's wort=
h
> keeping in mind before merging it further.

If you plan to re-roll the series as it is, you may want to consider
the latest update to the 1st patch in the series.  I had not resent
the whole series just for that.

http://marc.info/?l=3Dgit&m=3D128890797304674

OTOH, you may want to wait for the next iteration, which should be
ready by the end of the week.
