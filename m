Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C84B01F516
	for <e@80x24.org>; Sun,  1 Jul 2018 05:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeGAFSI (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 01:18:08 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:41189 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbeGAFSF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 01:18:05 -0400
Received: by mail-ua0-f195.google.com with SMTP id t14-v6so1295121uao.8
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 22:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VBM7N9yZyHyNtcxU2pWic3u5mE7xLhbbXqAgXSxMF7w=;
        b=KNS/5k68Xd4q9b8aaO2sgOmG4G5u512zNGIzEAMA4NMsTQlr24D480zwx37uZ1h35Y
         NOvoByxTbxZ2I5qkwRgkbtIa7jtMnQILGkCYidaxl7oop0bPFB1UsixpHh/KzZmjk67e
         tNlI+6z99KE3ZxILx39DGDZm2dXp7MJUsRBUVJebekqFJvta9UtKfa1Axr+Af+rGIas6
         boi1DElfRd6bl5DvMied22+gtYqTlVtclpXbVWXxpdlgg+55nLBZFTEbLKdU7r5EmaYE
         vI2oi4lPFLp/pkFl2LNMWLiIw2ZF6K8q6sMnzy7amoteNCmiDdrGgq2HB+w+vGHEZYt6
         a00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VBM7N9yZyHyNtcxU2pWic3u5mE7xLhbbXqAgXSxMF7w=;
        b=YL1DV4TD8zOm07PilJb4EZOH2kQVtmzRJBuuJAF24G9sMMilqDEt22rgicIxSjHFZ5
         r/KHOYBFoDJlPSJ7RZzENKd22/X75sp5ZS5n0LWrVK5wSa4JcNl+CV9bc3CnbiwMsSKW
         sJxfe3J/SScSf4pyocbI8ypcXKe0ePllNymehum1/mS9gz6h7eKUS0NUBT6G9+maTMtR
         nfyMoxvEkVJQRwdmOJI9T06LSXh+Lo+Rf4unJ6u1qCzGoaM5vo0naoq9ACGEHRZq3Vlv
         OA45bS6KHZw/59FTKCKFF8l/YUlPZnBawKqnVX3wQqFAlTushDtf00m9gWBNvqp9t0a3
         OAjQ==
X-Gm-Message-State: APt69E0GiZHVp7HhidgwP9spcf6utDNZXwgzggzPC4MRu8bDrQNs95+2
        o4/JLjTwGYL5iWBx29G230pjKQZqm3wBjNASTK8=
X-Google-Smtp-Source: AAOMgpeRv895IJIRDnxHZlmWsPtiip9l8QhfkHkbj/0VogvEoG1GD+HPtOMGqaUE9MXEidX6ChtIjOLgIEknZvskWRk=
X-Received: by 2002:a9f:3563:: with SMTP id o90-v6mr8118236uao.79.1530422284491;
 Sat, 30 Jun 2018 22:18:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Sat, 30 Jun 2018 22:18:04
 -0700 (PDT)
In-Reply-To: <20180630090818.28937-5-pclouds@gmail.com>
References: <20180630090818.28937-1-pclouds@gmail.com> <20180630090818.28937-5-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 30 Jun 2018 22:18:04 -0700
Message-ID: <CABPp-BGTAGaQm7D3QSdMbcK0abNNhLwfwHj_CoAuedCSoKWvZg@mail.gmail.com>
Subject: Re: [PATCH 04/23] builtin/config.c: mark more strings for translation
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 30, 2018 at 2:07 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:

>         if (show_origin && !(actions &
>                 (ACTION_GET|ACTION_GET_ALL|ACTION_GET_REGEXP|ACTION_LIST)=
)) {
> -               error("--show-origin is only applicable to --get, --get-a=
ll, "
> -                         "--get-regexp, and --list.");
> +               error(_("--show-origin is only applicable to --get, --get=
-all, "
> +                       "--get-regexp, and --list"));

I would have expected the fullstop removal to have been part of patch
1 instead of this patch.


Didn't spot any other issues.
