Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 475C020A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 18:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbeLMSI1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 13:08:27 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:33217 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeLMSI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 13:08:26 -0500
Received: by mail-io1-f51.google.com with SMTP id t24so2370889ioi.0
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 10:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tq8K5puZsZb4s6H26rPKdFOnrVlmO+f2MAJHf8SDiI4=;
        b=GSCEsdRm5BrFbxRD5HhV+ohWV10QM79bjejp4CiogX0EYjhlm6TxJFXBEqjGvDNRsQ
         yEp0vx83h8jps6TjLRcr/ShUiuA/9FnWwRbEKo2d200zWAgybxvq3L6MEqS/ilZvfGQV
         SKDZJcurrXOugMdCuecbeXLfUT+CPTA74KS7r5qZlGZqfbzNl7gpXPoMHWZbQCVCPLEy
         vUrKXe+MnPGcwImelWIuMVczJLNyAYEQ0HwMN9s2KCu8LWyvTBT5ob1g2oVMl033ssyB
         2+xsdHUmWSrgmjnKzSAPb4/rwTYV5sdYXtHPW5DorzS8LhWtEq/gmsR+tWCVk6ybzm5P
         /WkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tq8K5puZsZb4s6H26rPKdFOnrVlmO+f2MAJHf8SDiI4=;
        b=LPDmM4ryqHkkZcPgB5vlEhxBIAAHM21hIs2u8FzeQcP4zZ8IH7obznlS2JMYCrGnv8
         joh5QcDK0lXie2MnNx4rcEz+xeBYS7U8B5qsdv2GQluFe/35xYGuPw+WGKB88jrmWnQo
         EQAyUKqqijUO+xdj5js4tWbJvy1ehqjHxPUOUu45FiPPbPvT9sN3JvYa1kveq9aopswz
         0xMbFKaj0xTZ2ogoXWCZLgJn+7T0RsnX9JGYgM/eN1sfaKmhtsAAE0YDvR1rfagvzxVx
         Dy/9lJaLu8N1VsEyzN2Jp7sa1fQ4UjWWIl0zo31hHfV/qqvNM4PFBz3Oh96ODGB372XB
         O69w==
X-Gm-Message-State: AA+aEWYkgimMexEggANpmxVfsEbsO1eBWWg8k8HsB89ens5QdEJlW9ad
        Jqj3kvd2GSV9sf8Y+7y68FelTQxtSGvhSkhCXKQ=
X-Google-Smtp-Source: AFSGD/VTwP+nVUhyb0YDIUOOJdYBlo4Q44D1azw/VQXBbTEsY4ZnVix2j3T6UiPLmjIPr6bqajz+eDZBf9ljBPR1VoM=
X-Received: by 2002:a6b:7b42:: with SMTP id m2mr6951797iop.236.1544724505667;
 Thu, 13 Dec 2018 10:08:25 -0800 (PST)
MIME-Version: 1.0
References: <xmqq4lbiey7s.fsf@gitster-ct.c.googlers.com> <87r2el1q0g.fsf@evledraar.gmail.com>
In-Reply-To: <87r2el1q0g.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 13 Dec 2018 19:08:00 +0100
Message-ID: <CACsJy8AB0gQAvAWh3vtiSFnZWXtdvQdi4czBoR2B8TkECMrQtQ@mail.gmail.com>
Subject: Re: Preparing for 2.20.1 brown-paper-bag maintenance release
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 3:05 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Thu, Dec 13 2018, Junio C Hamano wrote:
>
> > Here is an excerpt from a draft edition of "What's cooking" report
> > for topics that are about an immediate 2.20.1 maintenance release,
> > with five topics that I plan to merge to 'next' and then to 'maint'
> > soonish (they're all marked as "Will merge to 'next' and then to
> > 'master'").
> >
> > They'll be in 'pu' but not in 'next' in today's pushout, but unless
> > I hear breakage reports in time, I am hoping to merge them to 'next'
> > during tomorrow's integration cycle, so that we can start the new
> > week with 2.20.1.
> > [...]
> > * nd/show-gitcomp-compilation-fix (2018-12-12) 1 commit
> >  - parse-options: fix SunCC compiler warning
> >
> >  Portability fix for a recent update to parse-options API.
>
> Since I reported this, just a clarification: Unlike 46c0eb5843
> ("files-backend.c: fix build error on Solaris", 2018-11-25) this one's
> not an error on suncc, just a warning (and we have 20-30 of those exact
> warnings in our code).
>
> So if you wanted to minimize 2.20.1 this could be held back, but also it
> looks obviously correct so it's fine that it makes it into that point
> release. Just FYI.

There's also a bug in my patch (-2 is already being used by
parse_opt_unknown_cb and my patch will change behavior of git-blame at
least in theory). I'll reroll later. I think it's better to hold it
back.
--=20
Duy
