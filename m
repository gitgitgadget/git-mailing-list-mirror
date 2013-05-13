From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 0/7] rebase.autostash completed
Date: Mon, 13 May 2013 10:32:11 +0200
Message-ID: <vpqobcfcmb8.fsf@grenoble-inp.fr>
References: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
	<7vy5bjqxxa.fsf@alter.siamese.dyndns.org>
	<CALkWK0mWRC9_QVYAu9Q4iAoVTpfkf9xkc9apjrdv6SyEiCq+hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 10:32:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UboBE-0003nU-9a
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 10:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164Ab3EMIcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 04:32:20 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52049 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753167Ab3EMIcT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 04:32:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r4D8WB0x003805
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 13 May 2013 10:32:11 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UboB2-0001Kb-04; Mon, 13 May 2013 10:32:12 +0200
In-Reply-To: <CALkWK0mWRC9_QVYAu9Q4iAoVTpfkf9xkc9apjrdv6SyEiCq+hA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 13 May 2013 13:29:29 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 13 May 2013 10:32:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4D8WB0x003805
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1369038735.06773@AGHacXV33U11w6HDyJJTOg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224112>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Especially I did not check if there are
>> still undesirable data loss behaviour in corner cases that people
>> were worried about in the discussion.
>
> Check the tests.  What am I missing?

I didn't do a thorough check, but my earlier comments are taken into
account, I didn't see anything wrong and the tests in 7/7 are good.

>>    Perhaps "rebase" can be taught to be more careful when checking
>>    if local changes may overlap with the changes being replayed.
>
> Frankly, I don't know if it's worth the effort.  It might be a nice
> theoretical exercise, but what tangible benefit do I get as the end
> user (now that I have rebase.autostash)?  In fact, I'll probably be
> slowing down the interactive rebase noticeably by executing a
> diff-tree at every step.  And for what?

One benefit would be to avoid triggering rebuild (and editor reload) by
keeping the timestamps intact. But I agree it's probably not worth the
effort (and definitely isn't in the scope of this series).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
