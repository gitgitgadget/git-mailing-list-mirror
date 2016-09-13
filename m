Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81CE620984
	for <e@80x24.org>; Tue, 13 Sep 2016 23:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932678AbcIMXIW (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 19:08:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60066 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932393AbcIMXIV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 19:08:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 82BB23EF39;
        Tue, 13 Sep 2016 19:08:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7zPU0GkqwizULPRhg36ZlFvqw/0=; b=f+NcL6
        wdkhmClNyzbAD3Sz5fiAo8K/WHT4kU6O0gCpAm2PiQuLr8EjI1E+hi6vczFY9ZKe
        4yMAQMqj2fi1o4AmcyNV5j8UamvWczG21PFEkaO7bKrsFnstemuDwEa9Lu671PfC
        dzyKgx+e3FoCqbsV1luc7j6nyqSVkVWCbNvIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bc1KWXRETQxqCHAfJyRZghozq1H8PRap
        JUyyCH2b6ozG3dkFYg5TtdkAQgEMufLeuJuzQgulW9zdArKb42E4HvLY2U8WC0Cb
        Trovny6PQhJ5dRnSk/jCGvJLa+r6fFdCOwiYTYj+I5cCwKYSkHyvqq6IIBbgvrqV
        ym5EodzA1z4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A8973EF38;
        Tue, 13 Sep 2016 19:08:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D08033EF37;
        Tue, 13 Sep 2016 19:08:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] pathspec: removed unnecessary function prototypes
References: <1473785571-60439-1-git-send-email-bmwill@google.com>
        <20160913181552.74bhacoa2q76yv6k@sigill.intra.peff.net>
Date:   Tue, 13 Sep 2016 16:08:16 -0700
In-Reply-To: <20160913181552.74bhacoa2q76yv6k@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 13 Sep 2016 11:15:53 -0700")
Message-ID: <xmqqh99jtn33.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F619E07E-7A06-11E6-B3C2-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Sep 13, 2016 at 09:52:51AM -0700, Brandon Williams wrote:
>
>> removed function prototypes from pathspec.h which don't have a
>> corresponding implementation.
>
> I'm always curious of the "why" in cases like this. Did we forget to add
> them? Did they get renamed? Did they go away?
>
> Looks like the latter; 5a76aff (add: convert to use parse_pathspec,
> 2013-07-14) just forgot to remove them.

Thanks for digging.
