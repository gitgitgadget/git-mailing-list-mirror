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
	by dcvr.yhbt.net (Postfix) with ESMTP id BCB281F461
	for <e@80x24.org>; Sun,  1 Sep 2019 19:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfIATZc (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Sep 2019 15:25:32 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44582 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbfIATZc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Sep 2019 15:25:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id y4so1983362lfe.11
        for <git@vger.kernel.org>; Sun, 01 Sep 2019 12:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=33x6Toy6XQYBoGaEuOdO594CPAxsyfBTu5J59Vh6ArY=;
        b=sR7rTTV95ZWDBwERzOBmnBU8cqPOxzQrzhWIATbKt3NFl3fxAP+IYediAin6HTAA69
         M8PEJ2efYSevnOEsjQSCSxtO94jQ//uE+bE90ewK7bI8IsVzezbmgw3fUeUe5zVI+gAQ
         f36ETKziazwihhye/epc/bZVIX6IoLDKegkWLEsk+WXM3Q51T1tAYZOlE5HERFy1f5tx
         2VPfjvpS3CWciA3k3+0B5xUZj1U3cZ/6F9Zm8tse9CQuKSua8u4IKaKY4KmOT8vv1JMw
         neFxqT5zRfgfFaoBUQHacnNdCGGqreNvVp67Y9orvQOH6bXJbDQl4uIQ32mAWCdMVx/7
         ljZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=33x6Toy6XQYBoGaEuOdO594CPAxsyfBTu5J59Vh6ArY=;
        b=U5i+mvbGuhG8k3rtac/DSkLTnChdQthOVIAABQeNgD2SogblrN1xLbkfUPadI3WJ1a
         DrRNIrHeObhQT2+WJCFvYn1UMw13hkdzpn82crRw3xOEnHdowZ5T0JM+76EFAgmztOvm
         CwZm6REov1kGCY0I50LnPjZTHScg244wA8W21SA8sIW04U6wSVy78kHYg5JDEYoYw6ix
         ZCL1tkCknN/BYg0goWBXHik3TJUlJS8ZS/e4pTw74jxGRnwcj7/jqNjFtvFyux4sMSIO
         t9zMy6v9Fw2V9UHkKmfbOhP3jvZkDLze388HdPdLWZxVmrmkXIArdRRJq0T9Vr4QHepP
         cn/A==
X-Gm-Message-State: APjAAAXedc0IPjrl6TN9QdD4AoBWKqD71w8SB7HSoKvw5PDT47SCF7CE
        qZlkgmOh3hJyS1MOuI4OpQWlZ+FinVjoXt98o7MBne61sqk=
X-Google-Smtp-Source: APXvYqwZLA1dm/+ROPMC1nQRo36I1bn6WWCm15hTyUfeiOynQrqoJzHYPbTw6Tq0bXUjkiMz9ppvhjfN6k3rxY8oDD4=
X-Received: by 2002:ac2:5445:: with SMTP id d5mr6579921lfn.43.1567365930683;
 Sun, 01 Sep 2019 12:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqbmg13sxq.fsf@gitster-ct.c.googlers.com> <20190831122326.9071-1-birger.sp@gmail.com>
 <CAKPyHN0+KQTNe=Wc_6KEpbtd-KS1Y6a9ad=dpq9QFR-F5tvpEA@mail.gmail.com>
In-Reply-To: <CAKPyHN0+KQTNe=Wc_6KEpbtd-KS1Y6a9ad=dpq9QFR-F5tvpEA@mail.gmail.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Sun, 1 Sep 2019 21:25:19 +0200
Message-ID: <CAGr--=+H+kFVRDA+aJve1CjvQMg-uVArKOVCrndc=rJcmfvBeA@mail.gmail.com>
Subject: Re: [PATCH] git-gui: Add hotkeys to set widget focus
To:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Bert,


> But I don't understand this in full. Does this mean pressing CTRL+1 or
> +2 does also changes the file selection? Why isn't it sufficient to
> just focus the respective file list widget? And than have bindings to
> change the selection?
>
> Bert

I don't think it's feasible to focus either of those two widgets
without explicitly selecting a file. I tried it at first, but I
couldn't get it working. I'm not going to claim it's impossible (it's
probably possible), but I gave it up.
Consider this: when you click either of those two widgets with your
mouse, you're not really clicking the widget. You're clicking a file
listed in that widget. Clicking just the widget (in the blank space
beneath the files) does nothing in git-gui. You have to actually click
a file for the focus to change.

(To be precise, pressing CTRL+1/2 selects the same file that was
already selected in that widget)

Reading your question, I realised my wording in the commit message
wasn't very good. I'll try to improve it.


Best regards,
Birger
