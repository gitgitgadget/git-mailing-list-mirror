From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] git-commit: add a commit.verbose config variable
Date: Fri, 26 Feb 2016 18:32:55 +0100
Message-ID: <vpqoab3s7g8.fsf@anie.imag.fr>
References: <56CFBF19.6040004@zoho.com>
	<CAPig+cQE6ytRKFjqRRLrPHCYqJuf52NKvy8sZs8rX3t5_kDRVg@mail.gmail.com>
	<56D05295.6020102@zoho.com>
	<xmqqio1bl8a7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pranit Bauva <pranit.bauva@zoho.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 18:33:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZMGT-0001Ci-4w
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 18:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbcBZRdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 12:33:13 -0500
Received: from mx2.imag.fr ([129.88.30.17]:54411 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754456AbcBZRdM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 12:33:12 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1QHWrau005449
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 26 Feb 2016 18:32:53 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1QHWtS8010316;
	Fri, 26 Feb 2016 18:32:55 +0100
In-Reply-To: <xmqqio1bl8a7.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 26 Feb 2016 08:56:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 26 Feb 2016 18:32:53 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1QHWrau005449
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457112774.36125@1pKTtqzYr5LGaoaS1SsNQA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287597>

Junio C Hamano <gitster@pobox.com> writes:

> Pranit Bauva <pranit.bauva@zoho.com> writes:
>
>>> If you know you haven't finished, you may use WIP (work in progress)
>>> instead of RFC in the title.
>>
>> I wasn't familiar with this tag. I will keep it in mind. And this is not
>> included in Documentation/SubmittingPatches , so I will send a patch to
>> include WIP tag.
>
> Please don't.  It is OK to say WIP or RFC or some people even say
> [not a patch] there; we do not need to enumerate all of them, and
> your original RFC was just fine.

In case it was unclear: my "you may" here was really meant to be "you
may", not "you should" ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
