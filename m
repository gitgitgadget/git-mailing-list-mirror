Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7F5E1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 20:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbeG3V6X (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 17:58:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42908 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbeG3V6X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 17:58:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id e7-v6so14203488wrs.9
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 13:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kJbJHB+ygPGvpI8UOCJZGy39tr7Fd6dhQ9MABzhi4DE=;
        b=G1DFxHq2vWfrnP4gBP23F7f1RBXt1Vs98DA5oyZjmGz6GIfwC5XdjAQb3Oiu4EwNVH
         ldB4JNAOADeuwy5SXAYJiFvb6NzZUjxSPfcDYKw6YiVOmBPM56LKBvRdvJ+DafSYuNlS
         qUunZWZPA2DvBcsDQMChfgnuaBZbVUmIOBssJlu5qUEW3GbZZy6gqqs0NNkBZ4W1ySRm
         WqEUo74YjCQ5+2V6KBeF6NK9mOdXQRFyo4v9zaM6hD3MpUcjm5s14FuGhEYMBO2Kq9Qk
         yex6emOn0aWNL90pGX0l17yJ2cw+lSK4+LjB56fJWi/xAMgk4dA3tmV1xF/0nN37iuMy
         owfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kJbJHB+ygPGvpI8UOCJZGy39tr7Fd6dhQ9MABzhi4DE=;
        b=UiCoCHTNV/NoO3yC2Fzf61TN7cy54+liP1kqdIgO1PETSBrtUpXUYF2G0w5Non9U+k
         0ysEtYnKAbhSwsCsuDCQBMG76kpSdq2dwPSNF9D2fHuVi2OB4GQS6LJlH62EcJO5zgOJ
         zGN0oeX5cFst1ABpjKfl0dqeIdXT3NlE74iccnhZ5jqdqfM/Kn6tQLRAixFwP+beU992
         30mIDpqV/AkiLnTlpEhO9vSPvGNCfnxPN4OPRGD8WsAU3EFw7ORRDVoffXcVvHPOlDNb
         wDUvKji2Eem11WTHRXGfgkTAM/BkkemsDVK7kUZuFvUqRWNdj/dujZe90xiTnIFPND2A
         AwmA==
X-Gm-Message-State: AOUpUlH8Vh5fX04+HJS5hzduvwuZKf+bAov8pnKXv12L7bOJwkKW7DK9
        tuHkVMrcT8rDI1E2hTidNHY=
X-Google-Smtp-Source: AAOMgpfcLJzdu4QznTl7L1w2nPuEvq9EfefvuC+lZ37yjx1l12SZgi/RzylcytbDCkMfz9zYqG5qSQ==
X-Received: by 2002:a5d:6a03:: with SMTP id m3-v6mr18589855wru.192.1532982102001;
        Mon, 30 Jul 2018 13:21:42 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id s124-v6sm304367wmf.47.2018.07.30.13.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 13:21:41 -0700 (PDT)
Date:   Mon, 30 Jul 2018 21:21:40 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 05/11] rerere: add documentation for conflict
 normalization
Message-ID: <20180730202140.GG9955@hank.intra.tgummerer.com>
References: <20180605215219.28783-1-t.gummerer@gmail.com>
 <20180714214443.7184-1-t.gummerer@gmail.com>
 <20180714214443.7184-6-t.gummerer@gmail.com>
 <xmqqin4whatr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqin4whatr.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/30, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > +Different conflict styles and branch names are normalized by stripping
> > +the labels from the conflict markers, and removing extraneous
> > +information from the `diff3` conflict style. Branches that are merged
> 
> s/extraneous information/commmon ancestor version/ perhaps, to be
> fact-based without passing value judgment?

Yeah I meant "extraneous information for rerere", but common ancester
version is better.

> We drop the common ancestor version only because we cannot normalize
> from `merge` style to `diff3` style by adding one, and not because
> it is extraneous.  It does help humans understand the conflict a lot
> better to have that section.
> 
> > +By extension, this means that rerere should recognize that the above
> > +conflicts are the same.  To do this, the labels on the conflict
> > +markers are stripped, and the diff3 output is removed.  The above
> 
> s/diff3 output/common ancestor version/, as "diff3 output" would
> mean the whole thing between <<< and >>> to readers.

Makes sense, will fix in the re-roll, thanks!

> > diff --git a/rerere.c b/rerere.c
> > index be98c0afcb..da1ab54027 100644
> > --- a/rerere.c
> > +++ b/rerere.c
> > @@ -394,10 +394,6 @@ static int is_cmarker(char *buf, int marker_char, int marker_size)
> >   * and NUL concatenated together.
> >   *
> >   * Return the number of conflict hunks found.
> > - *
> > - * NEEDSWORK: the logic and theory of operation behind this conflict
> > - * normalization may deserve to be documented somewhere, perhaps in
> > - * Documentation/technical/rerere.txt.
> >   */
> >  static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_size)
> >  {
> 
> Thanks for finally removing this age-old NEEDSWORK comment.
