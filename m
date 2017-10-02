Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1167B20A10
	for <e@80x24.org>; Mon,  2 Oct 2017 00:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751075AbdJBAGe (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 20:06:34 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:45382 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbdJBAGd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 20:06:33 -0400
Received: by mail-pf0-f171.google.com with SMTP id z84so2120922pfi.2
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 17:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uYPrxi3DKfNbZ/q/ykLtn+ssq/eUSwGhvHb56uGbrWY=;
        b=EaTdjKAAr5NRJsh6iC3Z/wV49T79WLk7sskkUP7RRz1eSMYjoBSGL7VHFONQzUCT9x
         +NZNaGG3zpQW+1iw2tBpfkUUyUx34pQcASxkDBcKXvLpTLh6a1KVzKt2hau4CkNAgcH8
         Ey5KM1CckzQu4dnqOG+jQq7exMQ/htcZobqmz4/ozqcSDNip/SYe9h0bcrJU+QzftUPD
         8uVu2HEFaoANgLj8zA28VW9XRMKuRWxmClYILEf5i6ejHR7/wvYfHXHBS+TT8GjQJe1E
         AC7gy6EybPm6OjeW4Nm4RTZouGjG4ALvMIVF8uFP7jsWHM+WHkYfTqE6yi4dEYfYyUQY
         eeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uYPrxi3DKfNbZ/q/ykLtn+ssq/eUSwGhvHb56uGbrWY=;
        b=e2rfw05UxS4Smi6+dh4X/JkfrBi7qzz+3VgwACuo0fNd8eOjtNDU65ddppDGXeUXuZ
         87SIt9+CAy8GVgO12OjK4jgsQ06YhQrWjFLQmrD2W/dxJTHDpx/f0Tfgiy2wQZ+P9ybC
         9d4fq/UsWOmbsvTIk0fwKxdPMEAhNeBhxLYuoChUjLcD8O5DgbyvVbdjdm4MVItZbfKc
         Tnl78Ubp1+IZLYT0hCdQS3pGLYhqs+FNuBP77/kKsNXieQY7ereMY84WbZK4B/PA2ofI
         Z9fP9m/NHmORIY/D2CwOCGkA4RaIVxb0kvCaT+ZdplW4unajZZzSypaQHQJufNxoB8l0
         PfnA==
X-Gm-Message-State: AHPjjUid+gV1V2Fq3LOp4JWxVbJCXKqa6TzE8mrP/0RyPBsBv/+9Ossj
        oUtSesHI91DGd7v7TXiFJ/O8wg==
X-Google-Smtp-Source: AOwi7QCliyiCT2dfE3FPeIbXesu5eD2A5xmMtnAhh5qBsN+qMS1NMzsBbhAaniheW1JR+bnfl7r6QQ==
X-Received: by 10.159.216.150 with SMTP id s22mr13194741plp.141.1506902792959;
        Sun, 01 Oct 2017 17:06:32 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id x13sm13785514pgt.16.2017.10.01.17.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 17:06:31 -0700 (PDT)
Date:   Sun, 1 Oct 2017 17:06:30 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 4/6] doc: use modern "`"-style code fencing
Message-ID: <20171002000630.GA63556@D-10-157-251-166.dhcp4.washington.edu>
References: <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
 <20171001161852.84571-1-me@ttaylorr.com>
 <20171001161852.84571-4-me@ttaylorr.com>
 <xmqqlgkutoc6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlgkutoc6.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 02, 2017 at 08:55:53AM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > "'"- (single-quote) styled code fencing is no longer considered modern
> > within the "Documentation/" subtree.
> >
> > In preparation for adding additional information to this section of
> > git-for-each-ref(1)'s documentation, update old-style code fencing to
> > use "`"-style fencing instead.
>
> Is this just me who wants to do s/fenc/quot/g?  Unless somebody
> objects, I'd do so while queuing.

I don't object, I think that fencing is less appropriate than quoting.
I couldn't find the term myself when writing this commit :-).

I am happy to send out v5 of this patch series with this commit
re-written, or you can change it while queuing. Whichever is easier for
you.

Thanks again.


--
- Taylor
