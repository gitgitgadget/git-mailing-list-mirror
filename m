From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 7/7] send-email: suppress leading and trailing whitespaces before alias expansion
Date: Wed, 10 Jun 2015 18:25:53 +0200
Message-ID: <vpq8ubrwmwe.fsf@anie.imag.fr>
References: <1433875804-16007-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433875804-16007-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<vpqa8w89d5x.fsf@anie.imag.fr>
	<1281238070.338321.1433928615479.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<xmqqa8w7oarl.fsf@gitster.dls.corp.google.com>
	<vpqoaknr39r.fsf@anie.imag.fr>
	<xmqqfv5zmtf0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 18:26:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2ipO-000835-Tr
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 18:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414AbbFJQ0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 12:26:07 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47354 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754402AbbFJQ0E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 12:26:04 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5AGPp9m003619
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Jun 2015 18:25:51 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5AGPrBq025960;
	Wed, 10 Jun 2015 18:25:53 +0200
In-Reply-To: <xmqqfv5zmtf0.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 10 Jun 2015 09:15:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 10 Jun 2015 18:25:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5AGPp9m003619
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434558353.62268@1Bx59Iws3I2Dx9vNmoZguQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271324>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Hmph, if I have "A, B, C" and call a function that gives an array of
>>> addresses, treating the input as comma-separated addresses, I would
>>> expect ("A", "B", "C") to be returned from that function, instead of
>>> having to later trim the whitespace around what is returned.
>>
>> It is actually doing this. But if you have " A,B,C  ", then you'll get
>> " A", "B", "C  ". But once you're trimming around commas, trimming
>> leading and trailing spaces fits well with split itself.
>
> I guess we are saying the same thing, then?  That is, trim-list as a
> separate step does not make sense an it is part of the job for the
> helper to turn a single list with multiple addresses into an array?

Yes. I was clarifying what was done and what wasn't, not disagreeing.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
