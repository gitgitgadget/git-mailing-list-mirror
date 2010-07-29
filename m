From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] checkout: add a test for creating a new branch with regexp as a starting point
Date: Fri, 30 Jul 2010 01:36:13 +0200
Message-ID: <201007300136.13501.trast@student.ethz.ch>
References: <20100729220111.GA28176@wo.int.altlinux.org> <AANLkTi=Qf1OUmjkpL-6e8gT8MU9G=m37sxrdAoyj5=R0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Dmitry V. Levin" <ldv@altlinux.org>, <git@vger.kernel.org>
To: =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 01:36:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oecee-0001T4-LM
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 01:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758142Ab0G2Xgh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Jul 2010 19:36:37 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:46660 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755459Ab0G2Xgg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jul 2010 19:36:36 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 30 Jul
 2010 01:36:35 +0200
Received: from thomas.site (129.132.208.181) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.0.702.0; Fri, 30 Jul
 2010 01:36:14 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <AANLkTi=Qf1OUmjkpL-6e8gT8MU9G=m37sxrdAoyj5=R0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152210>

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> On Thu, Jul 29, 2010 at 22:01, Dmitry V. Levin <ldv@altlinux.org> wro=
te:
> > +test_expect_success checkout '
> > +       git checkout -b new_branch :/first
> > +'
> > +
> > +test_done
>=20
> ...it looks like this can just be added to the end of
> t2018-checkout-branch.sh instead of creating a new test. Creating a
> new file just for a single test for such a simple feature is a bit of
> an overkill.

It should also use test_expect_failure unless you expect to have a fix
soon, otherwise it would stop the test suite from running through.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
