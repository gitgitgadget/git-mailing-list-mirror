From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] status: introduce status.short to enable --short by default
Date: Sun, 09 Jun 2013 21:26:39 +0200
Message-ID: <vpqbo7frspc.fsf@anie.imag.fr>
References: <1370683737-28823-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
	<CALkWK0kvKzFoZmz313hR-3Z71y-MDPT37BfUi7Qrgy7hz_sErQ@mail.gmail.com>
	<7v4nd7qflu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>, git@vger.kernel.org,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 21:27:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllGa-0003FB-JA
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141Ab3FIT0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:26:50 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54954 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562Ab3FIT0t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:26:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r59JQbrX031918
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 9 Jun 2013 21:26:37 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UllGC-0007EE-0K; Sun, 09 Jun 2013 21:26:40 +0200
In-Reply-To: <7v4nd7qflu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 09 Jun 2013 11:54:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 09 Jun 2013 21:26:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r59JQbrX031918
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1371410800.10893@uHUnQDJtaEeexaHfYdR/dQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227111>

Junio C Hamano <gitster@pobox.com> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Jorge Juan Garcia Garcia wrote:
>>> Some people always run 'git status -s'.
>>> The configuration variable status.short allows to set it by default.
>>
>> Good feature.
>
> Is there a corresponding command line override added to help people
> who need to defeat such a configured-in default?

Yes: "git status --no-short".

Perhaps the doc for status.short should explicitely mention that
--no-short takes precedence over it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
