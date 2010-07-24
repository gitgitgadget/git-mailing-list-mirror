From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 4/6] Makefile: Add coverage-report-cover-db target
Date: Sun, 25 Jul 2010 01:01:26 +0200
Message-ID: <201007250101.26577.trast@student.ethz.ch>
References: <1280004663-4887-1-git-send-email-avarab@gmail.com> <1280004663-4887-5-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 01:01:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ocniw-0008RU-7H
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 01:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077Ab0GXXB2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 19:01:28 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:14094 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753024Ab0GXXB1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jul 2010 19:01:27 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 25 Jul
 2010 01:01:26 +0200
Received: from thomas.localnet (217.162.250.31) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sun, 25 Jul
 2010 01:01:25 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.93; x86_64; ; )
In-Reply-To: <1280004663-4887-5-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151683>

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> +
> +coverage-report-cover-db:
> +	gcov2perl -db cover_db *.gcov

I think this either needs a dependency or .PHONY.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
