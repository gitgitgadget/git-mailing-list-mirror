From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 2/6] Makefile: Include subdirectories in "make cover" reports
Date: Sun, 25 Jul 2010 00:37:56 +0200
Message-ID: <201007250037.57086.trast@student.ethz.ch>
References: <1280004663-4887-1-git-send-email-avarab@gmail.com> <1280004663-4887-3-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 00:38:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcnM3-0001Jf-Ed
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 00:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810Ab0GXWh7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 18:37:59 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:50053 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752578Ab0GXWh6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jul 2010 18:37:58 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 25 Jul
 2010 00:37:57 +0200
Received: from thomas.localnet (217.162.250.31) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sun, 25 Jul
 2010 00:37:57 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.93; x86_64; ; )
In-Reply-To: <1280004663-4887-3-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151682>

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> The buildin/, xdiff/ and compat/ subdirectories weren't being include=
d
> in the gcov aggregation, nor were the files there being cleaned up.
[...]
>  coverage-clean:
> -	rm -f *.gcda *.gcno
> +	$(RM) *.gcov *.gcda *.gcno
> +	$(RM) builtin/*.gcov
> +	$(RM) builtin/*.gcda
> +	$(RM) builtin/*.gcno

By the same logic, the xdiff and compat directories should also be
included here.  Maybe also block-sha1?

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
