From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/6] t1006 (cat-file): use test_cmp
Date: Thu, 08 Dec 2011 14:41:45 +0100
Message-ID: <vpqty5bp4di.fsf@bauges.imag.fr>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
	<1323349817-15737-6-git-send-email-artagnon@gmail.com>
	<vpqiplrchvi.fsf@bauges.imag.fr>
	<CALkWK0=NFxAqmOkObqjVmBQ-TQ=hZhWi=ZScMEGibvS2Pu+XqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 14:41:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYeEX-0007RD-5y
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 14:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091Ab1LHNlx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Dec 2011 08:41:53 -0500
Received: from mx1.imag.fr ([129.88.30.5]:55240 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796Ab1LHNlw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 08:41:52 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id pB8Da9W0031133
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 8 Dec 2011 14:36:09 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RYeEM-000533-DJ; Thu, 08 Dec 2011 14:41:46 +0100
In-Reply-To: <CALkWK0=NFxAqmOkObqjVmBQ-TQ=hZhWi=ZScMEGibvS2Pu+XqQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 8 Dec 2011 19:03:19 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 08 Dec 2011 14:36:09 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: pB8Da9W0031133
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1323956171.47472@6mJt6v5I3MC/Xzfxv9QOoA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186565>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Hi Matthieu,
>
> Matthieu Moy wrote:
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>
>>> =A0test_expect_success "--batch-check with multiple sha1s gives cor=
rect format" '
>>> - =A0 =A0test "$batch_check_output" =3D \
>>> - =A0 =A0"$(echo_without_newline "$batch_check_input" | git cat-fil=
e
>>> --batch-check)"
>>> + =A0 =A0echo "$batch_check_output" >expect &&
>>> + =A0 =A0echo_without_newline "$batch_check_input" | git cat-file
>>> + --batch-check >actual &&
>>> + =A0 =A0test_cmp expect actual
>>> =A0'
>>
>> Whitespace damage?
>
> Odd.  Email client issue?

It seems so. Weird, Gnus usually doesn't do this sort of things to me.
Sorry for the noise.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
