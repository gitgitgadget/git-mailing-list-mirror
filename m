Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFC19203F3
	for <e@80x24.org>; Sun, 23 Jul 2017 08:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751127AbdGWIKn (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 04:10:43 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36144 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdGWIKl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 04:10:41 -0400
Received: by mail-lf0-f43.google.com with SMTP id d78so35102922lfg.3
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 01:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c4GTMW5pjqM4kVU7HOR8y0zxyEYftKu+GSdr4iBDpzM=;
        b=P7czcqr2gDJwt/BYUuBOrl0b04ICnrmbmMRfwbEVVoKzSXxADQ7t1cIZAYhs5+Kx05
         XPXGA5zobuBtiVWlAfqlLS34ZKPjUREK4HntmypvtUGKla32wkxNemLqPvsCkoU6NItm
         RGSjbSIEYAXJMUwS1kt5b4qpKMAzE+B9cAE9ftA2k3+p8PvvT5n73jkZYzCuTrQRMQ15
         hYOZYMrt31MJKZqI62YCc0VJdfqz6rhqGzT/pZCVDjtbFsI6V+207Uv5PXLMoqBm4/R8
         48JQrUfiNKztAQaO5VpzqUjR167Jg1k/BJf3xsBZ3SPthaX8IJCBBB2d3f8VmQzdaRPy
         SXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c4GTMW5pjqM4kVU7HOR8y0zxyEYftKu+GSdr4iBDpzM=;
        b=O55ZzI0/Bwe35v8UNFupwLIZHTzGNcijjgoU+GxBec0aXjEFySI83jbn8Mm7/XnKY2
         YD7UTYY5vIR7yLFyv+b3xqOEYOJQ27XVnVGIZG/PC0LhZXVCb9klaH4Ij8EUqW3mEAP0
         O+uRONIgGdBAz1HnLwSFSfJmEprF2OctFX/5SQXAa3KdUKMwH1vo7m2SHYsSpY9zZCpo
         iY6S6qj/MmDnHLvrvKOVHpl763yuTngo/zjXKj9P66nQPjIT0P8OW61glVCAFH0qjwMQ
         XCCWfY8iXI6zUDs9iQhmg4qNkyslTN/ZKIHQ49LuMvyRdvGNHhj87T4nEIgf2i3Nwvis
         d1Aw==
X-Gm-Message-State: AIVw1114MVyUaSEmJ193JWWQdxNJsgmmyewgcmG/GZ0053vjCYmlGcQJ
        OP6eT6piz2PIIF7V1CRxeq4lb/4oWA==
X-Received: by 10.25.74.83 with SMTP id x80mr3503215lfa.252.1500797439806;
 Sun, 23 Jul 2017 01:10:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.74.18 with HTTP; Sun, 23 Jul 2017 01:10:19 -0700 (PDT)
In-Reply-To: <CAGHpTB+dSGza5Lwg76WXg+pPZ=dz3QdCTnDozWG_y+5_bPor6A@mail.gmail.com>
References: <CAGHpTB+dSGza5Lwg76WXg+pPZ=dz3QdCTnDozWG_y+5_bPor6A@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 23 Jul 2017 01:10:19 -0700
Message-ID: <CA+P7+xrzLdGN1nkkcTH7iGBo1gg4GgPGYSgvF7-jw6LKj+WiBQ@mail.gmail.com>
Subject: Re: recursive grep doesn't respect --color=always inside submodules
To:     Orgad Shaneh <orgads@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 22, 2017 at 11:02 PM, Orgad Shaneh <orgads@gmail.com> wrote:
> Hi,
>
> When git grep --color=always is used, and the output is redirected to
> a file or a pipe, results inside submodules are not colored. Results
> in the supermodule are colored correctly.
>
> - Orgad

This occurs because color isn't passed to the recursive grep submodule
process we launch. It might be fixed if/when we switch to using the
repository object to run grep in-process. We could also patch grep to
pass the color option into the submodule.

Thanks,
Jake
