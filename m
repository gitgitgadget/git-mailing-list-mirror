From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 1/2] t1501: avoid bashisms
Date: Sat, 25 Dec 2010 15:12:26 +0100
Message-ID: <m2aajudjqt.fsf@whitebox.home>
References: <1293285457-11915-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michel Briand <michelbriand@free.fr>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 25 15:13:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWUsQ-0003us-2U
	for gcvg-git-2@lo.gmane.org; Sat, 25 Dec 2010 15:13:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841Ab0LYOMc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Dec 2010 09:12:32 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:35538 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707Ab0LYOMb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Dec 2010 09:12:31 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 205971C017E1;
	Sat, 25 Dec 2010 15:12:29 +0100 (CET)
X-Auth-Info: PBJMQQ9eGfdMRwIwWdNf+Y960ErG/uIRdpgC0orcY8E=
Received: from linux.local (p508B14C8.dip.t-dialin.net [80.139.20.200])
	by mail.mnet-online.de (Postfix) with ESMTPA id 0B8FE1C001FA;
	Sat, 25 Dec 2010 15:12:29 +0100 (CET)
Received: by linux.local (Postfix, from userid 501)
	id DADE71E52EC; Sat, 25 Dec 2010 15:12:26 +0100 (CET)
X-Yow: KARL MALDEN'S NOSE just won an ACADEMY AWARD!!
In-Reply-To: <1293285457-11915-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 25
 Dec 2010 20:57:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164179>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> @@ -322,7 +322,10 @@ test_expect_success 'git grep' '
>  test_expect_success 'git commit' '
>  	(
>  		cd repo.git &&
> -		GIT_DIR=3D. GIT_WORK_TREE=3Dwork git commit -a -m done

In which way is that not portable?

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
