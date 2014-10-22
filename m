From: Zoltan Klinger <zoltan.klinger@gmail.com>
Subject: Re: [PATCH] grep: fix match highlighting for combined patterns with
 context lines
Date: Wed, 22 Oct 2014 11:45:19 +1100
Message-ID: <CAKJhZwTQpxiFp1BLed9jHRaPeF_ZuXQ7u6YGNp--UjyAyGZerw@mail.gmail.com>
References: <1413870963-66431-1-git-send-email-zoltan.klinger@gmail.com>
	<xmqqh9yxz0pc.fsf@gitster.dls.corp.google.com>
	<xmqqoat5hwri.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 22 02:45:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgk3L-0007gb-9s
	for gcvg-git-2@plane.gmane.org; Wed, 22 Oct 2014 02:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbaJVApU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 20:45:20 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:61108 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbaJVApU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 20:45:20 -0400
Received: by mail-ig0-f172.google.com with SMTP id r2so2447999igi.11
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 17:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=qHRjS3vzEv5q5H6Rxp0xfCCdcW3z02EI3VA1i8Om8IQ=;
        b=mw3Jc7l8tr/RjuIVz7jw10prsQoBXOzqnZOYZJNtQ4IK/YTT+lDzy27DHvzrcv4wbN
         ZZHYd/n1rqfnc23A7bcCbGfo1GaraVgmsD/rV3L0VeLAwPZ5781FlHpuidvwgy1bZFuF
         o/KSRPHtmrLaAbA6PlQ2C9fOlAYHZSQzfTucFQZSXdMZLUuLpcPA5xqYhormLttSYkqh
         HU6uwlG6sr7azFMuOeYTFOGgU3oR6xwqv9qNFcXxEfj7cxHlAFukFBC3ZqRVN8Vwb35A
         VbyRN7O3H1dDdvRv+2903QczE+qhQ5OSrjs7K/Tp12mBY7fZ1dvHXwGhWq/dECEfq3jh
         DQ9A==
X-Received: by 10.42.182.4 with SMTP id ca4mr1504633icb.62.1413938719252; Tue,
 21 Oct 2014 17:45:19 -0700 (PDT)
Received: by 10.50.209.3 with HTTP; Tue, 21 Oct 2014 17:45:19 -0700 (PDT)
In-Reply-To: <xmqqoat5hwri.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Junio C Hamano <gitster@pobox.com> writes:
>
> It turns out that the result of such a change becomes more readable
> than the original, in that it makes it clear that reinspection of
> the lines are done only for matched ones and not context lines.
>
>
Agree, it looks much clearer now. Happy if you squashed your
change (commit da736e6) in zk/grep-color-words branch.
