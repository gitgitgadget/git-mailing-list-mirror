Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0810120960
	for <e@80x24.org>; Mon, 10 Apr 2017 22:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbdDJWwB (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 18:52:01 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35596 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbdDJWwA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 18:52:00 -0400
Received: by mail-io0-f194.google.com with SMTP id t68so6654928iof.2
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 15:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l4hQLRqABKnIa9qBku7VNkb/8ZkzBoweB9/xOK9dMg4=;
        b=RT/cYRsmE5T4Sslcq01M+vLYTxawM9FHcrljZKy8NfUU5vmHK8OZfv2DIW4cE3c/ke
         M7WNm+6OjiETxpPgtfWjhKpu2CXmHGzSIlXZ/VY9J9tIEPrMKt4V2jv7YwUp5O0M54HX
         sFxYheB+JiUQnRcsc+fgHlkRl1PyS+bV2+nbv8y6z1/0oOcF0gvwWL8txungcTPqQD/m
         sM/UB6v568oEQ0lBYwhMbqQyTsVFR+R5QUIhWKA7qnrAKKDHW2Q6WAjak/sGdxHWiZtp
         sbXbiih4zlYJ+EtvkApawXbhqwJUd5wIBHr/tvPZx6aAAZ75mGVVPby2+K8lNBarN7so
         0B5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l4hQLRqABKnIa9qBku7VNkb/8ZkzBoweB9/xOK9dMg4=;
        b=Lg1DxLbzbHzS9TTla7xkQETu9mB7UJxJwUdwfNnISXXT5ot/ywL0xfuah0Sj7wL0kM
         7rxX0RGN4xZUEY9UPO6uFf6VMWdP6w12+Awz4lOmezCNxQnPJEvlV/TGEx951rhCoLQt
         VIHhsv/OJtbxl4BuJkZ6I3+e9sQHkofZwAI0ee4nZ7JpVf8CGnpe8JH0En9wo/AA3Tgj
         J/t+Y5VBwlJ2ZXCyEEwTbrKCIicTVa9Zfew3QvMzO70lATUaH8pST1riQkQzT+HKxm7J
         bOt3UGKC9Cnnej/FoWh1eKzME07myhhnbvKAcC3bNxd6v/9PDDG7Nb44vurxYxO8Cbiw
         Q9vw==
X-Gm-Message-State: AN3rC/68xUzf+j0JfsZ/ZGyv1Hw9wUcxxXHuAmCdSKPNmejLz2w8WKHd
        /0N3aZtio6yKh1XoNT4Of+phaiQBGNP5
X-Received: by 10.36.173.91 with SMTP id a27mr15287992itj.60.1491864719844;
 Mon, 10 Apr 2017 15:51:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Mon, 10 Apr 2017 15:51:39 -0700 (PDT)
In-Reply-To: <20170410221058.2ao64wedg2pa6uc2@sigill.intra.peff.net>
References: <20170410221058.2ao64wedg2pa6uc2@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 11 Apr 2017 00:51:39 +0200
Message-ID: <CACBZZX6TONCXyCbepDcSQuxoBKJAzVWPrBzUsozg5p2Hj-+JCg@mail.gmail.com>
Subject: Re: [PATCH 0/3] quarantine-push loose ends
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 12:10 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 10, 2017 at 05:14:24PM -0400, Jeff King wrote:
>
>> > Also, I think this whole thing could really do with some documentation
>> > in githooks(5). E.g. what hooks does it apply for? The test is just
>> > for pre-receive but the patch changes run_update_hook(), does it also
>> > take effect for update? Ditto the caveat about update-ref.
>>
>> My thinking was that the cases where the effects were user-visible were
>> sufficiently insane that nobody would need to know or care when the
>> feature was in use.
>
> I guess it can't hurt to write about it, though. Here's that, plus a
> cleanup on the stray tmp_objdir_env() call you noticed. The final patch
> provides some safety for the ref-update case. My assumption all along
> has been that nobody would want to update random refs from inside the
> pre-receive hook. This doubles down on that by making it forbidden. I
> don't think that's a big loss, because doing so now is extremely
> dangerous. If that assumption is wrong, the correct path forward is to
> make the quarantining configurable.

Thanks a lot. Cleared up all the questions I have, and now we have
permanent docs & more testing for them.

>   [1/3]: receive-pack: drop tmp_objdir_env from run_update_hook
>   [2/3]: receive-pack: document user-visible quarantine effects
>   [3/3]: refs: reject ref updates while GIT_QUARANTINE_PATH is set
>
>  Documentation/git-receive-pack.txt | 29 +++++++++++++++++++++++++++++
>  Documentation/githooks.txt         |  3 +++
>  builtin/receive-pack.c             |  1 -
>  refs.c                             |  6 ++++++
>  t/t5547-push-quarantine.sh         | 11 +++++++++++
>  5 files changed, 49 insertions(+), 1 deletion(-)
>
