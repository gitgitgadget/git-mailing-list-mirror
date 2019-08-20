Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C4711F461
	for <e@80x24.org>; Tue, 20 Aug 2019 07:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfHTHHp (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 03:07:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41595 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTHHo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 03:07:44 -0400
Received: by mail-io1-f68.google.com with SMTP id j5so10013229ioj.8
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 00:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XHbsGaWnlumjidkn2j5+QcbDVe8BCuZZLXyl+XZidpA=;
        b=OJTJJRT14hMSTBopu317irIcskioe3QYBKQ5xsRhbNBSL741k1aIwOxgT1ZdlbK+4L
         uoji6S3tqJONWsZdoMfkrA16502wpsqR97zyVCyr10KB/o2qPaOYBdgOR34tyAKMUvVY
         DdiFJTB9JCugmt3XZ2slW76pu39cnKIOJZXgWnu6mRiED8Pcaef/2IGe5S+AiV97w6bM
         XH0IFRf2AjhYivOuycbUIoa17LSHQFdHZpiqmL1vbHyU6A1Y9SYIPyfoii1yBJxMNupP
         6xGBigpCh+m9ONeyzgbNQgZ+Q0VQ27bc+A5k1uJT4tPHDWJoZdhrmhbSDo0NDZ3+8953
         yIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XHbsGaWnlumjidkn2j5+QcbDVe8BCuZZLXyl+XZidpA=;
        b=HF0aUQtq524p5MuCAZVacCtHHgbrYm+TsLWHNwZ0Q413eOPQDbvPx1xaN75N+RaJSL
         xG/ReVuhg5yW/c3Or3VdZ3bzrJk6ggcgGpbMJeq1MszeeV+gGk9wuVDNrEQeuJfYOJ44
         xGXHoKAYwy7kPnWkpjI+Ubl1UemNbY1xcOvJcFeU11qROOa3yugQRmnPN0WegHU73rOy
         MHbPtW5ZgqND/YOGlqYSt5iFtrWiRceQgF5SHkWSHt/VO1nx4tE+0PvtZ/3X8YCYJ/qB
         kiBsdCDkrNbJYEzIOcQABXiSMLLxOabx+xJcg2AgUBoAcSe+QpjrmCF+ah1suObqv/WB
         LxNA==
X-Gm-Message-State: APjAAAULx+EJXMngXJgBSPZH4GNYFbLmP55vnS4X0N1C/HQsHi4BM8c0
        ji4JM3rve+bV8PUZa6KMfc4=
X-Google-Smtp-Source: APXvYqzSQ6tzqrUvVezyPiwu42bcTX1wPIQk6mwwMrrQlb29F4pwFKvlx+ka+NzHxXrMtfBSzYNvig==
X-Received: by 2002:a5d:9f47:: with SMTP id u7mr4154954iot.197.1566284863859;
        Tue, 20 Aug 2019 00:07:43 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id n17sm12948048iog.63.2019.08.20.00.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 00:07:42 -0700 (PDT)
Date:   Tue, 20 Aug 2019 03:07:40 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] Doc: add more detail for git-format-patch
Message-ID: <20190820070740.GA29407@archbookpro.localdomain>
References: <cover.1566258525.git.liu.denton@gmail.com>
 <fd908bcc01884469dce966fbc384d6982687b4bd.1566258525.git.liu.denton@gmail.com>
 <CAPig+cTL3rtPuMQiFfZPcAX7T=v8fVSOL07ULDbXUuG+GD_jzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cTL3rtPuMQiFfZPcAX7T=v8fVSOL07ULDbXUuG+GD_jzQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 19, 2019 at 10:44:03PM -0400, Eric Sunshine wrote:
> On Mon, Aug 19, 2019 at 7:53 PM Denton Liu <liu.denton@gmail.com> wrote:
> > In git-format-patch.txt, we were missing some key user information.
> > First of all, using the `--to` and `--cc` options don't override
> > `format.to` and `format.cc` variables, respectively. They add on to each
> > other. Document this.
> 
> This entire paragraph can go away since v2 dropped this change.
> 
> > In addition, document the special value of `--base=auto`.
> >
> > Next, while we're at it, surround option arguments with <>.
> >
> > Finally, document the `format.outputDirectory` config and change
> > `format.coverletter` to use camel case.
> >
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> > diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> > @@ -314,7 +314,8 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
> >  --base=<commit>::
> >         Record the base tree information to identify the state the
> >         patch series applies to.  See the BASE TREE INFORMATION section
> > -       below for details.
> > +       below for details. If <commit> is "auto", a base commit is
> > +       automatically chosen.
> 
> Should <commit> be encased in backquotes in the paragraph body?

In this page, it seems like the other instances of <commit> (or most
other <text> for that matter) aren't wrapped in backquotes. From
checking out the rest of Git's documentation, it seems like it's a mixed
bag whether to do this or not.

I'm going to leave it as is and hopefully someone who cares enough will
make the docs more stylistically uniform.
