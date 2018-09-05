Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 560B41F404
	for <e@80x24.org>; Wed,  5 Sep 2018 18:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeIEWuT (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 18:50:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39705 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbeIEWuT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 18:50:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id o37-v6so8654445wrf.6
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 11:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EG1lbV82EQD4EcONbRZkigdIEqKAcFXcCXGhy1XD2iw=;
        b=BEHdYOm0JKineJcT3JwpQgYuV9vGRo5o/BRb65R0s8Fg7lr36hgjQvGGeqMR5b1Y4Z
         o0aoN4T1fWtTczoT3g0kRoJ7LNbxeRy3S7Hs/n8H70n1/5dY8suShEn/Z8cs7G2O+iod
         Pfs95DOuq7YCq85ap0gt8DhR3U4ZyKgjtv5+4aNlxUjhakeHldvhrK+8QS7IpRwasXhG
         z865x64+ReHmmPNsDYNWDrInSGJpeucyvN97VsD6IvlmxXkE5XzTUKB8Bw/CPrxrKnv/
         d6Jby+SmwGoHlLXpv0p/vezDoS+CQbqtb4C0NW9j/XD8MZo0eanfN9zUmJ3nbYzXcxKM
         OoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EG1lbV82EQD4EcONbRZkigdIEqKAcFXcCXGhy1XD2iw=;
        b=Od/QtzOTYdMxDjU/CVdiAcmCZ/0wE9YrhRHo0IZJkrgXwwEIuOf8+orFzWiIkg8WUD
         kSw6SrZ4dbKU9Rsvu4TWljSadbmfja2gixFDOCLpFsl246z68Y47qRRTFC5UirjrQ6En
         rrk4T5JPjB+MrOCN6+18/BsDBT7yDQkQsv1DWxfF+deh5/YBLXi1uudKrp614AKcpab3
         EntRHT/2kdd6MfNkDeVdAO5EDmo7asmlBcZG5XnyrPpnzVdS9XLjp1lqvX/bppiJ0h1u
         M6JJ5Ics4pbBdKOOdmZMz/0Px9gVeN6gy5VAJnFn+olbdQ/Jd0UUO619rnlm/n6FZ94l
         Kp5g==
X-Gm-Message-State: APzg51BHVrAFfVLT2R5iyoUzBu/oMZgHFkJ5jd+vXbIN2zcbrEvfJMaw
        4MdF937VtDm5VkeUJSljNt0=
X-Google-Smtp-Source: ANB0VdYVS6RQwGANYbHfspPk/1KDwx8kRGsPvzEpZiOO3bN8UL3aNXU2FufqP0D2xrql9bAxmuUEVA==
X-Received: by 2002:adf:8325:: with SMTP id 34-v6mr17575707wrd.67.1536171538173;
        Wed, 05 Sep 2018 11:18:58 -0700 (PDT)
Received: from localhost (x590e0517.dyn.telefonica.de. [89.14.5.23])
        by smtp.gmail.com with ESMTPSA id k63-v6sm3445809wmd.46.2018.09.05.11.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 11:18:57 -0700 (PDT)
Date:   Wed, 5 Sep 2018 20:18:52 +0200
From:   SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2018, #01; Tue, 4)
Message-ID: <20180905181852.GA14181@localhost>
References: <xmqqmusw6gbo.fsf@gitster-ct.c.googlers.com>
 <xmqqbm9b6gxs.fsf@gitster-ct.c.googlers.com>
 <CACsJy8CJfsjmt8Z03dT5enN86Ke7aMBHv+BvpRh8zFBgU4Z=Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8CJfsjmt8Z03dT5enN86Ke7aMBHv+BvpRh8zFBgU4Z=Vw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 05, 2018 at 06:48:06PM +0200, Duy Nguyen wrote:
> On Wed, Sep 5, 2018 at 6:35 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > > Here are the topics that have been cooking.  Commits prefixed with
> > > '-' are only in 'pu' (proposed updates) while commits prefixed with
> > > '+' are in 'next'.  The ones marked with '.' do not appear in any of
> > > the integration branches, but I am still holding onto them.
> > >
> > > Git 2.19-rc2 is out.  Hopefully the tip of 'master' is more or less
> > > identical to the final one without needing much updates.
> >
> > By the way, linux-gcc job of TravisCI seems to have been unhappy
> > lately all the way down to 'master'.  It fails split-index tests,
> > which may or may not be new breakage.
> >
> >     https://travis-ci.org/git/git/jobs/424552273
> >
> > If this is a recent regression, we may want to revert a few commits,
> > but I do not offhand recall us having touched the spilt-index part
> > of the code during this cycle.

It's not a regression, it's as old as the split index feature itself.

> I can't reproduce it here (with either 64 or 32 bit builds on x86).
> Not denying the problem, just a quick update. I'll need more time,
> maybe over weekend to have a closer look.

I have the patches almost ready, only the commit messages need some
touching up.

