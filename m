From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 07/10] send-email: reduce dependencies impact on parse_address_line
Date: Tue, 30 Jun 2015 21:36:53 +0200
Message-ID: <vpqoajx2dka.fsf@anie.imag.fr>
References: <1435666611-18429-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435666611-18429-8-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqfv59ca4b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 21:37:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZA1L7-0007bb-L4
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 21:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbbF3ThB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 15:37:01 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51394 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544AbbF3Tg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 15:36:59 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5UJapbw000974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Jun 2015 21:36:51 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5UJarjB032026;
	Tue, 30 Jun 2015 21:36:53 +0200
In-Reply-To: <xmqqfv59ca4b.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 30 Jun 2015 11:41:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 30 Jun 2015 21:36:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5UJapbw000974
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436297813.12761@05votTMIHjNbFhFlb3dviA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273101>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> diff --git a/t/t9000-addresses.sh b/t/t9000-addresses.sh
>> new file mode 100755
>> index 0000000..7223d03
>> --- /dev/null
>> +++ b/t/t9000-addresses.sh
>> @@ -0,0 +1,30 @@
>> +#!/bin/sh
>> +#
>> +# Copyright (c) 2015
>
> That does not look like a valid copyright notice.
>
> In the modern age, I'd personally perfer not to add one

I'd vote for keeping it simple and not having the copyright notice. Most
t/*.sh do not have one. The Git history + mailing-list archives are much
better than in-code comments to keep track of who wrote what.

Remi: any objection on removing it?

Junio: do you want me to resend?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
