Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12411202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 18:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754938AbdKASNo (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 14:13:44 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:45076 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbdKASNn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 14:13:43 -0400
Received: by mail-qk0-f182.google.com with SMTP id f199so3785047qke.2
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 11:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YGUV93l1tAN4LlUnzLyFuWfVY1lQSIDdZsWN0vX6Jrs=;
        b=fNW3rM8f7G7FhkpjH+d9vaTRyXcjbaFZi9DfnnUOYMnhMwJ5hxiME34Y410tK2/Z0b
         gGGdL/3mS0lCqe/PvXHUfU4EQpz9niOe9LZ7ko6RLdQ31yhzLdsS37Dwu9f1iCqFvV3H
         Loj7z0CK6i2IYAiQ+h6jT0KINYWzF70yOqUodxavWhEQQdcF9Q/h+qVbkXqMRIkLjNJq
         wDkYD2vbxCy6s2SVU9gpgWCUO5VxTv+xf++CjAVG5rxhbQmJVhjePqo/1VGlcKyEN2b1
         wtOFD2XAvawQJoYHvHBjy6ElFHrixS/5INk+3dhnCoaHxjo3cSN4w2P2r0jvF2eoHl9M
         fbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YGUV93l1tAN4LlUnzLyFuWfVY1lQSIDdZsWN0vX6Jrs=;
        b=SMUT5hWluvDHkWMQvDV/inNbELhWlZNNK3AEtImtvoLIu7dWpoGrahnfG7GJDdys45
         6xdOAvoA2e0HmmH239eu5ykQnb0bR+8PSuctII7dBXN6oUrjonX7WnRp5BaugvAqRNLL
         rhhCHOUjzCEjb7WwelZJW4fqzUqXCBKb35yvM7vcP+MwZxmFaESXXquQ+0ijfiDP2h/m
         EdtvS4sZEo+x7bbArHle7wmMp2VSjGOOboVvzAMX+mOyOjUH3MiQgquDzWXcOI5d0xb5
         befKGzGlJgKTKO2igxYjc4AUscLgcFnqSDilPyu7t9yU0ExHWrpO7IQ4krGdKN831Ftu
         h4ug==
X-Gm-Message-State: AMCzsaWxBuz6e7ZrCLdM7EMGAEVzMuYRP0PoCNIUw5dkwzvBFPzhdjk1
        qUb58zU7BwVH405ztkYSzug5CP1YrXAUaIxRt1zIuQ==
X-Google-Smtp-Source: ABhQp+TbfPj0taxGUglH4uyVChAArboc2j/O1FgJIQcupxtNR4doJjTFYgb9+Ob2m1NFJ3IYX3UH9zSHsvQefUBacaQ=
X-Received: by 10.55.125.196 with SMTP id y187mr1201164qkc.180.1509560022283;
 Wed, 01 Nov 2017 11:13:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Wed, 1 Nov 2017 11:13:41 -0700 (PDT)
In-Reply-To: <xmqqh8ueyet8.fsf@gitster.mtv.corp.google.com>
References: <20171028004419.10139-1-sbeller@google.com> <20171031003351.22341-1-sbeller@google.com>
 <20171031003351.22341-8-sbeller@google.com> <xmqqh8ueyet8.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 1 Nov 2017 11:13:41 -0700
Message-ID: <CAGZ79kY5ye-mXy--V9VfUR_zRTrL21VKt3HKghOAP7vHJy7LHw@mail.gmail.com>
Subject: Re: [PATCH 7/7] t6120: fix typo in test name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Kevin Daudt <me@ikke.info>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 31, 2017 at 6:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  t/t6120-describe.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Good.  I am guessing that you are sending this as the last/optional
> one because this was found _after_ you worked on other parts of the
> series, but I think it is easier to reason about if this were marked
> as a preliminary clean-up and moved to the front of the series.
>
> Thanks.

It can be independent even. I did not bother to put it on its own flight,
but I can shift it to the front of this series.

Thanks,
Stefan
