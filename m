From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/8] checkout: respect GIT_REFLOG_ACTION
Date: Tue, 18 Jun 2013 22:26:10 +0530
Message-ID: <CALkWK0mfDeO5V9J9txjwATRxSRDPY2fJ0mNRCA7VoqKiQgWpiw@mail.gmail.com>
References: <1371557670-12534-1-git-send-email-artagnon@gmail.com>
 <1371557670-12534-6-git-send-email-artagnon@gmail.com> <7vli675pi8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 18:57:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UozDD-0005dC-8Y
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 18:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933112Ab3FRQ4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 12:56:51 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:63988 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933077Ab3FRQ4v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 12:56:51 -0400
Received: by mail-ie0-f170.google.com with SMTP id e11so10917266iej.29
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 09:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xhVrzDvfqJ2vL22z1hHvN//VJy646ZOGGTmb8C2Mh4k=;
        b=hfwbqMF6r6Ld5/T2FiNanCVntCp8bnaIMAEoQbqlKKuq2zOZlDykE94qci9TvVuEG6
         vNnLH9XcIIaEkUene1/aDB3Xn4DyUzJkaGlAYIJiFVzAFvHdCtBJ0lKpd9UzEeiRjY8P
         qi0bkGmgeRubqcnm6PjtelbMp72qOvSCxuiOYWTy4waMqRXtvrdpCSZ2jcaBTkuTxeJO
         nlfbC2frDps4YomyWKSWJLSm91HTEfSRseKOZU4yOAa6fB5munFIGNJyZ2NpSOV0j5H8
         fvQPgbisOZkR4FbjZvF3GimzeCLswSgFmapisGAL9lhj8qhQG7uzT2Tlt40Gh7v880xx
         hnJA==
X-Received: by 10.50.154.106 with SMTP id vn10mr7961997igb.0.1371574610416;
 Tue, 18 Jun 2013 09:56:50 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 09:56:10 -0700 (PDT)
In-Reply-To: <7vli675pi8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228274>

Junio C Hamano wrote:
> By the way, please stop doing "t/checkout-last" which I have to
> manually fix-up every time to its actual prefix (i.e. I cannot
> review with "less t/checkout-last*" to see what the log message is
> talking about; I can with "less t/t2012-checkout-last*").

Ah, I didn't realize you used it like that.  I was trying to be terse
and informative in the subject: the four test numbers don't mean
anything to a casual reader, while t/checkout-last conveys
information.
