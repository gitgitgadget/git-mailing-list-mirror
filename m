From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 5/8] branch: drop non-commit error reporting
Date: Thu, 24 Sep 2015 08:46:35 +0200
Message-ID: <vpqzj0cs4ac.fsf@grenoble-inp.fr>
References: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
	<1443031873-25280-6-git-send-email-Karthik.188@gmail.com>
	<xmqqfv25x80c.fsf@gitster.mtv.corp.google.com>
	<vpq6130ucbh.fsf@grenoble-inp.fr>
	<xmqqr3lox4kc.fsf@gitster.mtv.corp.google.com>
	<xmqqmvwcx45g.fsf@gitster.mtv.corp.google.com>
	<xmqqio70x13r.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 24 08:46:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zf0Ir-0007Gd-Tf
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 08:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756506AbbIXGqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 02:46:46 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43548 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752680AbbIXGqp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 02:46:45 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8O6kZAZ024356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 24 Sep 2015 08:46:35 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8O6kZnM015635;
	Thu, 24 Sep 2015 08:46:35 +0200
In-Reply-To: <xmqqio70x13r.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 23 Sep 2015 14:44:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 24 Sep 2015 08:46:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8O6kZAZ024356
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443681999.21278@w/rpMckYr5apRy8rbW94gA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278536>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Perhaps something like this (not even compile tested as both of my
>> worktrees are doing something else)....
>
> This time with a few additional tests.
>
> -- >8 --
> Subject: [PATCH] fsck: exit with non-zero when problems are found

Seems straightforwardly correct. And manually tested on my case, it does
work.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
