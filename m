From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Authentication support for pserver
Date: Fri, 14 Dec 2007 00:44:27 -0500
Message-ID: <20071214054427.GE14735@spearce.org>
References: <87wsrhex4c.fsf@cpan.org> <7vd4t9x2lw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avar@cpan.org>,
	git@vger.kernel.org, martyn@catalyst.net.nz, martin@catalyst.net.nz
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 06:45:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J33MH-000224-1g
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 06:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbXLNFoq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 00:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbXLNFoq
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 00:44:46 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35547 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbXLNFoq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Dec 2007 00:44:46 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1J33LY-0001bJ-Im; Fri, 14 Dec 2007 00:44:28 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7236120FBAE; Fri, 14 Dec 2007 00:44:27 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vd4t9x2lw.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68228>

Junio C Hamano <gitster@pobox.com> wrote:
> avar@cpan.org (=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason) writes:
> > +
> > +    # This should never happen, the same format has been used sinc=
e
> > +    # CVS was spawned
> > +    $str =3D~ s/^(.)//;
> > +    die "invalid password format $1" unless $1 eq 'A';
>=20
> I do not quite understand what "spawn" means in this sentence.

spawned: since it came from the depths of hell and cursed all
         developers, until the day Git was born.  :-)

--=20
Shawn.
