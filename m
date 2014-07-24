From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 0/7] Rewrite `git_config()` using config-set API
Date: Thu, 24 Jul 2014 18:17:09 +0200
Message-ID: <vpqsilq7muy.fsf@anie.imag.fr>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<xmqqiomnda1y.fsf@gitster.dls.corp.google.com>
	<53D12078.2070004@gmail.com> <vpq1ttadauu.fsf@anie.imag.fr>
	<53D12D56.2080505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 18:17:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XALi6-0005VJ-EF
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 18:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933581AbaGXQRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 12:17:33 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60710 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932207AbaGXQRd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 12:17:33 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6OGH8W0019879
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 24 Jul 2014 18:17:08 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6OGH9WR008028;
	Thu, 24 Jul 2014 18:17:09 +0200
In-Reply-To: <53D12D56.2080505@gmail.com> (Tanay Abhra's message of "Thu, 24
	Jul 2014 21:29:18 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 24 Jul 2014 18:17:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6OGH8W0019879
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406823430.21683@BF60BBZICdchLgzsbsQi5A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254165>

Tanay Abhra <tanayabh@gmail.com> writes:

> On 7/24/2014 9:09 PM, Matthieu Moy wrote:
>> Tanay Abhra <tanayabh@gmail.com> writes:
>> 
>>> I am attaching the v12 with two new functions git_configset_get_string() &
>>> git_configset_get_string_const().
>> 
>> Didn't you intend to change git_config_get_string to let it die in case
>> of error instead of returning an error code?
>>
>
> Yup, but it is the part of the new series not the old one.
> I sent this revised patch just for solving the constness
> debate.
> Also, I would need git_die_config() to print a proper
> error message which comes in the 7 part series not this one.

Ah, right, you don't have line numbers yet, so you can't die properly.

So, hopefully, this part can be considered done, and we can continue
building on top.

As a side effect, I guess Junio will apply this on top of master so the
string interning API will be available immediately at the tip of the
branch.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
