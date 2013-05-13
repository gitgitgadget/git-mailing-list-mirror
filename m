From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 7/7] rebase: implement --[no-]autostash and rebase.autostash
Date: Mon, 13 May 2013 10:41:01 +0200
Message-ID: <vpq8v3jclwi.fsf@grenoble-inp.fr>
References: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
	<1368359801-28121-8-git-send-email-artagnon@gmail.com>
	<vpq1u9be18t.fsf@grenoble-inp.fr>
	<CALkWK0kRW07qW_A1Rcyx7gML9ZNJ=g-hvE1O==zFpzToQtTg3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 10:41:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UboJk-0001LU-MO
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 10:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010Ab3EMIlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 04:41:08 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46572 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992Ab3EMIlH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 04:41:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r4D8f1hD026286
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 13 May 2013 10:41:01 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UboJZ-0001bD-W0; Mon, 13 May 2013 10:41:02 +0200
In-Reply-To: <CALkWK0kRW07qW_A1Rcyx7gML9ZNJ=g-hvE1O==zFpzToQtTg3g@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 13 May 2013 13:57:45 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 13 May 2013 10:41:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4D8f1hD026286
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1369039261.77471@5XcMTLwbs/MFxcRujLUQIw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224113>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Matthieu Moy wrote:
>> Any reason why this is not using gettext and the other messages do.
>>   You can run "git stash apply" or "git stash drop" at any time.
>
> Fixed.  Thanks.

After thinking a bit, I have another nit about the message: it's not
clear whether it's saying "your changes are in the work tree, but with
conflicts so you may want to retry later with "git stash pop"", or "I
could not apply your changes at all, do it yourself with "git stash
pop"".

I suppose it's the former, but it could be more explicit.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
