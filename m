From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH/RFC] tests: WIP Infrastructure for Git smoke testing
Date: Fri, 30 Jul 2010 00:11:50 +0200
Message-ID: <201007300011.50330.trast@student.ethz.ch>
References: <1280438455-16255-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 00:11:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OebKX-0005rz-Id
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 00:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573Ab0G2WLx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Jul 2010 18:11:53 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:40740 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752868Ab0G2WLw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jul 2010 18:11:52 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 30 Jul
 2010 00:11:51 +0200
Received: from thomas.site (84.74.100.241) by CAS22.d.ethz.ch (172.31.51.112)
 with Microsoft SMTP Server (TLS) id 14.0.702.0; Fri, 30 Jul 2010 00:11:50
 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <1280438455-16255-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152203>

=C6var Arnfj=F6r=F0 Bjarmason wrote:
>   - Is this worthwhile. Are there developers / packagers / other
>     interested parties here who'd be interested in actually running
>     smoke testers? It should be really easy to set one up.

I'm all for it!

I think I could put a cronjob on a RHEL5.4 machine, and regularly run
it on my own openSuSE 11.3 install.

> Tarball contents:
>=20
>     $ tar xzvf git-smoke.tar.gz
>     t0004-unwritable.sh
>     t0001-init.sh
>     t0002-gitfile.sh
>     t0005-signals.sh
>     t0000-basic.sh
>     t0003-attributes.sh
>     t0006-date.sh
>     meta.yml

That's the only thing I found confusing about this: why are they named
as if they were shellscripts?

Also, installing TAP::Harness::Archive was a bit hairy but that's
CPAN's fault...

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
