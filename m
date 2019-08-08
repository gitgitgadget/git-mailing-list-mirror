Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42DFB1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 13:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732811AbfHHNIW (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 09:08:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43362 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbfHHNIW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 09:08:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so44092268pfg.10
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 06:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YJAiwdzRMrtv/wY04OhBN8UZFYQLm8KJswzRJ2vc8Fc=;
        b=RtfX0VEiob2q+n7NNNRs1HnsmNMFItkR6yMFumRlbZtJ0rjMo7x5UJLr+D/RJiMBC4
         q76zHnmIAeIvB+SLK4fhJ7ROjgJdtfLfScYQUXwtjbVhS21Pcbe3PWEMtLB4opPykuNz
         U9HgJEsfUgK7SFGEGNHH/XG5pqEIxHYE0tQ7t+tC+5xK2/pWBV79yiL63e1rgpv0FYr+
         LH3i/y2LhtapR9H6mx4+tTs5zMYA2+63b7r3K9KTc51Wcp5aO+hHP3+5r1M9RhTPaECU
         yOcj+HrBGVxnCMQ1q4pzlbfRdB9yQeLasP35EON4J7e2wvS29Tdq6Ul/kA3XO76FUcJc
         ykRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YJAiwdzRMrtv/wY04OhBN8UZFYQLm8KJswzRJ2vc8Fc=;
        b=QZAEn8k5340tNdsLY+eHLmF9AmKQxEjIETaeiu/rlIxo992iqZiZ2dE9aXlKKd7pn/
         KziJ+QMnMRhZM7H9QLFm9R2gNzzYAXLeoeRm2VYVKW6H8n4fhVNfNou1GNg9avHfNuu0
         VVaUjMqTMFIGO0mmsFtOBA1811S7Jv67dH9wHfSSyK/qeex4RQrWD7Xlm7qr9TTzGmyd
         4Y+S0tBhHcj0I8updljNQ/8GNoutde6WFWAj1Ov+NP+k/svOzR4KkkitPRs2EiLAznkE
         dFQ/fOSyn8PXjgInNXSYGxn+E87VDOOJ8K9XT1ApOgIczNQSppKuWrC1OmhoPmeDN2ea
         N0VA==
X-Gm-Message-State: APjAAAXVtVClXZmqeNrh5PHZZW6gGvHL4p4eh7nBd2RkirB2l9GCZT2q
        BBDk/jfd1gz0XBywAEOtf7Au1oLLHq5fN8zVdLA=
X-Google-Smtp-Source: APXvYqzHdIMfC4AjCDgXGmAufuA7fR34UmAqHkQwF/YT1f6O9ljbILQCcUJXcsh1RQCpwoifdRcvwvjihcAraUJCE6Q=
X-Received: by 2002:a63:d741:: with SMTP id w1mr12333849pgi.155.1565269701535;
 Thu, 08 Aug 2019 06:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1565044345.git.steadmon@google.com> <cover.1565203880.git.steadmon@google.com>
In-Reply-To: <cover.1565203880.git.steadmon@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 8 Aug 2019 15:08:09 +0200
Message-ID: <CAN0heSqGv3XKx+nE+8QqP6Wr7rpVtBHFqZuz1KaikRmq-yg8+w@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] pre-merge-commit hook
To:     Josh Steadmon <steadmon@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 7 Aug 2019 at 20:57, Josh Steadmon <steadmon@google.com> wrote:
>
> This series adds a new pre-merge-commit hook, similar in usage to
> pre-commit. It also improves hook testing in t7503, by verifying that
> the correct hooks are run or bypassed as expected.
>
> The original series was done by Michael J Gruber <git@grubix.eu>. I have
> addressed the outstanding review comments, and noted my changes in the
> commit messages in "[js: ...]" blocks.
>
> Changes since V4:

I don't have any more nits to pick ;-) so this looks good to me, FWIW.

Martin
