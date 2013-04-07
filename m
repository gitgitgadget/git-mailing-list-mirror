From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 4/4] format-patch: add format.cover-letter configuration
Date: Sun, 07 Apr 2013 18:20:57 +0200
Message-ID: <vpqbo9qfh1y.fsf@grenoble-inp.fr>
References: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
	<1365318630-11882-5-git-send-email-felipe.contreras@gmail.com>
	<7v4nfi92q1.fsf@alter.siamese.dyndns.org>
	<CAMP44s0rsWCZE=MyW3zuBoVM5ZtEGQQb+deQJB5-i6tBzFdTfw@mail.gmail.com>
	<7vmwta7lx3.fsf@alter.siamese.dyndns.org>
	<CAMP44s1pMLzkQrE1iKmYyj_FOZqkUp46HRQ6kjWfNvOYA5FkVQ@mail.gmail.com>
	<vpqwqsefl9b.fsf@grenoble-inp.fr>
	<CAMP44s2TvC9Ek51GyhPqtv7b-w8u8kr=tQsmdWEVGOycb6MEqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 18:21:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOsLX-0003TA-Tj
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 18:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934008Ab3DGQVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 12:21:21 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57242 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934004Ab3DGQVU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 12:21:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r37GKtq0018820
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 7 Apr 2013 18:20:55 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UOsKv-0004RS-Iz; Sun, 07 Apr 2013 18:20:57 +0200
In-Reply-To: <CAMP44s2TvC9Ek51GyhPqtv7b-w8u8kr=tQsmdWEVGOycb6MEqA@mail.gmail.com>
	(Felipe Contreras's message of "Sun, 7 Apr 2013 11:03:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 07 Apr 2013 18:20:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r37GKtq0018820
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1365956458.12219@m5honCTfyCZQ8+T5mDZTfQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220323>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Sun, Apr 7, 2013 at 9:50 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> So, I'm a user that does 'git format-patch --cover-letter=auto origin'
>>> so I don't have the format.coverletter=auto configuration. Why? Why am
>>> I not setting that configuration, and why am I running
>>> --cover-letter=auto?
>>
>> The command may well be ran from a script or alias.
>
> Wouldn't this work for both cases?
>
> % git -c format.coverletter=auto format-patch

Then, what's the point in having a --cover-letter option?

"git -c" is a good last-chance solution, but when we provide the same
feature as a command-line option and as a configuration option, I can
see no reason to add subtle difference between them.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
