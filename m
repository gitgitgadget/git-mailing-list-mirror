Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FBCC20248
	for <e@80x24.org>; Wed, 20 Mar 2019 20:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfCTUUC (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 16:20:02 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:34981 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfCTUUC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 16:20:02 -0400
Received: by mail-pf1-f172.google.com with SMTP id t21so1968233pfe.2
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 13:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aZyDZ/T8m2lm1VkVIVcTC+L/R+RNZLGf0R6TWzmX8FQ=;
        b=vKAnNx5EB7f5OsBouWzag7H1hkTuvF0lKIm7CADg/cDSTDlQme0JCX9uqJMdlLGQ3t
         r3FLwQVa2h8SD08ROF56TYhhLUY2nOtHkAJ6qENm3t8vshh6rl9/DclXzlyOMVk+Klps
         HiVbX2Rk39ERmqLWDGNGG/ZKKkrHY/xbrmsUokgF6uOTpQBnA+tC1WRt+DOfNVKhVuIz
         SewcFpqIVDrIZRQp2JJZw8y97mrnGZ7f+MbE3c8OS7AMYElrA/xvMDNy3i4sz+bVuNMH
         oI/pTZ7WlCdHIGI7IK6iRKAns3en6R8Bf26eduoHvKnKiUTa4m0YtFUl6vZY4bIkEsb0
         zZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aZyDZ/T8m2lm1VkVIVcTC+L/R+RNZLGf0R6TWzmX8FQ=;
        b=CsWh0MbgyvLgn8TItbSMuUbWIADSMW+v9G8mWVj0up2vjjramN7oQLu82p9Oc6GUDD
         nff/cWQb6d+VIjhek35eylASwsvX3vq8T9sTxpzwXfgRIpCgM5+ZYa0zUIi6IuAiyCto
         ua3Izm3ZofXYK4ZdPMU+026W2RgNucubqaArmPjEBR4k3oyJBckB8t803k69V2MRrCDD
         Ngzyh+L2iopz2f8jrhkH7jp2MbkyA3R9uPJjlECex5uknCMaScynbdzNH1MsPZrkH7cE
         3ziAmSs37vp+8N1HGUSLS/bXrYeNQgjRHpPFyxg27F/+x9adrJjjknQ4hojg+5P7G1R5
         l0Mw==
X-Gm-Message-State: APjAAAWP1wfNRYFF+N+JsSM5a2GqnIqtVHD3l6Fkmsn0LK546isxwpyj
        Do+OdzNnnc9jMZLlWPmW4BmHX+j9yFl5dJ91vKI=
X-Google-Smtp-Source: APXvYqwQU1NQajrwxF86fKkTQNp/EfImTybCkYipEn2CjQNkRfHwd30AQcW5JZsJm6REVLskUwFWFgLDiN5FlzfjhFo=
X-Received: by 2002:a17:902:6b08:: with SMTP id o8mr33346844plk.105.1553113201993;
 Wed, 20 Mar 2019 13:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190320114703.18659-1-pclouds@gmail.com> <20190320114703.18659-2-pclouds@gmail.com>
In-Reply-To: <20190320114703.18659-2-pclouds@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 20 Mar 2019 21:19:47 +0100
Message-ID: <CAN0heSp+QAXe1uMO=VC8bp09UC6S-BH=0RwkVMdDBhZC-dEbPA@mail.gmail.com>
Subject: Re: [PATCH 01/20] diff-parseopt: convert --ws-error-highlight
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Mar 2019 at 12:59, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pc=
louds@gmail.com> wrote:
>
> mark one more string for translation while at there.

s/^m/M/

> +               OPT_CALLBACK_F(0, "ws-error-highlight", options, N_("<kin=
d>"),
> +                              N_("highlight whitespaces errors in the co=
ntext, old or new lines in the diff"),
> +                              PARSE_OPT_NONEG, diff_opt_ws_error_highlig=
ht),

s/whitespaces/whitespace/

I tripped on the comma, somehow, and part of the explanation why is
perhaps because this gives (a few of) the possible values, but that's
not really indicated. Maybe wrap them in 'quotes', but maybe this text
is already getting too long. Feel free to completely ignore this.


Martin
