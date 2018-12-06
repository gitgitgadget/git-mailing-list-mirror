Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C594A211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 18:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbeLFSiV (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 13:38:21 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:44338 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeLFSiV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 13:38:21 -0500
Received: by mail-pf1-f169.google.com with SMTP id u6so581952pfh.11
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 10:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2gL9kCHZL+lnnczoU6HzJt3PhTucUBiDin9Bmkcqik=;
        b=aFoLO+BsKRTeOFmmXKACJ3ul61A3gCG25C+LVSKMltBs+M+9/5t5noqnUtdRoXTuND
         shpE9laahOBNfAbUy48UicRsklYGxeZwRSvjfao13+bD1NSbNCiklzSoQF/k45uz3bMh
         /Sw6LKUckkkhKWEJiIJl+lNBlA8giZLL5ukQcQJS9iPkg/+0kJTLkAbyn5LzqHNApxkp
         UBfr7quFDfnfmnszuA0lFPJz6Mo6ZeaFp1cBOvdfOTjd8TJLprV+dEW3IFNVRwdgCYkq
         Qx7cg4+ckPvjxV0ZW4JNjpA5TGfwTEKbupckKFq3g5CYVrD+hscIJjuxyhdsJSr9GWGk
         HwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2gL9kCHZL+lnnczoU6HzJt3PhTucUBiDin9Bmkcqik=;
        b=JvIsOC6xVVfGuwCfdIvLblY5iU6Qz/0++wWK0b/GPviFZKr03cMlyo1bSqjDvpMhx3
         +/By84Zh91jr6U6n03Cqpjp9RW40Nt73lzJk6tQBxkhhMP0m8RQ9mZssDcfA2pUq8s/r
         PPHp2bbLOhNNvN2SR6raeIxDMXts7pbf1cHG3+35jAztsbS3UeCUEYvryh8d9/tzIwq0
         Hth/bg/aIAVjP6ZvJeJDZeBX/ivrqCiOzzDnlH7z+ahiwJAmr3Bbg5p4L+d9RGnXnWU2
         CsSLh+as0Lz8cKG7Xq0r90tqxs3F+vyjTtUvKLccRLDgOxuwIPEX9T0/u8eIpojXoPWh
         lXiQ==
X-Gm-Message-State: AA+aEWZ09TMsrZB0lYnE+vcfBHiLDZC+skIBed+Excz/FOcM5kFvHQuI
        s/aLf4Gb3TEw2V60iWlc8Z8Qv+7tx0VRt2e/7aiA6eFq
X-Google-Smtp-Source: AFSGD/UC7ORKNo/URtlarn1I1bLsDkiWAsJQiSHxwC0c6glERvgsj07xtQWfLLuoS12+8HgWYkpRPUSx2wQg2qFVzMA=
X-Received: by 2002:a63:2f07:: with SMTP id v7mr23526074pgv.368.1544121500588;
 Thu, 06 Dec 2018 10:38:20 -0800 (PST)
MIME-Version: 1.0
References: <20181206181739.GB30045@whubbs1.gaikai.biz>
In-Reply-To: <20181206181739.GB30045@whubbs1.gaikai.biz>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 6 Dec 2018 19:38:08 +0100
Message-ID: <CAN0heSp2g0A82YYvMw-RaERESXFtj3TgPKA3RysC07Lf=tHBcg@mail.gmail.com>
Subject: Re: enhancement: support for author.email and author.name in "git config"
To:     williamh@gentoo.org
Cc:     Git Mailing List <git@vger.kernel.org>, chutzpah@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi William,

On Thu, 6 Dec 2018 at 19:18, William Hubbs <williamh@gentoo.org> wrote:
> We are in a situation where we would like to use author information that is
> different from committer information when we commit to certain
> repositories.

[...]

> [...] I would like to propose the addition of author.email and
> author.name settings to the git-config system.
>
> Additionally you could add committer.name and committer.email, but the
> only reason I bring the committer variations up is consistency since I
> see you also have GIT_COMMITTER_NAME and GIT_COMMITTER_EMAIL environment
> variables.

This idea was floated a couple of months ago [1]. Junio seemed to find
the request sensible and outlined a design. No patches materialized, as
far as I know, but that could be because Eric suggested a tool called
direnv. Maybe that would work for you.

[1] https://public-inbox.org/git/0f66ad7a-2289-2cce-6533-a27e19945187@rasmusvillemoes.dk/

Martin
