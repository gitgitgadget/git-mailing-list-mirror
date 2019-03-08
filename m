Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62F4120248
	for <e@80x24.org>; Fri,  8 Mar 2019 03:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfCHDkK (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 22:40:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38891 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfCHDkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 22:40:09 -0500
Received: by mail-wr1-f68.google.com with SMTP id g12so19804012wrm.5
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 19:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kLORRaHTczOn/xya2vtX3kzWuuFpCZ29jS4p4yAlv80=;
        b=DDtUoKOyirVX1xza1fY+jYKOEFFXpQbqwGAO+Is5xXvO4jE2+YRJOU3CZzKWQklapS
         35UacgXLgpjxyOdK8cp63ZdDwhXUVv6Kjxq7oKvYHoogSBJ6rz/AKNzzbbwhrcC8UiSi
         WsX9miLBE9mGCBfX8uvGVr7pqjAD3LKFzh3dnv5+cdpFtRJ8Uf1fgE07jiq1WD0UbP6C
         nOYnn3fervqBLZ6HVhDHHWTfEXmnGJisf9Egfk2gUJgYpFR+43wd6fl4xXSWysH7En6h
         6ucFRXVfTSLjUwkeRcci7ZsoAkJ2PVh2KJChXex8Pvc8T7meacIY8AGCQALsTeYzJDUg
         ohTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kLORRaHTczOn/xya2vtX3kzWuuFpCZ29jS4p4yAlv80=;
        b=Mw3HE/m+WuVYRJpQNwVb0DrY/nv5CafQwFOSIatHwSZYSa+TXZjaf87n4bwWiQ950H
         7/3EJZ0fR4eRiLW97FxpsULLEUq3Fz8hvzOT7/y3GkcT7i2ay1GGIRup1sOV3GH6bzYE
         HATznsQJ1MBFmU4gkPjmqU00QhLS2qly2gEq9Ajn9YhQdZK3CtGIQQVE0LynqzZ7/wMO
         FiUVE5AGPpQRpil9q/2IRs9UbKH6kU5yecvBXVQtyY6WwVYcehPlic4dk5fzeySlsSSL
         SiDQXk57zYd8hdEwX+CsAtXkRU8CQwQ0RiIoXyeeFyCH4YPhvRW5FpUTyY+kjiH6XV0t
         1Vuw==
X-Gm-Message-State: APjAAAXk2q/zLzRGwYFx04VA+ssaoqxT3DAt9rhSWJHfIkzGMSE2MMon
        t/35LAnT2rU6pKE7R8Xg6Ms=
X-Google-Smtp-Source: APXvYqyjPl9S6vONPD34yDkjbo/xY3faTuPvD0UtgLJFLUAMMExTAjC1J4FSdJkLAMBDRbOTtktD8g==
X-Received: by 2002:adf:efc2:: with SMTP id i2mr9057411wrp.44.1552016407704;
        Thu, 07 Mar 2019 19:40:07 -0800 (PST)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id b197sm7826421wmd.23.2019.03.07.19.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 19:40:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 1/4] merge-options.txt: correct typo
References: <cover.1551940635.git.liu.denton@gmail.com>
        <cover.1551951770.git.liu.denton@gmail.com>
        <1076d4c45108b1edad48fcac0f203c8c4e521b79.1551951770.git.liu.denton@gmail.com>
Date:   Fri, 08 Mar 2019 12:40:06 +0900
In-Reply-To: <1076d4c45108b1edad48fcac0f203c8c4e521b79.1551951770.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 7 Mar 2019 01:58:27 -0800")
Message-ID: <xmqqo96mjap5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> The scissors line is included after the human commit message. Therefore,
> saying "scissors will be prepended" was incorrect. Update to say
> "appended" which is more correct.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>
> Notes:
>     Note that this can be squashed into 6f06b6aeef (merge: add scissors line on
>     merge conflict, 2019-01-22) if it makes life easier.

The reason why you had to make this as an incremental on top of an
older codebase (cf. Phillip's comment on 3/4) is because it is
already in 'next' and we do not wholesale replace.  I suspect that
we merged it 'next' before it was ready---sorry about that.

As the original series dl/merge-cleanup-scissors-fix is a short
series that is only 4 patches long, let me kick it out of 'next' to
make our lives easier.  That way, you can send the squashed result
as a fresh iteration, solving what these new 4 patches tries to as
the proper part of the series, instead of making them as if they are
afterthought on top of the original 4-patch series that was
incomplete.

Thanks.
