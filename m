From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Should "git help" respect the 'pager' setting?
Date: Thu, 30 May 2013 19:05:00 +0200
Message-ID: <vpqhahko0ub.fsf@anie.imag.fr>
References: <CAKtB=OCyoN8ECYiAzXc3UiCrLfWn7Pq7_5CSQUjJ2dhbzQ2RsQ@mail.gmail.com>
	<vpqtxlko1vn.fsf@anie.imag.fr>
	<CALkWK0=RUy6=4k9uGpy2efdL8DhOnNO52rHZWSmHP3C=2a4SUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Campbell <michael.campbell@gmail.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 19:05:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui6Ho-0005NT-2D
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 19:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758438Ab3E3RFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 13:05:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47263 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758405Ab3E3RFG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 13:05:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r4UH4wLr023552
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 30 May 2013 19:04:58 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ui6Hc-0004zn-OT; Thu, 30 May 2013 19:05:00 +0200
In-Reply-To: <CALkWK0=RUy6=4k9uGpy2efdL8DhOnNO52rHZWSmHP3C=2a4SUw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 30 May 2013 22:26:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 30 May 2013 19:04:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4UH4wLr023552
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1370538301.6984@OWghZzmui7G7WQAi/SlkmQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226024>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> It just needs to set $PAGER or $MANPAGER before the exec(), no?

Yes, that should do the same as "man -P".

> I would argue that it should do this. $GIT_PAGER works everywhere
> else, but obviously man has no knowledge about it.

I find it a bit weird that Git sets the configuration for external
commands, but it may make sense. No strong opinion here.

>> If you're an Emacs user, you can read about man.viewer and set it to
>> woman, or set PAGER=cat when inside Emacs.
>
> I just learnt about man.viewer.  There's a small problem with it
> though: why is there no option for Emacs man corresponding to Emacs
> woman?

I guess because no one implemented it ;-).

>> I personally run M-x git-foo RET, and never run "git help".
>
> M-x man git-foo RET, you mean?

Yes, sorry.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
