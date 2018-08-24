Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F119D1F404
	for <e@80x24.org>; Fri, 24 Aug 2018 02:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbeHXGbz (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 02:31:55 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38347 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbeHXGbz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 02:31:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id h33-v6so2308658edb.5
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 19:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sIRRfRGjfu+e6/Wjg3FjKJVIuB7i8CBLtJCwEjLha9Y=;
        b=TtB+9l1ZClsttwnF2qjpS2l6U5lR+aVQIr0F2fSLkq5fCrJoHW0M86ePMVwmHUnpPO
         Cb4QgcGHsmRL0TPpBlYxqlUHzRvuRrNWIg6GK+LcAS5H0XT0KN3Ksl21gmEN7Qcz3NZm
         P1TYosdeaokae87JI1T4NT9TOxyZi+iQ+vv0KNyaaJdIHIS3wthbBhT0zrK7iFSYzEhR
         70O14MOwAOhfq1Um7uagNYN1s0+j7O0GnZSfEXBR98OoXye3ExJoXVgECMR3SMer63Lk
         EO8oldHo95Yq15CfN6oYREfrk2ZV9Ft08T9nc0BHcgHvU4aItaOHc+ARiGREksnMi3M5
         zUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sIRRfRGjfu+e6/Wjg3FjKJVIuB7i8CBLtJCwEjLha9Y=;
        b=gjUN6BNGkkahZGl/6gpjarb27hnmmMqnFPXiTGCcZh6tiMcXAtk92D9FT1X9NHc9aj
         UvTUj/EfMInUz620vJjYXeRyYRZCpIzaT7EwZFWk1RK35kH4ptwDox2y5psh9jf3Cr7H
         I9P9CN5vevJ9xehwl8rKuRmegCcfj0qBiRO2xk1GoxbPuLfQIiBCiaFzjcqzI2XJh7P8
         SBzNIzAmVmGop0qS+IfBv62mbDZ4DHewQClSvh+06upitNwnmX2SCu/uh27Bz2QoZdCm
         KOg170o1nGrHqrPvxc+3eM7qZaYDoKP1Z0BCKyWp+9zXnpgRoBatr2xT7eFHDL6/qwYq
         okmQ==
X-Gm-Message-State: APzg51CmS/XOrBFVTK5jPHQT4bYOQQucoxj/fLeCOZRr3o2ef4HYVqFH
        azcEzWQxTDHEEYUR7AhvalMP95sQlxcajbHBtuo=
X-Google-Smtp-Source: ANB0VdYNh0fCHGx34imgnyfPO03lhqOkBJuUQpLlS4g+yrn0rQj03vMom8vpOKkKfNUXxmt0TGwxqw7FGIJuYow5zZg=
X-Received: by 2002:a50:8b25:: with SMTP id l34-v6mr182100edl.265.1535079559909;
 Thu, 23 Aug 2018 19:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180820154120.19297-1-pclouds@gmail.com>
In-Reply-To: <20180820154120.19297-1-pclouds@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 23 Aug 2018 19:59:08 -0700
Message-ID: <CA+P7+xohoHTnisAomMKixBJqNpjuvXV+nz=Cywsfb-wT=G8poA@mail.gmail.com>
Subject: Re: [PATCH/RFC] commit: new option to abort -a something is already staged
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 20, 2018 at 8:43 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
> Instead, let's handle just this problem for now. This new option
> commit.preciousDirtyIndex, if set to false, will not allow `commit -a`
> to continue if the final index is different from the existing one. I
> don't think this can be achieved with hooks because the hooks don't
> know about "-a" or different commit modes.
>

Here you say setting it to "false" enables this check but...

> +commit.preciousDirtyIndex::
> +       If some changes are partially staged in the index (i.e.
> +       "git commit -a" and "git commit" commit different changes), rejec=
t
> +       "git commit -a".
> +

Here, sounds like it is enabled by setting it to true.

Thanks,
Jake
