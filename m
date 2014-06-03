From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] string-list: Add a value to string_list initializer lists
Date: Tue, 03 Jun 2014 17:20:39 +0200
Message-ID: <vpqmwduqat4.fsf@anie.imag.fr>
References: <1401786798-3729-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 17:21:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrqWk-00064Y-JF
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 17:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932976AbaFCPVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 11:21:21 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49795 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932971AbaFCPVT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 11:21:19 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s53FKdbG008787
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 Jun 2014 17:20:39 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s53FKdme004628;
	Tue, 3 Jun 2014 17:20:39 +0200
In-Reply-To: <1401786798-3729-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Tue, 3 Jun 2014 02:13:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 03 Jun 2014 17:20:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s53FKdbG008787
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1402413640.47793@i6xTW4JIi6D4ZV1vQUMWMQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250625>

Tanay Abhra <tanayabh@gmail.com> writes:

> diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
> index 20be348..f1add51 100644
> --- a/Documentation/technical/api-string-list.txt
> +++ b/Documentation/technical/api-string-list.txt
> @@ -200,3 +200,5 @@ Represents the list itself.
>    You should not tamper with it.
>  . Setting the `strdup_strings` member to 1 will strdup() the strings
>    before adding them, see above.
> +. The `compare_strings_fn` member is used to specify a custom compare
> +  function, otherwise `strcmp()` is used as the default function.

Is this change intentional? It seems good, but not really related to the
change described in the commit message.

In any case, this remark should not block patch inclusion, it's trivial
enough.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
