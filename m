Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1D8A1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 13:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbeKVALp (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 19:11:45 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:34755 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbeKVALp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 19:11:45 -0500
Received: by mail-lj1-f175.google.com with SMTP id u6-v6so4866658ljd.1
        for <git@vger.kernel.org>; Wed, 21 Nov 2018 05:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=5dGqwf9pike1Oberrmjy85qXIQIGxtuEKF8PE9cuOA4=;
        b=qI24Jh5tws1siH/z9V5tfAPkPaEjtM6SKmeVPd+03NGRlNzra1kIBbyruL95YwM/d1
         rGAgF+JX9crLh0ocwWS5B0T/vnrxROhF1hfgl12yl5OhZFjUsThSCnBK5zajy+NBy4H7
         LGIHT70zzOeL4iikc3ypyIYVNs6auor0QJLUR0UpYI4WuGGMmC8FDNZRVd4JeHTBVzKM
         QaoCAwk22SA74G1UE9oS9EdCRyZ6xt3VKmi62V/oaQoBkRDmiwkoU2rBEwn95xLwimqg
         haQzFaKCkvfPSNqX9j/bxb0/SGbATUn+D4lVh6+iXKN5WEq+iikPI2t6WpE+Uouf4Dxb
         JYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=5dGqwf9pike1Oberrmjy85qXIQIGxtuEKF8PE9cuOA4=;
        b=A/8ZSh9d3y38PM5ME41h+xu0sIjTnut/tONmOlqlTeMA8136GThXdX7orgFRHrsl7a
         eSqORFkZqc5w4azjsRGOZnUXxtO3/ErhbfatHvzUQKuueXYwMuPjcCB74+1UxSnt6Z/8
         ekXikQ/saT4v8bp1kz1nxYavutOFeVyUeIrNY0BYiZR38jCUjJIoLo+fqDo6EY4fYbYG
         PRG5TFCfaYrAfyLrhThcoHeVjFOFXha544tqb/Dl91LCWM+Sns+RV4VmSU44hjyKr4ip
         WMtYDDhhhLXr5wAnmNpRTHdRJl0sJ/C1zMQyGCJyS+CG0IsKwmS7oSInEGfgTB9pg7hX
         hiLw==
X-Gm-Message-State: AA+aEWYU1Brs88jfzQNAYMjxUMHFkF7jemxSOo7wnMaybvzJFfKoQfth
        Ua8jPuaWOR7gpzUe8f+dMD65I5jfe/OCIpCkKyW9mQ==
X-Google-Smtp-Source: AFSGD/WENVStr5cA5kZ+t+UAMMKw0p9xLPpPkLa02Wf9gampGhlow90mpBgOFh8LsGb94/1RdABuTr1QyXQZpJC8k/o=
X-Received: by 2002:a2e:5356:: with SMTP id t22-v6mr3916522ljd.26.1542807436617;
 Wed, 21 Nov 2018 05:37:16 -0800 (PST)
MIME-Version: 1.0
References: <CA+onWPcgHMCffjfNO3wxMwVD2bOJzWmwtYtrj9QakDUEA=OXqQ@mail.gmail.com>
In-Reply-To: <CA+onWPcgHMCffjfNO3wxMwVD2bOJzWmwtYtrj9QakDUEA=OXqQ@mail.gmail.com>
From:   Jamie Jackson <jamiejaxon@gmail.com>
Date:   Wed, 21 Nov 2018 08:37:03 -0500
Message-ID: <CA+onWPe9hmr36xvc9F58KwW5fyby-wn6F2hiJy9ce__sA1mSjw@mail.gmail.com>
Subject: Fwd: "show-ignore" problem after svn-git clone
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm brand new to svn-git and I'm having a problem right out of the
gate. I suspect I need a different ID, but I have no clue how to get
it.

Here's the failed attempt:
https://gist.github.com/jamiejackson/57e90302802f4990b36dfe28c3c71d13

What am I doing wrong?

Thanks,
Jamie
