Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98C771F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 06:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfKMGpu (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 01:45:50 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39909 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfKMGpu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 01:45:50 -0500
Received: by mail-ed1-f66.google.com with SMTP id l25so887260edt.6
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 22:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=If60Hk1jJvzUapikmoEqyDuUOLQQwwqo4EMBQz1hEWk=;
        b=QoIe1isfo2GXJD53Ju1rl6Sck4L2JGnfFMvzf6vgpSYdOn6jUU6OFvOJ5IXU/LcHQm
         Dap6Vul47YpA3wynvxdrcQQvhIi//JYEnaAgL1eI9fvwKuVDOkS9CZUrnlIjROOOzYgp
         RhdgS/eXDVMICyjxiE5ZaZaxWuhd14Qo4Zm2GAMs3a82vadJOoQ7kF+qHbVFP7xy3krT
         1YBk99BpHbooOSb4Tp25oOZzdtchm0ayiBor2SUFShTkWq6Hk7lSt69l8NWQ9//DnWqS
         uJDKupejenuQjr0PuDdqJj/j6+aGX6B4DV8u41oJhahhnUspEhRz9/dMixRCGA/zp1Uo
         mIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=If60Hk1jJvzUapikmoEqyDuUOLQQwwqo4EMBQz1hEWk=;
        b=B119QhmGhFKXVxQjIGr7WOzkwuec/dS3RLHEFKo5PrFaREGGh/edFG5YpVcuceU1Yf
         Dlnl7YsM9xHIaGipTBimPXDPYsJcXlOi00lQFlJfSpPp6qLvFKKLVCXhFtuqKlmvn8Sw
         zgWBiKDD+lwFUjr8NYLCL2qOs5c9IWLHGr7flcOGQvivf/tzfxr2T6clC/9oWm/WBSv3
         01Nm+ysWGPcXd9AH/KflocaeUu8CyGIuLGwaNgwPHHaPMr2BDi8QMc4KALAtkoBA2Zk4
         qVrHFxuh6AWUcRIZpdAf8trvJS0EEy6hesxhssiaRG5KYDgIWDSNZvozAx4HhLQXKV0o
         WN7g==
X-Gm-Message-State: APjAAAVw5lKNgsE1dnfJ5H85O375Om7qvTnXbMAeSCZ1dZ+W8Dhcfbcn
        F20Q547w8Sy792vZP1a6RgxRvRvAEvZAdvlyh2M=
X-Google-Smtp-Source: APXvYqy7R2mvVqBprKqm5d74LirCUK0X63hu0gCtFxSSU7AcesR4DmrUvp9kCFs9QaVpGrHRLlrKuOdfY7UanhOA0Y0=
X-Received: by 2002:a17:906:1e02:: with SMTP id g2mr1261862ejj.6.1573627546964;
 Tue, 12 Nov 2019 22:45:46 -0800 (PST)
MIME-Version: 1.0
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
 <CABPp-BFXs4qes20S+9AZd++p3epW4eJ7Vu7zU_PdDysZ_D-yrg@mail.gmail.com>
 <20191112184547.GA38770@google.com> <nycvar.QRO.7.76.6.1911122100220.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1911122100220.46@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 13 Nov 2019 07:45:34 +0100
Message-ID: <CAP8UFD2qjUa=y81YPVSMcuEcDkrkrV=j912qySmG83pig=dFDg@mail.gmail.com>
Subject: Re: [DISCUSSION] Growing the Git community
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Garima Singh <garimasigit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 12, 2019 at 9:04 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Tue, 12 Nov 2019, Emily Shaffer wrote:
>
> > I'm still really interested in participating on a mentors list like
> > this; can we set one up?
>
> I would subscribe immediately to a Git mentors' mailing list.
>
> Thanks for bumping this,

I would also subscribe, and yeah I think it might be worth trying.

There is already a private git-security mailing list
(https://groups.google.com/forum/#!forum/git-security) on Google
Groups so perhaps it makes sense to have git-mentors there too.

Thanks!
