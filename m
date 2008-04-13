From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH/RFC 01/10] Teach rebase interactive the mark command
Date: Sat, 12 Apr 2008 23:56:48 -0400
Message-ID: <20080413035648.GY10274@spearce.org>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <1207785521-27742-1-git-send-email-joerg@alea.gnuu.de> <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de> <7vskxsneau.fsf@gitster.siamese.dyndns.org> <20080412101110.GD31356@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: =?utf-8?B?SsO2cmc=?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Sun Apr 13 05:57:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JktLc-0001H3-Lr
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 05:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351AbYDMD4z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Apr 2008 23:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755343AbYDMD4z
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 23:56:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44582 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755092AbYDMD4y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Apr 2008 23:56:54 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JktKY-0003Fb-CO; Sat, 12 Apr 2008 23:56:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F3D4B20FBAE; Sat, 12 Apr 2008 23:56:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080412101110.GD31356@alea.gnuu.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79389>

Jrg Sommer <joerg@alea.gnuu.de> wrote:
> > Wouldn't
> >=20
> > 	pick 5cc8f37 (init: show "Reinit" message even in ...)
> > 	mark 1
> > 	pick 18d077c (quiltimport: fix misquoting of parse...)
> > 	mark 2
> > 	reset 1
>=20
> =E2=80=9Creset 18d077c~2=E2=80=9D or =E2=80=9Creset some-tag=E2=80=9D=
 or =E2=80=9Creset my-branch~12=E2=80=9D
>=20
> >         merge #2
> >=20
> > be easier for people?
>=20
> I don't know. Using the special sign everywhere a mark is used looks =
more
> consistent to me. The only case where it might be omitted is the mark
> command, because it only uses marks.

Why not use the mark syntax that fast-import uses?  In fast-import
we use ":n" anytime we need to refer to a mark, e.g. ":1" or ":5".
Its the same idea.  We already have a language for it.  Heck, the
commands above are bordering on a language not too far from the
one that fast-import accepts.  :-)

--=20
Shawn.
