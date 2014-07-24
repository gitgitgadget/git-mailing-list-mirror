From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/7] config.c: fix accuracy of line number in errors
Date: Thu, 24 Jul 2014 20:49:08 +0200
Message-ID: <vpqiomm1tjv.fsf@anie.imag.fr>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<1406140978-9472-2-git-send-email-tanayabh@gmail.com>
	<xmqqegxbd9u0.fsf@gitster.dls.corp.google.com>
	<53D10B37.3000403@gmail.com>
	<xmqq1ttaa9sa.fsf@gitster.dls.corp.google.com>
	<53D15307.4060601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 20:49:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAO56-0006xd-Fd
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 20:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759603AbaGXSt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 14:49:29 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52115 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759059AbaGXSt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 14:49:27 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6OIn5Mc024009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 24 Jul 2014 20:49:06 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6OIn8DX009674;
	Thu, 24 Jul 2014 20:49:08 +0200
In-Reply-To: <53D15307.4060601@gmail.com> (Tanay Abhra's message of "Fri, 25
	Jul 2014 00:10:07 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 24 Jul 2014 20:49:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6OIn5Mc024009
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406832549.47805@CuS0qG9XV+VfFl/zn5EItA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254179>

Tanay Abhra <tanayabh@gmail.com> writes:

> On 7/25/2014 12:01 AM, Junio C Hamano wrote:
>> Tanay Abhra <tanayabh@gmail.com> writes:
>> 
>>> On 7/24/2014 3:19 AM, Junio C Hamano wrote:
>>>> Tanay Abhra <tanayabh@gmail.com> writes:
>>>>
>>>>> If a callback returns a negative value to `git_config*()` family,
>>>>> they call `die()` while printing the line number and the file name.
>>>>> Currently the printed line number is off by one, thus printing the
>>>>> wrong line number.
>>>>>
>>>>> Make `linenr` point to the line we just parsed during the call
>>>>> to callback to get accurate line number in error messages.
>>>>>
>>>>> Discovered-by: Tanay Abhra <tanayabh@gmail.com>
>>>>> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
>
> This patch should have looked like,
>
> From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
>
> <commit message>
>
> Commit-message-by: Tanay Abhra <tanayabh@gmail.com>

Yes, the code itself was mine, and Tanay wrote the commit message.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
