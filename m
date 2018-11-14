Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F5651F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 12:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeKNWej (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 17:34:39 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:37458 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbeKNWei (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 17:34:38 -0500
Received: by mail-wr1-f41.google.com with SMTP id j10so2875602wru.4
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 04:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cjTQN6I5m5BGBeRkykbCFcRC+cHZ5ykdnJHG2GqohCE=;
        b=PmfWpykpLwuzm7VvuOY1ApgnZZMSkx3N74IbMWNuWr5DX0Pp9RRMxFam2vvI3sh529
         qYY4Kzg4aUiSHyZ8p5MukuEwssX2rIMWoLSIbbB4q6NR1sZzXrlWDcb/TMYlS7TQQFuj
         vAlDWRSTIzYdnGE3qsC5S6+vwPeJRvB5266YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cjTQN6I5m5BGBeRkykbCFcRC+cHZ5ykdnJHG2GqohCE=;
        b=kqKokFyX2d0acm5ok7ctAj7ZkCL/MqXQGxaLNRxTLFnzcFo1XGT+IDBg/X6BBgo+cK
         GDuyd1IiY/kZzD9d9IrJEM40ytWNt3oq4mDGRM5BBY/bxCOu+acGFsGdeJnpIC4KqPAl
         kKXElsRUkyE3tJIs/8D2TLbphPJSEpgTBBCYKLt8qX/gW8ZRAZGhZldiJWOMrDoe/VES
         zCK0Pm6Tmf3mO5vlBpwWbNQ20AsdathhshMW8HwqC7dGu9xk8rYGv3jjJjYGPkI+Piq2
         y2NDHFPHLnYvt+7sYWdmRV/xQd1OS/yCzFCVLz2Obzm4IRnm6X6whrVfiewF6MQ9LrZE
         5dLg==
X-Gm-Message-State: AGRZ1gLaNkHzwD9wnHTBuDG5IIyYxb30H/EmF5125+W6wCYrh8eOEKZb
        IEyirabM2ngDjSYNEfFqqGI8k2ltGMD3bWau8g+TA1KOKQo=
X-Google-Smtp-Source: AJdET5fArxIcHrOVW6BVO1gFbcdrolhjehQRuViS9pcyd2fRdVfWhi9YJaSOyhnLZCZ++t/5dHKtuk3HrjdC8LKeRLo=
X-Received: by 2002:a5d:5206:: with SMTP id j6-v6mr1628299wrv.147.1542198693610;
 Wed, 14 Nov 2018 04:31:33 -0800 (PST)
MIME-Version: 1.0
References: <20181109104202.GA8717@sigill.intra.peff.net> <EF813655-82C4-4A0C-9D88-689C606F7A34@gmail.com>
 <20181109104820.GA9900@sigill.intra.peff.net>
In-Reply-To: <20181109104820.GA9900@sigill.intra.peff.net>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 14 Nov 2018 12:31:22 +0000
Message-ID: <CAE5ih791JybFYb4=Zw6P+fJ7rpWtsaCeUVJMcN=d91AO0sFcVQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git Merge Contributor's Summit Jan 31, 2019, Brussels
To:     Jeff King <peff@peff.net>
Cc:     luca.milanesio@gmail.com, Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 9 Nov 2018 at 10:48, Jeff King <peff@peff.net> wrote:
>
> On Fri, Nov 09, 2018 at 10:44:10AM +0000, Luca Milanesio wrote:
>
> > > On 9 Nov 2018, at 10:42, Jeff King <peff@peff.net> wrote:
> > >
> > > Git Merge 2019 is happening on February 1st. There will be a
> > > Contributor's Summit the day before. Here are the details:
> > >
> > >  When: Thursday, January 31, 2019. 10am-5pm.
> > >  Where: The Egg[1], Brussels, Belgium
> > >  What: Round-table discussion about Git
> > >  Who: All contributors to Git or related projects in the Git ecosystem
> > >       are invited; if you're not sure if you qualify, please ask!
> >
> > Hi Jeff,
> > is Gerrit included in the "Git ecosystem"?
>
> Yeah, I think so. At least the Git parts of it. :)

git-p4?

(The git parts obviously!)

>
> -Peff
