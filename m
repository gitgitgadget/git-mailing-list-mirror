Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB5621F404
	for <e@80x24.org>; Sun,  4 Mar 2018 02:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbeCDCrW (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 21:47:22 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46399 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751340AbeCDCrV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 21:47:21 -0500
Received: by mail-qt0-f194.google.com with SMTP id m13so16561593qtg.13
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 18:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=36IvzvCLYhrw6S3StcqY3r4c9/whDSXZpsH3W9sh9Zs=;
        b=ZHuW/8eF/Vy0d2YwsR7WC4H3VsZJ8dS14EPVXJZm1n5RVZVXQ3YWMjG7sFHicVGd8y
         4pjcjNa4rRGfviIgBAyG12FBEjhRxlGUPJl+jOoOLbZkmJhNh9lzIl3PU5sSfjI195UW
         xclUhEoIK+gszdaQGG/4gNnhpI+7MFvOJitHsV76e85RpE3XbR2ce9Hv2YLYNNt5yqrD
         1I4sR5OYVHmIuQSCR9hnMHUsV8XBSqlJtW0WR+RRAaRmADyNCZ2rXW9gVcXEjZ9bHRGQ
         tYbIbQUCFs6CPOaB8cnwCjIkCcSvHJo7Uq8OoJxgTzpaxJIQlGSbvIx87xsIdzdhK/I4
         EjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=36IvzvCLYhrw6S3StcqY3r4c9/whDSXZpsH3W9sh9Zs=;
        b=iEFSxBWq1M1BHzzqKiXYN5xkkO8anegb7pX3EFA6iPoAxrtDw54KToaV7Jpd0MSaz/
         2e6u7RHH6BCzUZ1thEYsHOlP4byPU4fwHwB3Fq7KwDCCW0T3ZusC92OIpcNi1oNri47Z
         zZU6siXMmDzPdI+YgtPXZiJU1AjveANo1aPVrBvTIlz42EExRgHzIsmOHF5z+SzkohA7
         1V+io/J7A2LeXsnH+ya9sBHUWuvmM+g2OhCu34fkMI/Q4FTFFrbFEOBdFGLm3sVl0EfY
         nSrgz33JrK1VSlELOYOwY1d4a3dCYX3uNlT0CrRD88K07p5sFG470bCRrApmtOhSC2VF
         LXUw==
X-Gm-Message-State: AElRT7H80l01X8BBhGCC7bAhKRKvtj2FfKseqjWyTSmtJp9dhDBQYuQj
        U6Y9MOpjLIeHk/vQkZk2W5OqP9sX+4gRiCVZ5TA=
X-Google-Smtp-Source: AG47ELvNFyja5+7C0n5hsPFO55VBYqEb+ySlNKnOSAHJDaR6LWfo3Ux1P93ufjX9O2+hIrGNj3nDaBCQgWAa0I4UdRM=
X-Received: by 10.200.12.198 with SMTP id o6mr15680512qti.246.1520131640412;
 Sat, 03 Mar 2018 18:47:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Sat, 3 Mar 2018 18:47:20 -0800 (PST)
In-Reply-To: <20180303113637.26518-14-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com> <20180303113637.26518-14-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 3 Mar 2018 21:47:20 -0500
X-Google-Sender-Auth: qAMqKW2QsC6q11SwiHstIku6ivk
Message-ID: <CAPig+cSE_x2f_8RG151MX3+FJhiofBPoVPXP+mxdJpoHXwjv9g@mail.gmail.com>
Subject: Re: [PATCH 13/44] pack: move approximate object count to object store
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 3, 2018 at 6:36 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
> The approximate_object_count() function maintains a rough count of
> objects in a repository to estimate how long object name abbreviates
> should be.  Object names are scoped to a repository and the
> appropriate length may differ by repository, so the object count
> should not be global.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/packfile.c b/packfile.c
> @@ -813,8 +811,8 @@ static int approximate_object_count_valid;
>  unsigned long approximate_object_count(void)
>  {
> -       static unsigned long count;
> -       if (!approximate_object_count_valid) {
> +       if (!the_repository->objects.approximate_object_count_valid) {
> +               unsigned long count;
>                 struct packed_git *p;
>
>                 prepare_packed_git();
> @@ -824,8 +822,9 @@ unsigned long approximate_object_count(void)
>                                 continue;
>                         count +=3D p->num_objects;
>                 }
> +               the_repository->objects.approximate_object_count =3D coun=
t;
>         }
> -       return count;
> +       return the_repository->objects.approximate_object_count;
>  }
> @@ -900,7 +899,7 @@ void prepare_packed_git(void)
>  void reprepare_packed_git(void)
>  {
> -       approximate_object_count_valid =3D 0;
> +       the_repository->objects.approximate_object_count_valid =3D 0;

Not an issue specific to this patch, but where, how, when does
'approximate_object_count_valid' ever get set to anything other than
0? Even in the existing code (without this patch), there doesn't seem
to be anyplace which sets this to a non-zero value. Am I missing
something obvious (or subtle)?
