From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/7] add a test for semantic errors in config files
Date: Thu, 24 Jul 2014 16:05:30 +0200
Message-ID: <vpqha26kg2d.fsf@anie.imag.fr>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<1406140978-9472-4-git-send-email-tanayabh@gmail.com>
	<vpq38drvohr.fsf@anie.imag.fr>
	<xmqq38drd8ue.fsf@gitster.dls.corp.google.com>
	<53D11077.10907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 16:07:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAJgD-0006rO-9z
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 16:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759059AbaGXOHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 10:07:20 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46406 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758894AbaGXOHR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 10:07:17 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6OE5TuN026017
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 24 Jul 2014 16:05:30 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6OE5UmA006307;
	Thu, 24 Jul 2014 16:05:31 +0200
In-Reply-To: <53D11077.10907@gmail.com> (Tanay Abhra's message of "Thu, 24 Jul
	2014 19:26:07 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 24 Jul 2014 16:05:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6OE5TuN026017
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406815534.79478@7+AF/JG+Tb5dmqTAQ1vnRw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254158>

Tanay Abhra <tanayabh@gmail.com> writes:

>>>> +	test_when_finished "mv .git/config.old .git/config" &&
>>>> +	echo "[alias]\n br" >.git/config &&
>> 
>> Is the use of \n portable?
>> 
>
> Yes, you are right, will replace with printf in the next patch.

... or a cat >.git/config <<\EOF, since this is the construct used
elsewhere in the script.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
