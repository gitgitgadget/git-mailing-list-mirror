From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 03/10] Add colors to interactive git-clean
Date: Mon, 13 May 2013 08:57:12 +0200
Message-ID: <vpqbo8ffjuf.fsf@grenoble-inp.fr>
References: <ad26375dece854339d64dcb82c17f19f8edccf48.1368011946.git.worldhello.net@gmail.com>
	<6a7931a0bb14f8c71479e16175812bedb6b826cb.1368011946.git.worldhello.net@gmail.com>
	<cover.1368011946.git.worldhello.net@gmail.com>
	<d7302adabb4269dd94698090fb20c739f723f00a.1368011946.git.worldhello.net@gmail.com>
	<vpqfvxsi0gw.fsf@grenoble-inp.fr>
	<CANYiYbGqZ6FiHTZgejrA3a-njffQNJyaefFmCWfycuE6PGjwbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 08:59:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbmjV-0001s8-OL
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 08:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978Ab3EMG5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 02:57:25 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36293 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752133Ab3EMG5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 02:57:24 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r4D6vBQS024837
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 13 May 2013 08:57:11 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ubmh6-0007Mv-FE; Mon, 13 May 2013 08:57:12 +0200
In-Reply-To: <CANYiYbGqZ6FiHTZgejrA3a-njffQNJyaefFmCWfycuE6PGjwbA@mail.gmail.com>
	(Jiang Xin's message of "Mon, 13 May 2013 10:47:41 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 13 May 2013 08:57:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4D6vBQS024837
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1369033036.17041@rzANY7T4ngBoYpeXpjkHGQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224099>

Jiang Xin <worldhello.net@gmail.com> writes:

> 2013/5/13 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
>> Jiang Xin <worldhello.net@gmail.com> writes:
>>
>>>  * color.interactive.<slot>: Use customized color for interactive
>>>    git-clean output (like git add --interactive). <slot> may be
>>>    prompt, header, help or error.
>>
>> This should go to the documentation (a short summary is welcome in the
>> commit messages in addition, but users won't read this...)
>>
>>> +     if (!prefixcmp(var, "color.interactive.")) {
>>> +             int slot = parse_clean_color_slot(var, 18);
>>
>> For readability and maintainability: please use
>> strlen("color.interactive."), not 18.
>
> Feel like conventional:
>
>     git grep -C2 prefixcmp builtin/apply.c builtin/archive.c
> builtin/branch.c builtin/checkout.c

I know there are already many instances of this in the code, but I don't
think it's a good idea to add even more.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
