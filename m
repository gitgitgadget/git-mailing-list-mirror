Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75EA11FD99
	for <e@80x24.org>; Sat, 27 Aug 2016 03:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751699AbcH0D64 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 23:58:56 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:34860 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751399AbcH0D6z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 23:58:55 -0400
Received: by mail-yw0-f174.google.com with SMTP id j12so59574797ywb.2
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 20:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EWznTnbCRHYzrswzh3VpVDEEu8Y/VUL5DKZs3JEGEjc=;
        b=RhYeX/Lfincoy+L0CaPqmNS6mKPXd+ts4KiABhwdpCjNgv9EVIgWBsu9vS5IglvlkX
         vf7lUQipRFZxuZsOKAE64+X+ZmxputI+RpmzhCLAx7NUOhFUnJ4vlcczSF1OcnoZml2A
         R+ZLZ76pLLDx92qKw1UbVI3xOv3C6T3Q3kNYlr7bpOWcW/UpobB7uAHYSk4jkV/6vQeC
         fl0yXjCYRz00n/sg65NK9M5hX9x/ZzIIEl95WV2mI+qafOaMQpBrV39A+lilUgpw9Lso
         SYY8Z7Uy50l0ppis0AfJFMjvda8X7Qd52lMD0kUw8r4oc71L4nCKWGiBERfGEpO1WsNi
         gQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EWznTnbCRHYzrswzh3VpVDEEu8Y/VUL5DKZs3JEGEjc=;
        b=awpFykcLxYZoGO/W7z0pdDA0vUGNsKgblxfaEeQf5uAshvmL/ihHYEXBUg0n4d0Sif
         qA39XK4iVkmVciygbzTkpwCBCxFIVd0+j/5NQHWYsOM+/3T3h5Py3g074lZ0Wc+IUbjD
         n0lB3E3+2R95Rts4Cu31uGz1uvhgvqh1nOLrlWcMymFgb9cD5Bh5oq4a1bGzhvHzUGn9
         vMnriZ8d7f5qA7jkgKKVQwY8WdkY5DWXNNMokqQwraG5HAbF28F1NuPkL1GRMdQv/VkW
         QKqOvE9+GKKifZ7/nslSZgTq+A7x/bHnjY1ebJrJnKcuvCbxW66h6SWlp/UvljiMYMGG
         qhpg==
X-Gm-Message-State: AE9vXwOvR+3TMvsCRa2PWL46rXPaF6OsiY4iJRU95lE8M5wrFmLzq1pXeDZVcrXVx3fDVychJeHTtwWd8ZTwmw==
X-Received: by 10.129.135.2 with SMTP id x2mr6215090ywf.310.1472270334866;
 Fri, 26 Aug 2016 20:58:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Fri, 26 Aug 2016 20:58:34 -0700 (PDT)
In-Reply-To: <xmqqk2f3gzcm.fsf@gitster.mtv.corp.google.com>
References: <1472230741-5161-1-git-send-email-dev+git@drbeat.li>
 <1472230741-5161-2-git-send-email-dev+git@drbeat.li> <xmqqk2f3gzcm.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 26 Aug 2016 20:58:34 -0700
Message-ID: <CA+P7+xopLOwWO22j8i7iWjGM-+vn0ScS9mLVNrB-qt3YCX_=yw@mail.gmail.com>
Subject: Re: [PATCH 2/2] SubmittingPatches: hint at gitk's "Copy commit
 summary" command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Beat Bolli <dev+git@drbeat.li>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 26, 2016 at 11:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Beat Bolli <dev+git@drbeat.li> writes:
>
>> @@ -124,7 +124,8 @@ archive, summarize the relevant points of the discussion.
>>  If you want to reference a previous commit in the history of a stable
>>  branch use the format "abbreviated sha1 (subject, date)". So for example
>>  like this: "Commit f86a374 (pack-bitmap.c: fix a memleak, 2015-03-30)
>> -noticed [...]".
>> +noticed [...]". The "Copy commit summary" command of gitk generates this
>> +format.
>
> (continuing from my 1/2 review)  And if people agree that the format
> gitk already uses is better, this text should probably read more
> like:
>
>     If you want to reference a previous commit in the history of a
>     stable branch, use the format "abbreviated sha1 (subject, date)",
>     with the subject enclosed in a pair of double-quotes, like this:
>
>         Commit f86a374 ("pack-bitmap.c: fix a memleak", 2015-03-30)
>         noticed that ...
>
>     The "Copy commit summary" command of gitk can be used to obtain this
>     format.


Tangent, but I was wondering if this would make a good built-in
format, but then I looked and realized that the built-in formats
didn't make much sense to me... I'm not sure where the actual format
gets displayed so I am wondering if we had any thoughts about adding
some --pretty=summary that we could add? I know it can be implemented
via a user defined format but thought it might be worth building it in
since it's a pretty common use case?

Thanks,
Jake
