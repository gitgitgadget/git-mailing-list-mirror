Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B141A1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 17:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbeKFCmv (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 21:42:51 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44138 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbeKFCmv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 21:42:51 -0500
Received: by mail-io1-f67.google.com with SMTP id c6-v6so7059303iob.11
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 09:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SceVV4qhpckl1KqG7R3fTdLFbueutuF6YP39AbvQ1mU=;
        b=aEtGFLFt86F8yfcKRxn/Ev8xlGd/o5d2PL4qWzW75Typ5o4dmUmI3t95+1XdbtHqF5
         BPxlizRw/+00ymEYWbm7UStlDytAh4s++hj7NR77iF+1y4RTntmd2lTTGB/IkYAF8+w8
         WpMTRMO9AMHmpecQeHjLRaSCPnZe1fMA+HAynrKMEjiTK/L95ezEsRdvrRice+k9GRos
         isqg2tF7wqBL4ijZrbAUtCwFPBZdCSC9XznzSOxdn2jzRJOW+GuDO/30xRs0drj1vfNd
         3P1NBGOFPSOVs8crStR3X/Vjx6zI8VOpXqIznYDYHQ2MLND07OfQiUsf1VtBtatvF1lD
         1/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SceVV4qhpckl1KqG7R3fTdLFbueutuF6YP39AbvQ1mU=;
        b=r19kIR4Lu2fpl+fZk1dKtJ0Lzrjwf5VYZFqmLrGsCVK7SVMYJaXYzrYT6HOzwyzej8
         F8wMcbAc2tsLKhx39XBd1DYA3FU9BLEHDWpF2RJV9zRYtPv6GAQ5YmAfkzlg82nbOjUh
         Mk2jOAZYBbN/FLWB7tZ20pWD4SqGlBbJjkMiNLiGU0pldvtA8y2D1/HND505QzPdnuxe
         NNsrL7A9p3vXvwrgZjtzjt543gTwo5NWZje6BagOGxlml1VCn7Iy8gOE9ecYetd7l4uz
         7uzp4fxwE6ya4hLS8Wgp4H++UdYrwsJFbZRKACrPVNVIhCdw2JPjuTuN7t3spsCCpVwk
         /w/g==
X-Gm-Message-State: AGRZ1gLZ1fKbNJHGQF8pJPdIEjp3t3PEgjakjbWqoNobu0YCIvvKjeMD
        bg+h5EUW1MetyA1cCMITHu9BTwNTNDSUfh1nNexkQA==
X-Google-Smtp-Source: AJdET5fJPnY6vOKGegxtUivwmZKa5RWe8XIaBZBFj3r6dlI3uwK0MgdEq9Zy3IsEuj47ZFTDS06gOlaXjMOGJPLFK/o=
X-Received: by 2002:a6b:216:: with SMTP id 22-v6mr18975930ioc.118.1541438530276;
 Mon, 05 Nov 2018 09:22:10 -0800 (PST)
MIME-Version: 1.0
References: <20181028065157.26727-1-pclouds@gmail.com> <20181028065157.26727-13-pclouds@gmail.com>
 <20181029105304.GP30222@szeder.dev>
In-Reply-To: <20181029105304.GP30222@szeder.dev>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 5 Nov 2018 18:21:43 +0100
Message-ID: <CACsJy8AG6BT6n0T=WWsoXauX_gpLHBaMSou5FJvBA58fU_wi5w@mail.gmail.com>
Subject: Re: [PATCH 12/12] fsck: mark strings for translation
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 12:53 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> The contents of 'out':
>
>   broken link from    tree be45bbd3809e0829297cefa576e699c134abacfd (refs=
/heads/master@{1112912113}:caesar.t)
>                 to    blob be45bbd3809e0829297cefa576e699c134abacfd (refs=
/heads/master@{1112912113}:caesar.t)
>   missing blob be45bbd3809e0829297cefa576e699c134abacfd (refs/heads/maste=
r@{1112912113}:caesar.t)
>
> On a related (side)note, I think it would be better if this 'grep'

I found the problem. Some function returns static string which works
fine when we do two printf()'s, one call of that function per
printf(). But when combining two printf() in one, we have a problem.
Thanks for catching.
--=20
Duy
