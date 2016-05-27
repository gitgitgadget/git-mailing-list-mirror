From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: t7800 test failure
Date: Fri, 27 May 2016 09:48:27 +0200
Message-ID: <vpq4m9kvt4k.fsf@anie.imag.fr>
References: <CALR6jEiJwx14zAyond9ggz29Q64Fz84URtjr8zaddjnrdY7TjA@mail.gmail.com>
	<vpqk2ijs8p2.fsf@anie.imag.fr>
	<xmqq1t4r75sv.fsf@gitster.mtv.corp.google.com>
	<CALR6jEj67MA7CCHQ_jfdtAuGoo9wjPie0+a=e-BqJjoYtJ9oHw@mail.gmail.com>
	<xmqqfut75peg.fsf@gitster.mtv.corp.google.com>
	<CALR6jEixZitA1CTE_kDkDEHv59ALT9zkCOgd28unMhLUZKt48Q@mail.gmail.com>
	<20160527041944.GA17438@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 27 09:48:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6CVp-0002ZB-20
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 09:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbcE0Hst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 03:48:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56659 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932088AbcE0Hss (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 03:48:48 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u4R7mQSd019215
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 27 May 2016 09:48:26 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4R7mRbO000688;
	Fri, 27 May 2016 09:48:27 +0200
In-Reply-To: <20160527041944.GA17438@gmail.com> (David Aguilar's message of
	"Thu, 26 May 2016 21:19:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Fri, 27 May 2016 09:48:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4R7mQSd019215
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1464940107.69517@QZbfn5n1v6rNSbA275dzXA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295742>

David Aguilar <davvid@gmail.com> writes:

> Another alternative is that we can compile our own
> "git-readlink" and "git-mktemp" programs and use those instead,
> but that seems like a big maintenance burden compared to the
> relative simplicity of the test-suite workarounds.

Not _that_ big burden as we already have the necessary infrastructure:
git-mktemp would be t/helper/test-mktemp.c already available to tests as
test-mktemp, and it would be easy to do it for readlink too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
