Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EA6F1F859
	for <e@80x24.org>; Thu, 25 Aug 2016 20:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757772AbcHYUcG (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 16:32:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51670 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756438AbcHYUcD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 16:32:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EFD038F42;
        Thu, 25 Aug 2016 16:32:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TXhlwQWbj+co
        VydskymakBZ3o60=; b=uHrrKKYnXhPoH8m+bFrztLFP5J7wx9Jl0SgjBj9lF7AD
        ufgjdGXf1JyEVs0HjqC2L/3XTijAMNphDa7PLzbyS3TBbhAolpCOf2uhFn/BzZ0O
        tE99ughRzbhxIdnOFCTk6SrILWymRxJALIFTd5IywKqFUYwfacurUe6BkXqRawQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=DTlnEy
        x2d9BBjZFJfdhmvrzLotMPUNmpi9V3JLcO6uPHiZK/ZmDMlzh0Ing+CI1wVD8CYG
        +9wfeZWwDC+kKQPaNhr+53iqvHdDhwDCBSZ0wzvwyBdU02ehE/+n4yxvAVoCmhZ9
        7ZbTk4445W0AZeBwS3LGUhsiubyvuhBcMERso=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8805C38F41;
        Thu, 25 Aug 2016 16:32:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D61438F3F;
        Thu, 25 Aug 2016 16:32:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Update eol documentation
References: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
        <20160825155255.28929-1-tboegi@web.de>
Date:   Thu, 25 Aug 2016 13:31:59 -0700
In-Reply-To: <20160825155255.28929-1-tboegi@web.de> (tboegi@web.de's message
        of "Thu, 25 Aug 2016 17:52:55 +0200")
Message-ID: <xmqqy43klhds.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FAA6C142-6B02-11E6-9F27-F7BB12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Sorry for posting this so late:
> While reviewing another patch I realized that the eol related
> documentation was not updated as it should be.
>
> Torsten B=C3=B6gershausen (2):
>   git ls-files: text=3Dauto eol=3Dlf is supported in Git 2.10
>   gitattributes: Document the unified "auto" handling
>
>  Documentation/git-ls-files.txt  |  3 +--
>  Documentation/gitattributes.txt | 24 ++++++++++++++++--------
>  2 files changed, 17 insertions(+), 10 deletions(-)

This [0/3] is meant to be a cover for [1/2] and [2/2]?

I am trying to see if we broke format-patch recently, or it is a
manual editing error.  The latter I do not care about; the former I
do.
