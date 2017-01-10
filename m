Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D610620756
	for <e@80x24.org>; Tue, 10 Jan 2017 23:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757497AbdAJXdS (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 18:33:18 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:34955 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757211AbdAJXdP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 18:33:15 -0500
Received: by mail-it0-f47.google.com with SMTP id c20so85874037itb.0
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 15:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6E5NdWPJm85SuIkn/tmC80scsiF+FQ4Imah9kqohvFQ=;
        b=A20FxVt48uvRLGUJspzP2ESi0KnBLRv6r4pxdejlSzNnsWaboyCqyT5U2KH5CHM+lN
         o3oAhojCrR2gOWHxg+D3Mj31ONSSopE/6+kulSAWrGOPfbwY7o119lM0Cv/Sxk/XOvMj
         NyF7eXPv42B2L3nDkIHdOB5/XD1PvlOryOW10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6E5NdWPJm85SuIkn/tmC80scsiF+FQ4Imah9kqohvFQ=;
        b=iASFeNXkTSUVVN8GIOgUg5Hvv2q3lFJ4HVyT5hfi9s6zX3SEAhbMyHy0ig8ElPFwuX
         S4YslJSt5KtH+jE0vMQiLBWT7fhXsRlHIKDwwLk6ABpb8i9ntjMMyfUAg7rd/EftrcZQ
         v2d6Lhf6iy08aplOjTxjyj6VGNpkodIkrJVdnQvkaFEeTqXwMKpd7ZDBsHCVvdEF3wQa
         pE3b4essQKgyEbwA5jJp22kLpZ8Uj3SgJarkJR7XYFRhnhZ4HoUdfQvyDZulUmEEOTUu
         XCvwTXTuv1xrn6teagOmjeTNpxNiAuNK3zGRbk0885wnnBrctJ1HS07zOe6IrjSwFAgn
         BqRg==
X-Gm-Message-State: AIkVDXK1rk48AnEQKT35An05jnZxtbH7ObBKbe75oAJ7l+5we/b3KvPFl6QrLLsRJDbLDiv/
X-Received: by 10.36.225.13 with SMTP id n13mr5944625ith.57.1484091194583;
        Tue, 10 Jan 2017 15:33:14 -0800 (PST)
Received: from localhost ([206.168.224.82])
        by smtp.gmail.com with ESMTPSA id y134sm2109872iod.16.2017.01.10.15.33.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 15:33:13 -0800 (PST)
Date:   Tue, 10 Jan 2017 16:33:11 -0700
From:   Taylor Blau <ttaylorr@github.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v1] convert: add "status=delayed" to filter process
 protocol
Message-ID: <20170110233311.GA1572@Ida>
References: <20170108191736.47359-1-larsxschneider@gmail.com>
 <xmqqa8b115ll.fsf@gitster.mtv.corp.google.com>
 <ec8078ef-8ff2-d26f-ef73-5ef612737eee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec8078ef-8ff2-d26f-ef73-5ef612737eee@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 10, 2017 at 11:11:01PM +0100, Jakub Narębski wrote:
> W dniu 09.01.2017 o 00:42, Junio C Hamano pisze:
> > larsxschneider@gmail.com writes:
> >> From: Lars Schneider <larsxschneider@gmail.com>
> >>
> >> Some `clean` / `smudge` filters might require a significant amount of
> >> time to process a single blob. During this process the Git checkout
> >> operation is blocked and Git needs to wait until the filter is done to
> >> continue with the checkout.
>
> Lars, what is expected use case for this feature; that is when do you
> think this problem may happen?  Is it something that happened IRL?
>
> >>
> >> Teach the filter process protocol (introduced in edcc858) to accept the
> >> status "delayed" as response to a filter request. Upon this response Git
> >> continues with the checkout operation and asks the filter to process the
> >> blob again after all other blobs have been processed.
> >
> > Hmm, I would have expected that the basic flow would become
> >
> > 	for each paths to be processed:
> > 		convert-to-worktree to buf
> > 		if not delayed:
> > 			do the caller's thing to use buf
> > 		else:
> > 			remember path
> >
> > 	for each delayed paths:
> > 		ensure filter process finished processing for path
> > 		fetch the thing to buf from the process
> > 		do the caller's thing to use buf
>
> I would expect here to have a kind of event loop, namely
>
>         while there are delayed paths:
>                 get path that is ready from filter
>                 fetch the thing to buf (supporting "delayed")
>                 if path done
>                         do the caller's thing to use buf
>                         (e.g. finish checkout path, eof convert, etc.)
>
> We can either trust filter process to tell us when it finished sending
> delayed paths, or keep list of paths that are being delayed in Git.

This makes a lot of sense to me. The "get path that is ready from filter" should
block until the filter has data that it is ready to send. This way Git isn't
wasting time in a busy-loop asking whether the filter has data ready to be sent.
It also means that if the filter has one large chunk that it's ready to write,
Git can work on that while the filter continues to process more data,
theoretically improving the performance of checkouts with many large delayed
objects.

>
> >
> > and that would make quite a lot of sense.  However, what is actually
> > implemented is a bit disappointing from that point of view.  While
> > its first part is the same as above, the latter part instead does:
> >
> > 	for each delayed paths:
> > 		checkout the path
> >
> > Presumably, checkout_entry() does the "ensure that the process is
> > done converting" (otherwise the result is simply buggy), but what
> > disappoints me is that this does not allow callers that call
> > "convert-to-working-tree", whose interface is obtain the bytestream
> > in-core in the working tree representation, given an object in the
> > object-db representation in an in-core buffer, to _use_ the result
> > of the conversion.  The caller does not have a chance to even see
> > the result as it is written straight to the filesystem, once it
> > calls checkout_delayed_entries().
> >
>

In addition to the above, I'd also like to investigate adding a "no more items"
message into the filter protocol. This would be useful for filters that
batch delayed items into groups. In particular, if the batch size is `N`, and Git
sends `2N-1` items, the second batch will be under-filled. The filter on the
other end needs some mechanism to send the second batch, even though it hasn't
hit max capacity.

Specifically, this is how Git LFS implements object transfers for data it does
not have locally, but I'm sure that this sort of functionality would be useful
for other filter implementations as well.

--
Thanks,
Taylor Blau

ttaylorr@github.com
