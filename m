From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH av/i18n 2/2] Make git-sh-i18n executable
Date: Sun, 25 Jul 2010 15:15:08 +0200
Message-ID: <201007251515.08916.trast@student.ethz.ch>
References: <ba054975988a4a799bcd81a74acd865815ae9bf5.1280051448.git.trast@student.ethz.ch> <d890d9ba7d967e6a191cb47194379d8f9ca5cd0d.1280051448.git.trast@student.ethz.ch> <AANLkTimpqw2RirLPDJkAhQIql793nwC9pc0HctIcxKKj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 15:15:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od13H-00087e-Ji
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 15:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517Ab0GYNPb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 09:15:31 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:59774 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150Ab0GYNPa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jul 2010 09:15:30 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 25 Jul
 2010 15:15:28 +0200
Received: from thomas.localnet (217.162.250.31) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sun, 25 Jul
 2010 15:15:07 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.93; x86_64; ; )
In-Reply-To: <AANLkTimpqw2RirLPDJkAhQIql793nwC9pc0HctIcxKKj@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151742>

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> Why is it including git-sh-i18n.sh? It should only be using the
> generated SCRIPT_LIB git-sh-i18n file.
>=20
> On my system the executable bit of git-sh-i18n.sh has no effect on th=
e
> generated git-sh-i18n file:

Hmph, you're right.  I'd have to move it into the SCRIPT_SH category
instead of SCRIPT_LIB to affect the executable bit.

Back to the drawing board I guess...

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
