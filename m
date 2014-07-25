From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 5/7] enforce `xfuncname` precedence over `funcname`
Date: Fri, 25 Jul 2014 08:54:45 +0200
Message-ID: <vpqlhriyll6.fsf@anie.imag.fr>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<1406140978-9472-6-git-send-email-tanayabh@gmail.com>
	<xmqqtx67bt78.fsf@gitster.dls.corp.google.com>
	<vpqlhrjqmyw.fsf@anie.imag.fr>
	<xmqqiommadl0.fsf@gitster.dls.corp.google.com>
	<53D15188.2010209@gmail.com> <vpqegxa386m.fsf@anie.imag.fr>
	<xmqqppgu8sxz.fsf@gitster.dls.corp.google.com>
	<53D15EB4.1050303@gmail.com>
	<xmqqlhri8rdb.fsf@gitster.dls.corp.google.com>
	<53D17919.4020702@ramsay1.demon.co.uk> <53D1CBFA.3020107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 08:55:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAZPG-0003nl-RS
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 08:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759205AbaGYGy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 02:54:57 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47431 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976AbaGYGy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 02:54:56 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6P6siaC011480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Jul 2014 08:54:45 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6P6sj0X014540;
	Fri, 25 Jul 2014 08:54:45 +0200
In-Reply-To: <53D1CBFA.3020107@gmail.com> (Tanay Abhra's message of "Fri, 25
	Jul 2014 08:46:10 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 25 Jul 2014 08:54:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6P6siaC011480
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406876089.00092@9LiGhahC/DF+9iqqOlkxGw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254200>

Tanay Abhra <tanayabh@gmail.com> writes:

> On 7/25/2014 2:52 AM, Ramsay Jones wrote:
>> However, I think it you could create a list of <pointer to hash-table
>> entry, string-list index> pairs in the config_set and use that to do
>> the iteration. A bit ugly, but it should work.
>
> Thanks for the advice, that is exactly what I am doing.

I'd just replace "list" with "array" and use
Documentation/technical/api-allocation-growing.txt.

But I can't think of a better way.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
