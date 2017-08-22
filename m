Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 241761F667
	for <e@80x24.org>; Tue, 22 Aug 2017 22:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751816AbdHVWDi (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 18:03:38 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:32787 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdHVWDi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 18:03:38 -0400
Received: by mail-oi0-f42.google.com with SMTP id f11so448283oic.0
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 15:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZMlBtXNhKBY4Z37YCwayVVWZXiF5WxzhVAqiz4vrn+w=;
        b=Yx6XILGq4phT/kJKQDlVofus/bmWEVs6utldIOQSM3oPy0a4DMMuPmAosInyVLt1Y4
         7MT6shTUHcvPIJhGoK9GW2fnQYhAhYgMkZkj52ET0MYn+hY7Bc6R7O3dqr79Q/WO2Eaj
         J703ItoFA0y4vbFF9GaUxP5AtjZMNHbPhMF6LnZITAgKxxJjDEm6z1STVRIwGEANhxpU
         oQGeMk6vlZoPGSDBS6snN7AMikstB+2F0gDIrQKyUiW3TjaXptNyflF/f+ijL+/Hwi4C
         QnMqeN9S/m+LGTiX1D0NJxE2tlOUnxtzBprFswvOC/Qd8KkhatPtkraAIIURCWU2ZIIN
         CqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=ZMlBtXNhKBY4Z37YCwayVVWZXiF5WxzhVAqiz4vrn+w=;
        b=iGA7MOgINtUD+7x3RjNi2YLiwSggS+PPyY6JiLbJOsHJTDbSK3lApEKCYBeKvFUtsM
         BkFtEskCaB7ynlJw+qJGaJX6m6UPmUhtbyp4GXzRyD+spkscv/zLOfb9JyYKYdDs84G/
         KTkp36eiOdKCmrZbKUJTrPV+medWVwRT4j6TjwH691SOKp4R+mRUjamLjFkvbluWNMCk
         fmSo7lD6VDpSyK70CeIYxQkIIBakDQyw6EE5VM05cZczJl+3MvCOGiYn+Tyc0xQ1Rzwh
         3RW1c9j3zQ0L2uufAVZNZqxT8ykaVN842xJAdONDZxYL1iTRIS4ioBBqKBBZ5u2gVHyE
         dqxQ==
X-Gm-Message-State: AHYfb5ivt8nYHMGkFK0rJ8k8h0BEosplS6FZaUkWgkLZHk4msr9CbZjw
        WTp7b2Dd8Wtj6BUVwdrx46d8UcNCUqea
X-Received: by 10.202.69.85 with SMTP id s82mr843852oia.308.1503439417580;
 Tue, 22 Aug 2017 15:03:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.98.28 with HTTP; Tue, 22 Aug 2017 15:03:37 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <CAGZ79kYyO4zvmTvMpxpFyBEs4f=xoy_-UeSbmi9W-OCFz0kCwQ@mail.gmail.com>
References: <CAH8yC8=A0-geqduTNNJw0yb1BREqsB75_bKSp+06Rb5fY6oiuQ@mail.gmail.com>
 <CAGZ79kYyO4zvmTvMpxpFyBEs4f=xoy_-UeSbmi9W-OCFz0kCwQ@mail.gmail.com>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Tue, 22 Aug 2017 18:03:37 -0400
Message-ID: <CAH8yC8nu7zDmkQMZ99SpePXL1WpvvcOdQDAtwdo4WXiPiR3tOQ@mail.gmail.com>
Subject: Re: How to force a push to succeed?
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2017 at 5:57 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Aug 22, 2017 at 2:55 PM, Jeffrey Walton <noloader@gmail.com> wrote:
>> I tested some changes that lead to a dead end. The changes need to be
>> removed. The changes were added in 7 commits.
>>
>> I went back in time to the point before the changes:
>>
>>     $ git reset --hard HEAD~7
>>     HEAD is now at 559fc3b Fix benchmark selection code (GH #464)
>>
>> When I attempted to push:
>>
>>     $ git push
>>     Username for 'https://github.com': noloader
>>     To https://github.com/noloader/cryptopp.git
>>      ! [rejected]        master -> master (non-fast-forward)
>>
>> I tried to commit, but Git claims there's nothing to add:
>>
>>     $ git commit
>>     On branch master
>>     Your branch is behind 'origin/master' by 7 commits, and can be
>> fast-forwarded.
>>
>> Commit seems to be the wrong command as Git appears to be trying to do
>> something I don't want.
>>
>> How do I force the push to succeed?
>>
>> Thanks in advance.
>
> Checkout the --force[-with-lease] argument.

Perfect, thanks.

Jeff
