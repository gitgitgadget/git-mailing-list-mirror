Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8D741F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 16:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388686AbeKPC6j (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 21:58:39 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39353 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388599AbeKPC6j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 21:58:39 -0500
Received: by mail-it1-f194.google.com with SMTP id m15so30195135itl.4
        for <git@vger.kernel.org>; Thu, 15 Nov 2018 08:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HHqkW5yWi1TflWUe+3KzHDKuol3aorPPiXxi6wS2PUo=;
        b=RLWO+gRxYw6wDR9etb3BGXL/ZgNhggX619qM/LOkI03DebtzJmCjWcq+VKlMntst3n
         CMeWsdzOHGBP+/pBzjgJjvjAfZRFmWLzNQDcbQgwwOXGgR8gvgGGE9IjTyQTZNQczWss
         aI3d9MVu0eXYh0Lu6S2r1BGVYeFaMrNSA35x/3ZqE2UpIOGHnJ62D6Y2MxmVLRndt2Vd
         AB/YEFzRJ8Aw/Of4XpOaJX/Y2xKnOyCj+jPqF4YpERl2ffpzAEfoe5e6KVM8DmYIFmhM
         J8KMW+fnfz50EPgfJBo9Eng3d+aTSveCkDojsRzRtFdeOKAs1+jqgn/5AazKPlcChqdI
         nzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HHqkW5yWi1TflWUe+3KzHDKuol3aorPPiXxi6wS2PUo=;
        b=KE2wcrKvqxByQp0iOlA86IbXhEWQF+UkfNlLp6L2oLP4a10EwO6lipfUT6JMKbTC+P
         ezG9f37PQpQhG5kGNpFOaA3UosKgFGS7QmuIwWu+noaI6j9KgJlTp/HZDGiDfiDGqq/Q
         fbpTnubmNowl2jWGxrWDFwpdD3U4As3WXdxzHn+XR6fS+3mMrXeQgU8zh0RME9x4nOAC
         G46KxW/qmsE9veBtPCQVHrcAFpjniUKO9JHgfliH4SNpZsOqDc4jtO50ZUqTuE7mUx76
         /mqqOunThv+M8OyDCSmJDzR545gCxo/mq6gxoextzZlXW7tft4ZFwiKHPnv5gVCp8b9d
         Rrmw==
X-Gm-Message-State: AGRZ1gJFzFzxX805I4e6PwPN8jpeTwTumjac6e/L+k6INql8j5Lo6puA
        hinYSSZU364CxXcNGA8Wsxtj1cLbbNFw8xK5CUc=
X-Google-Smtp-Source: AJdET5eTrSYvYItbcu2aZ1dNDw8N68LhDnhbPiis2YWwPamCsac7Xaou7CHpjy+UyhM/xKQTdwlGVWXKmWiL8/lNCLM=
X-Received: by 2002:a24:f589:: with SMTP id k131mr5814958ith.10.1542300604210;
 Thu, 15 Nov 2018 08:50:04 -0800 (PST)
MIME-Version: 1.0
References: <pull.79.git.gitgitgadget@gmail.com> <pull.79.v2.git.gitgitgadget@gmail.com>
 <c88887f05a145709be9e86d56f4c1e620eb5ea89.1542209112.git.gitgitgadget@gmail.com>
 <CAN0heSqsjKksKnBHjffVMDEyX4A2DAY6Naw4tbBXEm+AdhOLtA@mail.gmail.com>
 <CAGZ79kZ_wrQ=OdJ6xWbL+F5RDb38YAmzc87o8A=Zb8zBywMJBQ@mail.gmail.com>
 <20181115043409.GA3419@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1811151354150.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1811151354150.41@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 15 Nov 2018 17:49:37 +0100
Message-ID: <CACsJy8DZkEb6d=PW4bdkipTSkUSG7YUqk4tkG9PXx+bfngFW1A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] bundle: cleanup lock files on error
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        gitgitgadget@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, gael.lhez@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 15, 2018 at 1:59 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> So yes, we are trying to unlink the `.lock` file, and as far as I can tell that
> `unlink()` call comes from the tempfile cleanup asked for by Martin. However, as
> we still have a handle open to that file, that call fails.
>
> I do not think that there is any better way to fix this than to close the file
> explicitly.

I may be talking nonsense here but I remember someone mentioned
something about deleting a file while it's still open on Windows and
after a quick internet search, it may be FILE_SHARE_DELETE. Since _we_
open these files, can we just open them with this to be able to delete
them?
-- 
Duy
