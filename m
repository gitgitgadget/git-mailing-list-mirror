Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24FE4208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 16:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754008AbdHUQnJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 12:43:09 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36220 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753830AbdHUQnI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 12:43:08 -0400
Received: by mail-pg0-f65.google.com with SMTP id y129so24533031pgy.3
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 09:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1+FIB7ul8tgqq1Fb10kY/JSZnrX1UBgbefFeJVH3hCg=;
        b=jSrkQea38I5WVGpZYwciRdc7fLjJbreSFF/qr371xTvlNLt/Vd8+bLa87f7sU4d8uY
         od44Kywec6rYE6v6QIqGB7BE5CV2N1YYD44YY2p5Y4UI6D2b1lbEU6Dsp8hvZVg+a9mM
         6qT6/mPpgl9bDn7orJhcJ/LHTXO3uHY8q8e6w33xCVBxymHvkDOEsbVlxAtM/EpYyulX
         FlloSFGUjn97K4fAjFw93Hv8hATtkSZGHW/zapfYmJF46AXFUue8knM8NBgBBfFRpFvc
         hwihWB2kaUn7BH2wQTJNu5zywjLttzRyF0E8NdYyDkPbmoTGiybffS6dVzCCOSyMlUEj
         d7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1+FIB7ul8tgqq1Fb10kY/JSZnrX1UBgbefFeJVH3hCg=;
        b=gew7eE05eV8h/DnqfML2lNB/TEpcMNsmZJFGtu1Rc9IOAoygGESu6pIpl0NNp5I75G
         8YbH4YhO48F7FAd0XeoBz+U0bnjhgKDKxK43AiTWFNuxa5Yfc7lzV77eNzkTjfBMBhr1
         hIYrNTLFwiVz2XuxX6xNU80J09lSdKjLR0f8fsTQMf7zKHKFaraLr4LirJIRN48quqob
         Nu0jPQyogm8ACQ0ChoT++dpjGaxIMOWjw3ivBnW/tDwYZEac1y+gFSk9yUhEk3fRnMpa
         j04EdFcfRiB930UbwfF4wXFyHUqPg6o2PsOUW+9i381+M1ERivV4P9z9Us372DLYZcLt
         bPUQ==
X-Gm-Message-State: AHYfb5g2z4jHFDcwvaMXpPYoD6EN613LZrduwlQR4dZI28C+5tYejuiu
        ZGg4+fnda96Lm4hCw/ZDXV2D6JbsVA==
X-Received: by 10.99.105.8 with SMTP id e8mr13247509pgc.165.1503333787935;
 Mon, 21 Aug 2017 09:43:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Mon, 21 Aug 2017 09:43:07 -0700 (PDT)
In-Reply-To: <ddd9c06813f8e2e9d8160f2ed965e728190bc573.1503319519.git.git@grubix.eu>
References: <cover.1503319519.git.git@grubix.eu> <fe681e447791ded6db52ccd84e64e3637c08ffe5.1503309751.git.git@grubix.eu>
 <ddd9c06813f8e2e9d8160f2ed965e728190bc573.1503319519.git.git@grubix.eu>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 21 Aug 2017 18:43:07 +0200
Message-ID: <CAN0heSrG7ackEW1BMpadNnPKSUCXATbxfUykcpppC6-Y2OCWJQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Documentation/git-merge: explain --continue
To:     Michael J Gruber <git@grubix.eu>
Cc:     Git Mailing List <git@vger.kernel.org>, hIpPy <hippy2981@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21 August 2017 at 14:53, Michael J Gruber <git@grubix.eu> wrote:
> Currently, 'git merge --continue' is mentioned but not explained.
>
> Explain it.
>
> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---
>  Documentation/git-merge.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index 6b308ab6d0..615e6bacde 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -288,7 +288,10 @@ After seeing a conflict, you can do two things:
>
>   * Resolve the conflicts.  Git will mark the conflicts in
>     the working tree.  Edit the files into shape and
> -   'git add' them to the index.  Use 'git commit' to seal the deal.
> +   'git add' them to the index.  Use 'git commit' or
> +   'git merge --continue' to seal the deal. The latter command
> +   checks whether there is a (interrupted) merge in progress
> +   before calling 'git commit'.
>
>  You can work through the conflict with a number of tools:

There are actually two things going on here. First, this mentions git
merge --continue. Second, it explains what that command does. But the
latter is done earlier (not exactly like here, but still).

When git merge --continue originally appeared, this part of the docs was
discussed briefly. Maybe interesting:

https://public-inbox.org/git/xmqq60mn671x.fsf@gitster.mtv.corp.google.com/

Martin
