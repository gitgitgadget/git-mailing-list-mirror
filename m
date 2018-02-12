Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0C661F404
	for <e@80x24.org>; Mon, 12 Feb 2018 18:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932360AbeBLSq7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 13:46:59 -0500
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34318 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932353AbeBLSq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 13:46:58 -0500
Received: by mail-yw0-f180.google.com with SMTP id z82so4163025ywb.1
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 10:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=L9ropqFGQUo7TzREXFofAr0AEO7A3uyRsmvVBNwDIT8=;
        b=fQ6x2tPxjqhzCJ2dhA68a1cqaVSBRMQ/6KlinOFebmrds+FUKo7qX6D2tS4r+YXJvh
         qGxuYzpUb974N1U3umKZYlrrEH3nuFeffl596j0pTgbFf4UVG1WRrtgObTxthti3Tg6X
         iWvw3taWz67WQkHzIekdH6fCxuvZxeVzulqsjlg6jRVottF9WHKbaUK2WMGVoDI81Aiz
         Hml0wEgV7n37z8lFLkFmbSqeU8//KovdrEIhX9TSmQYZ8HxNo/OI+d1z+rtKcJb20q6q
         gnRFmFDwYc2/PFKGiMdBCCFAha1uDoUuzj6S28ihqpG9dYkher7wVSG1VJHm6yMdSlPT
         Jxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=L9ropqFGQUo7TzREXFofAr0AEO7A3uyRsmvVBNwDIT8=;
        b=EQLiT5t23kWFsb8IaYr0rPu5q5AnztRQq05iKN6w4DalvumBxpo8sC9tniovT4d5vs
         KNhu6FWhZzCWfB5o/aA+JR506It/AlKN63baJBLPhWvbBL42LMOoKfM3KjS3KO3swVp0
         uqUYtqHpud+nMIDNk1wlthr7DnbW5RiyAw540gb5FDlZLSwR1NjD7nNAqUmEVhUJzvgf
         V9/uGfJkhcKbMrpc9aGdjVEaqv2yebp2cpxfWaqiPSvoUdBqC/oiT3GzDuebX5MbmonL
         QpSLm2gf2Dd5avlI5Ye1QMDd8vOBK27QeotUQnKNQfUn4kNAyBTgKu7ltTCLkN9tWr/J
         dOXg==
X-Gm-Message-State: APf1xPBvfac6cUww9V6w10OO1DEuaD8PFkD7xJQl8yyIcQf731I7hZRi
        gHHxwnGAmvjNSuUSOssED+TB7geLuSbT3K++2eBYtnkmveM=
X-Google-Smtp-Source: AH8x224TeF1PQW+EL++k1NrzP9OBAp2a/7AgQP1xi3a2Z8/XYdFk9Mj7zty8L4om9vIB28qHybm5H3sjYXK2lSWe5g8=
X-Received: by 10.13.220.3 with SMTP id f3mr8403341ywe.288.1518461217099; Mon,
 12 Feb 2018 10:46:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.203 with HTTP; Mon, 12 Feb 2018 10:46:56 -0800 (PST)
In-Reply-To: <f5c147253f852d1243613a77e2c8d97b@anaufalm.com>
References: <f5c147253f852d1243613a77e2c8d97b@anaufalm.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 12 Feb 2018 10:46:56 -0800
Message-ID: <CAGZ79kbLKhVprDoeUrzZ0572TP29WJu3BQgg1GoqvFTARRPaVQ@mail.gmail.com>
Subject: Re: REQUEST NEW TRANSLATION (INDONESIAN/id_ID)
To:     halo@anaufalm.com, Jiang Xin <worldhello.net@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 11, 2018 at 9:53 AM,  <halo@anaufalm.com> wrote:
> Hello git-l10n Team

cc'd Jiang Xi, who coordinates the git-l10n team.

>
> I want to join to this project as a translator for Indonesian language (ID)
> I have read the README file located in the
> https://github.com/git-l10n/git-po/blob/master/po/README directory
>
> I also have a fork repository master (git-l10n) to my repository (anaufalm),
> and also I have edited the TEAMS file by adding my name as a translator for
> Indonesia (id). And also I created a new file `id.po` which I copy from
> file` ca.po` as the source. Because I not find original file as english,
> like `en.po`.

cool!

>
> Furthermore, if approved, I will translate the file asap.

I don't think you need approval here, just do it. :)

Thanks,
Stefan

>
> Thank you.
>
> ---
>
> My repository (fork): https://github.com/anaufalm/git-id
> PR link request TEAMS: https://github.com/git-l10n/git-po/pull/288
> PR link add id.po file: https://github.com/git-l10n/git-po/pull/289
