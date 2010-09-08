From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [BUG] git-send-email format-patch awareness & retry
Date: Wed, 8 Sep 2010 11:14:18 +0200
Message-ID: <201009081114.18263.trast@student.ethz.ch>
References: <AANLkTimtOguHdcs+QYj7ePNeyMNsWYLDu+yfyOPrDWUG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ryan Anderson <ryan@michonline.com>, Greg KH <greg@kroah.com>
To: =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 11:14:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtGjz-0004Zp-GT
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 11:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758574Ab0IHJOn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 05:14:43 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:39611 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752714Ab0IHJOl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Sep 2010 05:14:41 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 8 Sep
 2010 11:14:41 +0200
Received: from thomas.site (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.0.702.0; Wed, 8 Sep
 2010 11:14:18 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <AANLkTimtOguHdcs+QYj7ePNeyMNsWYLDu+yfyOPrDWUG@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155775>

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> (cc primary authors & Junio)
>=20
> This is more of a TODO note to myself than a bug, but if someone else
> gets around to fixing these that'd be great too.
>=20
> git-send-email should:
>=20
>  * Complain loudly on "*** SUBJECT HERE ***" and "*** BLURB HERE ***"
>=20
>    This should have an additional "are you sure" dialog:
>=20
>     Subject: [PATCH 00/20] *** SUBJECT HERE ***
>     Date: Tue,  7 Sep 2010 16:43:03 +0000
>     Message-Id: <1283877803-17757-1-git-send-email-avarab@gmail.com>
>     X-Mailer: git-send-email 1.7.2.3.313.gcd15
>     MIME-Version: 1.0
>     Content-Type: text/plain; charset=3DUTF-8
>     Content-Transfer-Encoding: 8bit
>=20
>     Send this email? ([y]es|[n]o|[q]uit|[a]ll): y
>     Password:

You could resurrect

  http://mid.gmane.org/7fedc4b76fed03e4db6a2bb7453609c9cd02928a.1244496=
564.git.trast@student.ethz.ch

though on re-reading I'm not so sure anymore that *any* complaints
remained.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
