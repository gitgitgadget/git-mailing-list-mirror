Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 877331F404
	for <e@80x24.org>; Thu, 12 Apr 2018 18:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbeDLS3l (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 14:29:41 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50803 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753093AbeDLS3k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 14:29:40 -0400
Received: by mail-wm0-f68.google.com with SMTP id t67so141754wmt.0
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 11:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O1L3o2hD3hfPGP/8Td4exp/fXvCYB+498R3vVF/SXI8=;
        b=WeyQsiC6Yingszn+pWWVUDypM9+A9clwrrl2/zgUtWwBAQgNgYPfoclvMb1qC6Ax+w
         z/E9y5ArDBO19TZKFtNkpXzp5J8kCEkCCSqmJbwU/pyU+gZRpzPkxIGNf5WfJuNYG2V6
         9lD1ooCQrbaAenmr+FW/T8jaY2J5L3ivA+WcH/NkcjVsTZnzidl6chnxiIO09Bt+J1bh
         sW9pInig3GWfQiQKDxUcWvl2w79BjrI/cjrdv/xRQAMNJEWtKkRIgCuVjsrGItJLeYsB
         91nFvEvdf1c0KEdIjfERMaDFMzUTNPQP4cwwYU/O29Hp26alHV7umi+yISM8PyNG76bm
         Kqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O1L3o2hD3hfPGP/8Td4exp/fXvCYB+498R3vVF/SXI8=;
        b=Vo9pQO+nvwjqm0Z/gHsHN8FEPMiiQC/lRxXCSwWeWwp0sKt45mj+xCk/1fRj47zRzE
         UuniXWEd6gbmKHsFxwmx8PKpcTc5/TDwqPwfH8BlYZFFHBNZny/QFIPKeyNnBJQuY5nR
         haYMpR5rC9JRvdrD085jLuR8/HkPk0ipRnA6dxwznEPfZLvF5frz5MyAPin7rwVeLHx5
         eJKi/gQrh1g49UR3XKsHzlLm4WrP0mmm9Ht7VbnkJgdUoCtjWct5RYViuRRyTsvC1olW
         CFKYoCB+oO5ZyehtFR7bwEj/JvJfdCNXn7wY7W0BTYALmaabTw4YM9YE2Z7AESXdsou5
         w47A==
X-Gm-Message-State: ALQs6tAbaS43UqlLIC0hnnfEX/lxycjwkudUzr9//PI+CuInoboM9+pN
        x5tl7Nur071urUSQ7idg5WCVDqOwtqPwv4KDGpLdIQ==
X-Google-Smtp-Source: AIpwx4/wsxNBqSF2pY85tLWURcX0REbqVQybQeKW8R2S1t9AARsNcdOFUvlQhakcJblam2+S/1mU8PddmWduWGndOTQ=
X-Received: by 10.80.136.7 with SMTP id b7mr16866272edb.236.1523557779082;
 Thu, 12 Apr 2018 11:29:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Thu, 12 Apr 2018 11:29:18 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804121102260.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
 <cover.1523362469.git.johannes.schindelin@gmx.de> <a162afa761e3000eb60169fce7a50938888f80b4.1523362469.git.johannes.schindelin@gmx.de>
 <26c21a44-92b3-80f4-5211-034c64f7568c@talktalk.net> <nycvar.QRO.7.76.6.1804121102260.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 12 Apr 2018 11:29:18 -0700
Message-ID: <CA+P7+xrYe8tcRdk0_DZum8yR0=WLXgQRj4kkiQv_LBBcGoD=rA@mail.gmail.com>
Subject: Re: [PATCH v6 15/15] rebase -i --rebase-merges: add a section to the
 man page
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 12, 2018 at 2:30 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> I think it would be worthwhile to point out that unlike the other commands
>> this will not preserve untracked files. Maybe something like
>> "Note that unlike the `pick` or `merge` commands or initial checkout when the
>> rebase starts the `reset` command will overwrite any untracked files."
>
> You know what? You just pointed out a bug in my thinking. Previously, I
> thought that this is impossible, that you cannot overwrite untracked files
> because we labeled this revision previously, so the only new files to
> write by `reset` were tracked files previous. But that forgets `exec` and
> `reset` with unlabeled revisions (e.g. for cousins).
>
> So I changed the `reset` command to refuse overwriting untracked files...
>
> Thank you for improving this patch series!
> Dscho

Good catch! This could possibly have bitten someone badly.
