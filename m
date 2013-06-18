From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] send-email: allow use of basic email list in --cc --to and --bcc
Date: Tue, 18 Jun 2013 13:06:36 +0200
Message-ID: <vpq1u7zu18j.fsf@anie.imag.fr>
References: <1371549079-19291-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
	<CALkWK0=vytkxM3yzVaed+i3Q+RpvH=tSLndf=vUmiYC=sn=nFg@mail.gmail.com>
	<0ad4bd4930efddcbaa5ed958c6758894@ensibm.imag.fr>
	<CALkWK0nqQt9mP95NKnyucdAxXekj+OFsp5XsF8wXxoCRjLNbvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mathieu =?iso-8859-1?Q?Li=E9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr, git@vger.kernel.org,
	gitster@pobox.com,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 13:06:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UotkM-00057W-5Z
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 13:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466Ab3FRLGm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 07:06:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34656 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752411Ab3FRLGl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 07:06:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5IB6Z9x023056
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Jun 2013 13:06:35 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UotkC-0000B0-VA; Tue, 18 Jun 2013 13:06:36 +0200
In-Reply-To: <CALkWK0nqQt9mP95NKnyucdAxXekj+OFsp5XsF8wXxoCRjLNbvg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 18 Jun 2013 16:28:50 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 18 Jun 2013 13:06:36 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228196>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Mathieu Li=E9nard--Mayor wrote:
>> Shouldn't
>>
>> $ git send-email --cc 'foo@example.com' --cc 'bar@example.com'
>>
>> and
>>
>> $ git send-email --cc 'foo@example.com, bar@example.com'
>>
>> have the exact same effect ?
>
> Ah.  Perhaps it would be clearer to check the headers directly like i=
n
> the other tests?

Actually, I find it more elegant like this: it doesn't rely on the
particular layout of headers, so the tests would still pass if somethin=
g
else is changed in the headers.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
