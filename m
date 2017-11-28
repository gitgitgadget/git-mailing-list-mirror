Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5894F20C11
	for <e@80x24.org>; Tue, 28 Nov 2017 04:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753354AbdK1EHI (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 23:07:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65273 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753480AbdK1EHG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 23:07:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EEA3FA618A;
        Mon, 27 Nov 2017 23:07:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=btPrcuufmZAo7NQIe6quvPbNzRw=; b=pPKjjc
        esa/JVjE2AJsxlCq/2B9/fxpVvNuXCeq8OJ/VzgnmCIEW3iOU7/+W2poLwLCICEG
        OJQ+nwSt9iZwozVM54s9OODxxFGLTsqXwH1Y96ZznLJn0bGU1trfvcXHg3OOpIFL
        VGKeDl0CRle0MUkVfVees0ceBxmP5mBEjvnpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FLf9+G2r0lXdusP1me+lGIjY8FlL+L1G
        8bMXYyeleV+cTnVZy2j4WAIF7VmCvMas5ks+e4szYN+OHRewgikDOzF/XDcb/4uo
        ProNawI8/YsSSSXZ1TpMEHB+JrGtzUo6hEpF/WQ90FEULiHtkmQx8fBSIIVvCv99
        VZUcBAsAf1I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E6C80A6189;
        Mon, 27 Nov 2017 23:07:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4062BA6188;
        Mon, 27 Nov 2017 23:07:04 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] repository: fix a sparse 'using integer as NULL pointer' warning
References: <69fdc850-da71-6df3-5299-eb67ef5d74df@ramsayjones.plus.com>
Date:   Tue, 28 Nov 2017 13:07:02 +0900
In-Reply-To: <69fdc850-da71-6df3-5299-eb67ef5d74df@ramsayjones.plus.com>
        (Ramsay Jones's message of "Tue, 28 Nov 2017 03:01:19 +0000")
Message-ID: <xmqqtvxf6o7t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97A414CE-D3F1-11E7-B4CE-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Hi Junio,
>
> I don't recall Brian doing a re-roll of the 'bc/hash-algo' branch[1], but
> now that it has been merged into the 'next' branch, sparse is barking on
> that branch too. This patch (slightly different to the last one) applies
> on top of 'next'.

Thanks.  Will queue on that topic.

