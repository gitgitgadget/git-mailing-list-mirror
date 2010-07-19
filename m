From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2] tests: rename test to work around GNU gettext bug
Date: Mon, 19 Jul 2010 22:38:57 +0200
Message-ID: <201007192238.57783.trast@student.ethz.ch>
References: <1279570409-5293-1-git-send-email-avarab@gmail.com> <1279571291-5555-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 19 22:39:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oax7X-0006Lq-7y
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 22:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966719Ab0GSUjW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jul 2010 16:39:22 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:46714 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936513Ab0GSUjV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jul 2010 16:39:21 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 19 Jul
 2010 22:39:20 +0200
Received: from thomas.localnet (84.74.100.241) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.0.702.0; Mon, 19 Jul
 2010 22:38:59 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.5; x86_64; ; )
In-Reply-To: <1279571291-5555-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151277>

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> t0200-gettext.sh matched the former broken check, so on systems with
> an old GNU gettext (like RHEL 5.4) the test simply printed:
>=20
>     ./t0200-gettext.sh
>     GNU gettext shell script function library version 0.14.6
>     Usage: . gettext.sh
>     FATAL: Unexpected exit with code 1

ACK and tested (on the RHEL5.4 that started this).  Thanks for the
help and fast fix!

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
