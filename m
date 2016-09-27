Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FDE220986
	for <e@80x24.org>; Tue, 27 Sep 2016 21:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753109AbcI0VpH (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 17:45:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52563 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751962AbcI0VpF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 17:45:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1EC6640439;
        Tue, 27 Sep 2016 17:45:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qlh5XrQCBdKTMT/5Omebywsm7ug=; b=LdiyRe
        IMZ0Nt6WNipkhfrictI10gevWWWDHs0v58TvDXI84CjP/nf3A3EmavCkz9f4R7/H
        0/AMemDDGp9hqp3/PtTyTD6L9aozrl5w1JzjaEoV4eRL8bIg2pgVjpxGxiW4PA+M
        61nX+FUN9acf9tmsFGpg45MciPppRlu2HB0gg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YMKpclI5kEtTtE0zJH6V1xm3O3rvGXbv
        wx6onHjqoVK8JnFSyJVMnypPldE/YFMTtGZFB4O4biPvhzJbXWgF9oyj9h8rRO7W
        uyToM8WKkyvi0dTm4vzuFK8ZQksuqPauGLJIDf0kXsELyTrD7j0L8keV7pvTt1zD
        RsAewd1coBQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9902040435;
        Tue, 27 Sep 2016 17:45:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6FEE540433;
        Tue, 27 Sep 2016 17:45:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 1/2] tree-walk: be more specific about corrupt tree errors
References: <1475009991-16368-1-git-send-email-dturner@twosigma.com>
Date:   Tue, 27 Sep 2016 14:45:00 -0700
In-Reply-To: <1475009991-16368-1-git-send-email-dturner@twosigma.com> (David
        Turner's message of "Tue, 27 Sep 2016 16:59:50 -0400")
Message-ID: <xmqq1t05m2zn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A534FC34-84FB-11E6-A787-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, will queue both.
