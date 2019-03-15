Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 429FA20248
	for <e@80x24.org>; Fri, 15 Mar 2019 22:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfCOWba (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 18:31:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33768 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfCOWb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 18:31:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id i8so11151248wrm.0
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 15:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nn0Qykc9cTDvVgn3EEiRYe6Wna3lRzp8ZUK5d15Rkfg=;
        b=O52dga5sr+MjZq96MCX/ZCS3FYHUvZUnx6GczmK4gGzidgTYQcvxRnJEDNQ/+if605
         rIeSX2qQ2ToP1H6BkFUVDjQWqjRV9ar0Oz8In/8oFXH2ERDkBYQK9vDTmmqwIPVb5rho
         j27myr2giEMihEN2yAXyfvjXY9UZ0/hBLG1Mp3wCZwdNFBM/2bVF9qzl6LIqbexfco4n
         bhXAeaXxnREuA2e88XtvHcwD2q6ErjLVXyvBhX+ObZpCbTr2xXju3HdAljxPmaTyS2gM
         pi4ikNmrY1o+MPUym7oNMJeD8RiuIgQo0XCcgAyGDiLTRXby/KJ0rnlCKVZOvWF/Sd2n
         hKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nn0Qykc9cTDvVgn3EEiRYe6Wna3lRzp8ZUK5d15Rkfg=;
        b=C4eUJ3Ye4CB/nnbqQ9yCcnXxHGvonYvZlsb3lOzgxJm7set2he/rHSzVAUa1uHWJBD
         hk8a47bk/6u6zALaCBogHBjldLzulRgZoUp9jq9Y/UDanqPYwLjEFG80O2d1Cx2A/Y5j
         3rOQEfHDMXri+nxPXJaVWpGWUGV/mIEqCAgIFLwXmvjB29SH7OLkvcIoWdE2EddS5fL5
         9GdQ8bel+uFEpbagDY0D8KoGC356mJ1xZg0aCQr6deiu0mCiEXpjzi51m9h5nsY1w4YY
         GBknbxw+XAPXFDgs3AK6wtHXB6eCxP4S44pJOnSudWVwM4ehQCdsI7mpfVUBdvl1cApm
         TDfw==
X-Gm-Message-State: APjAAAWsAVm369FKvpfFrZbUS3qdvKsSlpv2/pvv6fb6OKr3LrtzITlv
        RXm7Qy0NTCU+DwtPSSkElEQ=
X-Google-Smtp-Source: APXvYqzvSJvYTqUbkJ/uqNBGY05+UOF4/tN/Mx2pBc2dHSG3DuvSYfj4y70IehYCUElLLDzExknxPQ==
X-Received: by 2002:adf:b741:: with SMTP id n1mr3774515wre.287.1552689087969;
        Fri, 15 Mar 2019 15:31:27 -0700 (PDT)
Received: from localhost ([95.148.214.107])
        by smtp.gmail.com with ESMTPSA id u123sm679309wmu.38.2019.03.15.15.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 15:31:26 -0700 (PDT)
Date:   Fri, 15 Mar 2019 22:31:25 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] glossary: add definition for overlay
Message-ID: <20190315223125.GG16414@hank.intra.tgummerer.com>
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
 <CACsJy8C7F_Ju2F7COUVd9-1FcyQL=mZph7qmkDh9sS-ENb4PEQ@mail.gmail.com>
 <f6052ac6-60c4-1e70-b3f4-571885ba9e8d@iee.org>
 <CACsJy8D48YiWYkuLW8BbeYvRz=yMmb=XWoMJroPXFAcSV2VjHw@mail.gmail.com>
 <20190309172733.GC31533@hank.intra.tgummerer.com>
 <20190312233040.GE16414@hank.intra.tgummerer.com>
 <CACsJy8B4gEwuyVV_T+vYdMNjs-01rxCk5G9yxbJOSkKWHGgnSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8B4gEwuyVV_T+vYdMNjs-01rxCk5G9yxbJOSkKWHGgnSg@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/13, Duy Nguyen wrote:
> On Wed, Mar 13, 2019 at 6:30 AM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > Add a definition for what overlay means in the context of git, to
> > clarify the recently introduced overlay-mode in git checkout.
> >
> > Helped-by: Elijah Newren <newren@gmail.com>
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >
> > v2 addresses Elijah's comments (thanks!), using the wording he
> > suggested in [*1*], which I agree is slightly better, as no-overlay
> > mode doesn't touch untracked files.
> 
> It could overwrite untracked files (e.g. the file is present in the
> source, but not tracked) but never delete them. But I think it's the
> little detail that we could skip.

Right, we decided to go without that detail in the documentation for
the command line option as well [*1*].  I think the argument that an
overly precise description would make the description harder to
understand is also valid here.  Though if someone can come up with a
nice phrasing for that I'd be happy to add that.

*1*: https://public-inbox.org/git/xmqqo98yiq8i.fsf@gitster-ct.c.googlers.com/
