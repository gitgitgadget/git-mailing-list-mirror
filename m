Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4115320958
	for <e@80x24.org>; Sat, 25 Mar 2017 09:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750903AbdCYJSa (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 05:18:30 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:36800 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbdCYJSa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 05:18:30 -0400
Received: by mail-it0-f53.google.com with SMTP id w124so30422675itb.1
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 02:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=55eJqrqTSbd8tr/2g11rAzpC94GmtEFotgmvg6qE+PE=;
        b=sZQcGdTm93M3OKFDcLBFu/jFGfJYNeIjV9LQ/LC/xIZits+z5Dz7oyUDDFzMam3Gb/
         k6ND6HVDbdgcKY4D5ZovLroa6Vv5aGoEPmoP7yiMeJgUW2TA0hqkIxmS9d5jqoMn92+b
         mVsfSGd0f/qxRsxblCbVl/w5i5wuvf/lN+2Jbvk0qKkBUsB06H1f3/wwbLj2AQoET99F
         qwPk7usm32yYfw5R6oZl9JCBi5Q/F84adKkuZeYePULFFo/nMRfGFYijmTInRCizJmo3
         QYVJkkgOn7O3FkxQK6N717AP5XMtsOrkoEMFy4NltY1ZBZb5Bx9Yw33kKZZ1IuEJzgqe
         WGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=55eJqrqTSbd8tr/2g11rAzpC94GmtEFotgmvg6qE+PE=;
        b=QCdWXMsWTUQ42tL5ivAhSNBPyREid3bsMOvWRKba04FTVyRx4VY+5rN2rZt/vqBRGQ
         mh8+lurh6U1vT1aZYsygCh7I/9J6oZMwIQaK9h5flgY1H7Hkr7anBYoFqczac4Jww/QS
         a4tNfjy5zmcG/MIdefcuoku0QiEJQU3xjckRon9mPoMvGvUzJtHfSDA/u186cVGUKKGR
         sqY+boI9PERDqZZTPGYr8J0DjyrNupw+Q+5MDhtyvVeStBDuukx5DuRS0pGb/a0g4rj4
         sYmM9LJgqvrX9aWsC8ZFBCHv0+C6ButRtWcEVxvmeNFuS+wLM2SXAsRIuLxOOk5EF2J+
         Rmaw==
X-Gm-Message-State: AFeK/H1qhGi+GrAXj9YBZPDawjyyHOob0q67wPuUhHnS11hTTvtQc/GYa/+GP8xOjUvn2mUzrYYmy47fNDQtSg==
X-Received: by 10.107.200.139 with SMTP id y133mr13081514iof.147.1490433508675;
 Sat, 25 Mar 2017 02:18:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 25 Mar 2017 02:18:08 -0700 (PDT)
In-Reply-To: <CANgJU+UCJ9qR-pi9w3+oYjEwDdhbtNX9Nv6brj31VXvt-k-3Lw@mail.gmail.com>
References: <CACBZZX6F47uC9jLxppgkUnwVpGV2jpzzP4kwTuqKgayCevomeA@mail.gmail.com>
 <CANgJU+UCJ9qR-pi9w3+oYjEwDdhbtNX9Nv6brj31VXvt-k-3Lw@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 25 Mar 2017 10:18:08 +0100
Message-ID: <CACBZZX7dXsdu0bwt4Rznregw4=v=Sc3cFTQbxJcb-ynf3HXq3Q@mail.gmail.com>
Subject: Re: Will OpenSSL's license change impact us?
To:     demerphq <demerphq@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2017 at 9:40 AM, demerphq <demerphq@gmail.com> wrote:
> On 25 March 2017 at 00:51, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com> wrote:
>> They're changing their license[1] to Apache 2 which unlike the current
>> fuzzy compatibility with the current license[2] is explicitly
>> incompatible with GPLv2[3].
>
> Are you sure there is an issue? From the Apache page on this:
>
> Apache 2 software can therefore be included in GPLv3 projects, because
> the GPLv3 license accepts our software into GPLv3 works. However,
> GPLv3 software cannot be included in Apache projects. The licenses are
> incompatible in one direction only, and it is a result of ASF's
> licensing philosophy and the GPLv3 authors' interpretation of
> copyright law.
>
> Which seems to be the opposite of the concern you are expressing.

The Apache 2 license is indeed compatible with the GPLv3, but the Git
project explicitly uses GPLv2 with no "or later" clause:

$ head -n 18 COPYING

 Note that the only valid version of the GPL as far as this project
 is concerned is _this_ particular version of the license (ie v2, not
 v2.2 or v3.x or whatever), unless explicitly otherwise stated.

 HOWEVER, in order to allow a migration to GPLv3 if that seems like
 a good idea, I also ask that people involved with the project make
 their preferences known. In particular, if you trust me to make that
 decision, you might note so in your copyright message, ie something
 like

        This file is licensed under the GPL v2, or a later version
        at the discretion of Linus.

  might avoid issues. But we can also just decide to synchronize and
  contact all copyright holders on record if/when the occasion arises.

                        Linus Torvalds
