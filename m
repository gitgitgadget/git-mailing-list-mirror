Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 008B220756
	for <e@80x24.org>; Wed, 18 Jan 2017 00:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbdARAHm (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 19:07:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61684 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751595AbdARAHk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 19:07:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A413619A7;
        Tue, 17 Jan 2017 19:07:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nE5fhM6CiofYzJuR6FJfy38XKjk=; b=iMbRVp
        /oMCVMxS5I0DqP6D8Ttqd7Dy5TF4yWy1BBfdqibiwKlNbuDNK7EooAtc2KC8eVMO
        FlnX4Xoz3tmcNu2flyZX/ivAC3121FZ3U/SuiAeYrUiSVZPRaq7W6hxr4xgODPLS
        OT37L7C9YeH/19BVTZzb873HMvxy0bw7v0cRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZFAUlAwT2VyHOQjNPvxJ+eh0p1lvg2Wx
        zMpRHG6B5GuGYFTb8hJtGJj/6lJljjoVe5aHUvH/RD1djp87NAD4OHLLaxHcBZVF
        tAgCgHsXW3vnFVITtMb7XknNJYZDy0OT0g2KhP+WRGgHBZtbboR02IlRikSIOuIL
        zSisowQeDm0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91E77619A6;
        Tue, 17 Jan 2017 19:07:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD3DF619A5;
        Tue, 17 Jan 2017 19:07:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org
Subject: Re: [PATCH v6 0/6] Add --format to tag verification
References: <20170117233723.23897-1-santiago@nyu.edu>
Date:   Tue, 17 Jan 2017 16:07:37 -0800
In-Reply-To: <20170117233723.23897-1-santiago@nyu.edu> (santiago@nyu.edu's
        message of "Tue, 17 Jan 2017 18:37:17 -0500")
Message-ID: <xmqqvatdb586.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F83F378-DD12-11E6-9973-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

santiago@nyu.edu writes:

> From: Santiago Torres <santiago@nyu.edu>
>
> This is the sixth iteration of [1][2][3][4][5], and as a result of the
> discussion in [5]. The main goal of this patch series is to bring
> --format to git tag verification so that upper-layer tools can inspect
> the content of a tag and make decisions based on it.
>
> In this re-woll we:
>
> * Changed the call interface so printing is done outside of verification. 
>
> * Fixed a couple of whitespace issues and whatnot. 

With the small code structure change Peff suggested the result looks
much easier to read.  I didn't spot any more problems.

Will replace what has been sitting in my tree.  Thanks.
