From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v7 0/3] some enhancements for reporting branch tracking info
Date: Mon, 19 Aug 2013 08:38:55 +0800
Message-ID: <CANYiYbEtWF3m_ACActD2TDjhXh_=1qJ07Rgc3mb8Nfgogjh-RQ@mail.gmail.com>
References: <7vzjsio99d.fsf@alter.siamese.dyndns.org>
	<cover.1376618877.git.worldhello.net@gmail.com>
	<7v7gfiojz7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 19 02:39:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBDUr-0001tw-Ap
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 02:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755624Ab3HSAi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 20:38:57 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:39021 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731Ab3HSAi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 20:38:56 -0400
Received: by mail-wg0-f49.google.com with SMTP id y10so2934728wgg.4
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 17:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1SOHEJR7n9l83yem+c3qPkSzDG7hMpF7Jco+l1jQLbA=;
        b=cZaUK5+m6pwhaQyqXytRNch3g+Qe/ufOkHr2VoXxho8rWHN3Z1vQ6cw9N/BkRXKR77
         YvUqt1VxRjoIBUCFJpso3ZF5f+XhI2xxyXpWdG0BvPeiX1HrIwlMMnz3K62tVqfsgsFt
         v8HcbRQ/AcJk/hIoF7C/B/oWt588gRlNc9XOc7uikpi7zz33162ykK5KKrQEKO8MVjKt
         u8yO9lqVJ9fT3wlbGaLNcDlV75VFQWNBC8+hs+MdXCA380jsbJeMn+LINYw5dZNO/PMM
         5gu36OX/+NU4+BQZMnH1ySnAivWfMB3ZZk9G7c+Vbe68BVYwHXufTtImEdBuwiK6jYpG
         6ooQ==
X-Received: by 10.180.183.19 with SMTP id ei19mr6126076wic.10.1376872735291;
 Sun, 18 Aug 2013 17:38:55 -0700 (PDT)
Received: by 10.194.104.201 with HTTP; Sun, 18 Aug 2013 17:38:55 -0700 (PDT)
In-Reply-To: <7v7gfiojz7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232526>

2013/8/19 Junio C Hamano <gitster@pobox.com>:
>
> I however feel that [1/3] is introducing a regression (what we used
> to report, gone branches, are hidden), only to correct the
> regression immediately after it with [2/3].
>
> I wonder if these patches should be combined into one

Yes, at least patch 1/3 and patch 2/3 can be squashed into one.

> justification like "with the current code, a branch that is in sync
> with its upstream, a branch whose upstream no longer exists and a
> branch that does not build on anything else cannot be distinguished;
> show the first class as 'same', mark the second class as 'gone', and

For the first class, if there are differences between branch and
its upstream, tracking info is displayed, but report nothing if they
are identical. I do think report something in this case is useful.
It may help me to find out which remote I am tracking, if there are
several remotes for my repo.

> show only the last one as 'not having any uptream', or something.

I think keep silence in this case is better.

-- 
Jiang Xin
