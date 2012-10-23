From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Launch separate program for HTTPS prompt
Date: Tue, 23 Oct 2012 16:48:46 +0200
Message-ID: <vpq6261nt0x.fsf@grenoble-inp.fr>
References: <CAHtLG6QY-PYUKbNUicox_Ayh70bUSJOL7LGZrQQMqgbVBDmEiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 16:49:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQfmw-0004qf-VL
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 16:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582Ab2JWOsv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Oct 2012 10:48:51 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55043 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754994Ab2JWOsu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 10:48:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q9NEfKJ1001873
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 23 Oct 2012 16:41:20 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TQfmh-0002nQ-5v; Tue, 23 Oct 2012 16:48:47 +0200
In-Reply-To: <CAHtLG6QY-PYUKbNUicox_Ayh70bUSJOL7LGZrQQMqgbVBDmEiA@mail.gmail.com>
	(=?utf-8?B?IuS5memFuOmLsCIncw==?= message of "Tue, 23 Oct 2012 22:39:20
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 23 Oct 2012 16:41:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q9NEfKJ1001873
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1351608082.05086@NCCf7N+PlqGK6A+joUWAcQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208231>

=E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@gmail.com> writes:

> Hi,
>
> Could you launch a separate program for HTTPS prompt like SSH_ASKPASS=
?
> This allows GUI programs to answer the trust or not, not via stdin.

Read about credential helpers, this is what they are meant for, and the=
y
do launch separate programs.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
