Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB9591F453
	for <e@80x24.org>; Fri, 21 Sep 2018 02:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388732AbeIUINf (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 04:13:35 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34711 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeIUINe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 04:13:34 -0400
Received: by mail-qt1-f196.google.com with SMTP id x23-v6so378400qtr.1
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 19:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=6NSAPTZ0MtC3zGiRpJGxVdoPqt2pzZkGzJXVpKKG18I=;
        b=E6vpAfEtGrx2tG0Zze7FWB/w9HxNtf/yTkGYPlbn/E4GqWMzvZyV0K6rWa9zwMC090
         /0t5pjg/3Mj1aHEkeMkWl27OtMef5NdOKICvsHtffDuqiRdzIhQqIqN0h6W840aT6os6
         u7/Prk9IX/qeShV+SHvtwnGD5SsqLHPdyrGs+S0iF2+aZ3jwRu6ocLpVNgqJq3ZaZZp7
         0ArtjhOuIH4L9l8VwSvfHYVIf2a0+M32GV3H+yTpOutQc86EGm7MYRwjHtech1huqjrf
         D+WR0pqtyD738fufuPYkQlOW/wg/roCa3HEnDXJuY5+e4jfz0THZWwnudZ4beAatvXlC
         V67w==
X-Gm-Message-State: APzg51B0OJyux/N2Y6wViqGDgVDBfS8it11pwrZjxCVe18UjJiWHyS1G
        YWcJDA10JF6qyjpaQ/hElDUi1c9E8Btdmb/0JIM=
X-Google-Smtp-Source: ANB0VdYAvA8IcIf/0WmvxKSYHHkkvBgTn00YLV3gdKKC0a8MD+ldY7ixbfG6FVksJ1tKPNOqj2gTCimt4b1tdbuz42Y=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr30740931qtd.101.1537496818715;
 Thu, 20 Sep 2018 19:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180917230307.588334-1-sandals@crustytoothpaste.net>
 <xmqqtvmm42es.fsf@gitster-ct.c.googlers.com> <20180920000013.GZ432229@genre.crustytoothpaste.net>
In-Reply-To: <20180920000013.GZ432229@genre.crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 20 Sep 2018 22:26:47 -0400
Message-ID: <CAPig+cTQuwMDMpHe4inO61=Mq2+q1OdGsEG_hpii+dNmjXHZLg@mail.gmail.com>
Subject: Re: [PATCH] Add an EditorConfig file
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 19, 2018 at 8:00 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> (I am having trouble getting make style to work, though, because it
> seems to invoke clang-format as a git subcommand, and I don't think that
> works.  I may send a patch.)

You're probably missing this piece:
https://llvm.org/svn/llvm-project/cfe/trunk/tools/clang-format/git-clang-format
