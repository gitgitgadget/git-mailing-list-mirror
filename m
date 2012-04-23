From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/7] t5528-push-default.sh: add helper functions
Date: Mon, 23 Apr 2012 18:20:05 +0200
Message-ID: <vpqfwbuju8a.fsf@bauges.imag.fr>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-4-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqipgqlass.fsf@junio.mtv.corp.google.com>
	<vpqobqil9ml.fsf@bauges.imag.fr>
	<xmqq8vhml8z7.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 18:21:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMM0Y-0002RD-4B
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 18:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850Ab2DWQUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 12:20:53 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53538 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753649Ab2DWQUw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 12:20:52 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q3NGDdgh019438
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 23 Apr 2012 18:13:39 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SMLzi-00063J-6C; Mon, 23 Apr 2012 18:20:06 +0200
In-Reply-To: <xmqq8vhml8z7.fsf@junio.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 23 Apr 2012 09:16:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 23 Apr 2012 18:13:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3NGDdgh019438
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1335802420.84446@B24/nHx9DJ0yf6874jae6g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196139>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>>> ... and we can use --all not master here, right?
>>
>> Actually, we can even use --all everywhere. And then, we don't even need
>> the second argument, and we can simplify greatly the function:
>
> That did cross my mind but I suspected that the reason to have the
> argument was because you would want to use the helper also to test
> 'matching' case where you want to make sure ones that the pusher does
> not have are left alone.

I did not add much for "matching" (that would be a separate topic, and
my Git time budget is getting short). But I think the simplicity of the
new function (both caller and callee side) is worth it, even if we later
add something more complex for the case of "matching".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
