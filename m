Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E8DC1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 12:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752873AbeDYM0P (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 08:26:15 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37256 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752848AbeDYM0O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 08:26:14 -0400
Received: by mail-lf0-f68.google.com with SMTP id b23-v6so25206869lfg.4
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 05:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xA9D+KXdZP3az1+2xCC53oe2C5braBwv/CCprLaAqtc=;
        b=T32SAglst9zdOooZ+p6Bc9eZqEXcm5+JEWm+iQ+OTYffT5ZfioMg20hNoHV9irQUGm
         gzAwWH0VdwxUNT+RWYiWBIMtDWg4R649Z4j2tf81Z7qVXLWNi/zH84tX/q6Y7mJBnWEu
         VgfQzpow8ESL8n6WdwHEMfYB7YipDInOUVzo0bRHVbcA1V6iOnXcsVsXXsVI5Z3ZiSuH
         x5iHzi1X9usFlQjWeL6LpMfPXHWJktbVGu37Usb7HXSmwLS5Lx/GEHL93ZcS0VhTo3Bk
         MunEGZlCg2i1QjIIW0hNuLYEgRKqrxMcbN/tzF1g/zZxL7OBJUDsLYIytMcHuzalhAqG
         IG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xA9D+KXdZP3az1+2xCC53oe2C5braBwv/CCprLaAqtc=;
        b=ijePd/H64HodL9rjkiKwRqNkc/0qSGlaFQ7YKYxpmXCXf1+orVNxgXqtYx4AyIbgYY
         lLobIx1ezzXuo/P1h2Wi49yfTIC1TSY8N9svgD1LO/qGxVhHTSibEYzSSAtVij9mi92V
         TqaPlSyiHFr7NqwPYaq1Jyc987681GJ1ph952RNJMikcBFAsZtKFG6jzVnWN/3/kLQ8Q
         MuKraBpXQGavyu52Ij1WrLPiKEPmBeBePIhcUmU7daFaq+RlDlkT+MwCC8OIK9shS8fa
         +X5k8+FqsUWEkm6+yU8UbBGrJaFpAGVe3zU4ax81wTy9m5aDpMZIbzZPISxXygPlgaGE
         /Bsw==
X-Gm-Message-State: ALQs6tDGHkQjcjWAHv1+8SHo0epWLAzMvKUlams93z0MrSiOOVvbgFLW
        cs2kWBF/7CQy4BxSWcWHnXb6yxr2f1x9ku8b+UU=
X-Google-Smtp-Source: AB8JxZqvs8OJAlbtZlUrWEv6rXsvdUvC1CF/aIkcxfba5QqME3V0TjS2K3sLNhr4MmiGZPCepxVAi41ktYCp5elASiI=
X-Received: by 2002:a19:159c:: with SMTP id 28-v6mr14785862lfv.139.1524659173109;
 Wed, 25 Apr 2018 05:26:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:4a4c:0:0:0:0:0 with HTTP; Wed, 25 Apr 2018 05:25:32
 -0700 (PDT)
In-Reply-To: <a3403a69b692e4f4b0337800268a16818e790caa.1524650029.git.johannes.schindelin@gmx.de>
References: <cover.1524303776.git.johannes.schindelin@gmx.de>
 <cover.1524650028.git.johannes.schindelin@gmx.de> <a3403a69b692e4f4b0337800268a16818e790caa.1524650029.git.johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Wed, 25 Apr 2018 14:25:32 +0200
Message-ID: <CANQwDwfJgoXd+iH207S8WoaWOS4BQnrm+GAOtfe1BvW9uyKiYA@mail.gmail.com>
Subject: Re: [PATCH v5 09/11] technical/shallow: stop referring to grafts
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25 April 2018 at 11:54, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Now that grafts are deprecated, we should start to assume that readers
> have no idea what grafts are. So it makes more sense to make the
> description of the "shallow" feature stand on its own.
>
> Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Junio Hamano <gitster@pobox.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/technical/shallow.txt | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/technical/shallow.txt b/Documentation/technica=
l/shallow.txt
> index 5183b154229..4ec721335d2 100644
> --- a/Documentation/technical/shallow.txt
> +++ b/Documentation/technical/shallow.txt
> @@ -8,15 +8,10 @@ repo, and therefore grafts are introduced pretending th=
at
>  these commits have no parents.
>  *********************************************************
>
> -The basic idea is to write the SHA-1s of shallow commits into
> -$GIT_DIR/shallow, and handle its contents like the contents
> -of $GIT_DIR/info/grafts (with the difference that shallow
> -cannot contain parent information).
> -
> -This information is stored in a new file instead of grafts, or
> -even the config, since the user should not touch that file
> -at all (even throughout development of the shallow clone, it
> -was never manually edited!).
> +$GIT_DIR/shallow lists commit object names and tells Git to
> +pretend as if they are root commits (e.g. "git log" traversal
> +stops after showing them; "git fsck" does not complain saying
> +the commits listed on their "parent" lines do not exist).
>
>  Each line contains exactly one SHA-1. When read, a commit_graft
>  will be constructed, which has nr_parent < 0 to make it easier

Is the removed information (repeated below) important or not?

  the user should not touch that file
  at all (even throughout development of the shallow clone, it
  was never manually edited!).

--=20
Jakub Nar=C4=99bski
