Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6665B1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 18:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758200AbeD0Sqn (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 14:46:43 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34452 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758154AbeD0Sqm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 14:46:42 -0400
Received: by mail-pg0-f68.google.com with SMTP id p10-v6so2199260pgn.1
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 11:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cRkH2TqxUKTiwHj+hh3+GTn43jJiLMwIItx38fA5aUU=;
        b=UURiV2FXgz09rNdZgfrjXy5VyhCm+GaFD9WYaRN2+afFom3grL0ZPjcSOLPfVCDpy7
         HgOs3DqnnfX5R6IRaMxecpuCol45VoL4isdS8TFkqe8xPT+pJ8mB7EB7qaBFmNNFHu4O
         SUYOK+DJdLshF0SCXpo5NC1Dbh2MtQZUZJrxumj5QY7N6O9nKcMGDMnxPHIPBHiqZD3n
         OpqGSc91U0Jf70Zw/Y0eDrVlje+u12aJz0egbkm7gvBI9YSTVCTqGCkq7K97HdbOiBsG
         MxebtWG9Ptx/1V05YZk+E5/w72DDI7aL7+Cd0NYh2WvBrsWAAjqIAgjql/ZB4ED+ZJj8
         C+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cRkH2TqxUKTiwHj+hh3+GTn43jJiLMwIItx38fA5aUU=;
        b=HOEZrs5UAZWC4rFrt8YxuN5A+G/cZyw1nBa4lXuTSoWz7l3qgXMV9Okw7J3slZ9Wc4
         EoBfL1gj+/8rWeXT4n8AilmGyZ3bXvFg646bP36mXpuk4YxqKnRCja+Csq2w/LJuvq9G
         RxF7pP1L+tK225eRdthRKN2xyeS07LBuG8myPgVCMjH51P5V484KLETUPGMHtF8H172K
         TwlQ7p1ezzYKKKtv58JY4IqqyKRsTRovlYf5CgkcsdolJ5RrNq1RFJWIaVEXXL8zxQHb
         nBN87tNS/BDFbIsTiwRaFxOetCbzIilyq00y+CIn7evgrDAKSdCrRRi1mRdek74alWo1
         /xzw==
X-Gm-Message-State: ALQs6tAuviWAU/j6PDLdALrpQNjVRX+kwGadpmjM09q9h7/h81cj/THJ
        duMbc7jmB4KkC5XliUPS0EvFPcRcZKbDs4QDsPs=
X-Google-Smtp-Source: AB8JxZpfSTJJN3tP7TX4geGq/JvR7W3W7ltRCf6nuWSSegtLH2wOrZRrCS4XNTai+3iMgkw0M84OSdBlWKRgyQHaoYs=
X-Received: by 10.98.216.199 with SMTP id e190mr3140219pfg.161.1524854801669;
 Fri, 27 Apr 2018 11:46:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Fri, 27 Apr 2018 11:46:40 -0700 (PDT)
In-Reply-To: <20180427170440.30418-2-asheiduk@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com> <20180427170440.30418-1-asheiduk@gmail.com>
 <20180427170440.30418-2-asheiduk@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 27 Apr 2018 20:46:40 +0200
Message-ID: <CAN0heSrd8ej0YMmWrNXw-DRpwEZi=sTL91zNFvHA4tiqz=KAfA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] doc: improve formatting in githooks.txt
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27 April 2018 at 19:04, Andreas Heiduk <asheiduk@gmail.com> wrote:
> Typeset commands and similar things with as `git foo` instead of
> 'git foo' or 'git-foo' and add linkgit to the commands which run
> the hooks.
>
> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> Reviewed-by: Martin =C3=85gren <martin.agren@gmail.com>

Indeed. The difference between last time (the original patch and the two
fixups) and this patch is precisely the small tweaks that I suggested.

Thanks
Martin
