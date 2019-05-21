Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6369D1F462
	for <e@80x24.org>; Tue, 21 May 2019 04:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbfEUEjC (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 00:39:02 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:41560 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfEUEjC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 00:39:02 -0400
Received: by mail-io1-f51.google.com with SMTP id a17so12845250iot.8
        for <git@vger.kernel.org>; Mon, 20 May 2019 21:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=47SUCdu14FZc+9YUruCbDLWFwhF4Dcn3qj4gOfTe3eY=;
        b=prdno+klsWlO66oOTS3TnDxQclub4431MYiC+4v4hd6z3KIbbIO7LQdIrKxE2QmAis
         t5TvLgapWFhSmU/itga57rRFJ9H++YyEHlKqSQpDeFj077SNJTAMPriqY8CFJakQGoIP
         EBRsej0Y+PEUoTP1sRcfMW+uzC3RW9xfafbBYM0O22oHxPDheDvNgygF+090N8eGxvVB
         L4R90GfAp6FrCSPavonO+3KQyuVrfPNoqGXC/MDNgQxBaXNZmDYWnNlMF1A0jrB//J6M
         2S1oilq0eaIowo/fKwYhrSE/RiBkr0+12ngW0x5b9ynd3P4xM6to+p8ep9mlzDEXvioA
         mThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=47SUCdu14FZc+9YUruCbDLWFwhF4Dcn3qj4gOfTe3eY=;
        b=ZD4407bUgkBEo7u8yYhyf5Vm0hwfSFka1I6QVrFo4w8sXAOgEiTWAXtew8sGfw1Yxp
         pKB7w6tk14dM4x+O/5mOrQq8GnuEnCJjxZasOwpQaosCDnMleoi5GoQD/VpiFt8jfPkB
         x/DQ4wjOHYu02tFV/3KxDcbJknWqlIgYDh/43IuAeltGgBogMUo6PmM+YsnYMDPPOFJW
         oyA8tAwYT4AmgYw7ixBV2ngHRvN6QKHug9mqEW+ItrzSlEgDelstqgb8yap6qj2nwKog
         wL4HUE6e+wNgqBu0+FeFfULEElwoms6eyw46vTn60sCTQidVPQIlEWWmVTIB/XfiQfXu
         NLbg==
X-Gm-Message-State: APjAAAVcHVV9oPapm5Hk61fXNRNfpxF5dQwhYod/bmKTsQ7HBdSonZUt
        E9oXGsAIZa8+6549gN9ENhCa92UobEn8sNB48zMZAA==
X-Google-Smtp-Source: APXvYqzP9Ci2/EgTU+R5WSp7yoIKlsPwwlDcmgIM2k5yO3NNJn+TXcs3lbM0nd3L0Z2UGlHQdBz+XG1AKc8jLWi1GIY=
X-Received: by 2002:a6b:8ec4:: with SMTP id q187mr16628575iod.280.1558413540862;
 Mon, 20 May 2019 21:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <87in9ucsbb.fsf@evledraar.gmail.com> <20190520182353.22221-1-matheus.bernardino@usp.br>
 <87d0kcvg8n.fsf@evledraar.gmail.com>
In-Reply-To: <87d0kcvg8n.fsf@evledraar.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 21 May 2019 01:38:49 -0300
Message-ID: <CAHd-oW5BfECXuxZaO+tdEAZUBvGwtkP6WbxDw7PMJgFuZ8sYRw@mail.gmail.com>
Subject: Re: [GSoC] Some #leftoverbits for anyone looking for little projects
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 20, 2019 at 8:49 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, May 20 2019, Matheus Tavares wrote:
>
> > Hi, =C3=86var
> >
> >> Give "rebase -i" some option so when you "reword" the patch is
> >> included in the message.
> >>
> >> I keep going to the shell because I have no idea what change I'm
> >> describing.
> >
> > I have the same problem, so I wanted to try solving this. The patch
> > bellow creates a "rebase.verboseCommit" configuration that includes
> > a diff when rewording or squashing. I'd appreciate knowing your thought=
s
> > on it.
> >
> > As Christian wisely pointed out to me, though, we can also achieve this
> > behavior by setting "commit.verbose" to true. The only "downside" of it
> > is that users cannot choose to see the diff only when rebasing. Despite
> > of that, if we decide not to go with this patch, what do you think of
> > adding a "commit.verbose" entry at git-rebase's man page?
>
> Thanks for working on this. I'd somehow missed the addition of the
> commit.verbose option, so the problem I had is 100% solved by it (and
> I've turned it on).
>
> I think it's better to just document it with rebase, perhaps rather than
> mention that option specifically (but that would also be fine) promise
> that we support "commit" options in general.

Indeed, it seems to be the right way to go.

> Do we promise anywhere that interactive rebase is going to run the
> "normal" git-commit command. From a quick skimming of the docs it
> doesn't seem so, perhaps we should explicitly promise that, and then
> test for it if we don't (e.g. by stealing the tests you added).

Ok, sounds good to me. In order to avoid duplicate tests, is it OK to
assume that if one commit configuration is being respected by rebase,
then all will be?  Or should a patch adding such a promise include
rebase tests for all commit.* configurations?
