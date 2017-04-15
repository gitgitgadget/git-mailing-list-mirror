Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95F281FA14
	for <e@80x24.org>; Sat, 15 Apr 2017 17:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753899AbdDORqR (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 13:46:17 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33738 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752985AbdDORqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 13:46:16 -0400
Received: by mail-wm0-f42.google.com with SMTP id y18so4333848wmh.0
        for <git@vger.kernel.org>; Sat, 15 Apr 2017 10:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4b97FUN/6l9YeXlSuu0ZZ1CdFuxcIgsk0fO29ss80XQ=;
        b=gykdVK1LrsgRsQQBUoSAv0prnpGArV8oP4uJ06hvgLPusrGO7SGWQ0cB02bJzUiTog
         Rpo3GgnWnr2P1+jpWEXRWPkMDZty5d+s7mR5KTFyobgZuxawLiZ2xg02Itwu0qoFCt4m
         nVXk/tWDm7bCGJunAZAeT6mXViNVA4SPNjm4Xt2yV1WIAqwYD0SkKZrr7ZCX/DuEPtHR
         zHVH2+qP2/zRkVTZpKiuSrxt6xHTwfWcFIf7RMXhdXOglTarjBFBITqFf+g+wHGQvz8s
         8Di2VPlufzkZryyjDkH+kHgSGB9CVLrzKFdoJKqkawnhWmrFQS26IGVjBiW3I1omIZ3f
         UlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4b97FUN/6l9YeXlSuu0ZZ1CdFuxcIgsk0fO29ss80XQ=;
        b=qC3pN7kCS8G6eGhDM1UZWavXnvE+jxWe3C9lWWmZXlZL4rQ+mGKEmzUazx6fB/7xFc
         5HYo43piGvjNlymdEvzgcqh++2AIN0PeU6w5CIfP9FISGUrGjBiHQYwTl7VTGAvdKuPX
         dsHLdWnytAFCrdBsRhx5CPKxdfzpDCXjnHVLhLj55tRIYo/+ZCdSul/uOsfG+vJtIQH5
         wQGc4IHuwR313u21B8KMbm3faxYkmvxWNagMb3VcpBpfiwH2ZPM86236rx37LyD+4Y2J
         FxIroZXNYO/mNatIM/7W4Vd7S091lZUk4aN+z3rioVNoa2DmB5Mdw1Txr3efM3wilICS
         kL+g==
X-Gm-Message-State: AN3rC/5C2rfTRgXa1R4RT/dNKHrB58DlejR9U8l+QfYV/h91e4DtP3Lo
        cijzOVDWDBOEG79mTSTUWN1s+JSx+w==
X-Received: by 10.28.220.193 with SMTP id t184mr3134188wmg.63.1492278374843;
 Sat, 15 Apr 2017 10:46:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.98.212 with HTTP; Sat, 15 Apr 2017 10:45:54 -0700 (PDT)
In-Reply-To: <20170415144103.11986-4-giuseppe.bilotta@gmail.com>
References: <20170415144103.11986-1-giuseppe.bilotta@gmail.com> <20170415144103.11986-4-giuseppe.bilotta@gmail.com>
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Date:   Sat, 15 Apr 2017 19:45:54 +0200
Message-ID: <CAOxFTczZS6aDGzDVLskQGObtDOeLL_i3-8jJdh8OrQFXVGbOHQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] rebase: pass --[no-]signoff option to git am
To:     Git ML <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damnit! I just realized that I forgot to amend before the format-patch:

On Sat, Apr 15, 2017 at 4:41 PM, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:

> +signoff!           passed to 'git am'

This should be without the ! or --no-signoff is not accepted. Do I
need to resend or ... ?
