Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83E0C3496F
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6EF24747
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CeCPq37t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfLMRUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:20:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58879 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbfLMRUY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 12:20:24 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DC7D225AB;
        Fri, 13 Dec 2019 12:20:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t2TmWxRFy67RDf++H7EVgNpLdpw=; b=CeCPq3
        7tzOAlCi97qx/bWhFRQ6zspaXF0A//wTjSBeIy5FMCP1orOV1dxab8xIMyNQ4gvl
        fAs37vGICAyhYzMjS7sjkJf4oB1R5HoqvlIEXRXbCjEKdRPsEWGwlG92SDqYQorR
        7l10zN/MKsXXse6OFLAFRxxRBmlWMVX/huXcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lvg5TqTdWwOJ7r4n9xxpKPhQYrtCRf7Y
        fqdaUywcMCnr/TvkazV5hC0FNyfgTAXRaTHdClxMU+mwE8Ce2kz0iBV0Bjyt67p7
        /DHHoYqYxg4tSOcp4SAJ49PY6CeeFQyozhMUjYnz7DFIkEjPvHNGZbi0NIUqaeYe
        4Hc+ab0fQAA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15966225AA;
        Fri, 13 Dec 2019 12:20:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 71877225A8;
        Fri, 13 Dec 2019 12:20:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Kerry@google.com,
        Richard <richard.kerry@atos.net>
Subject: Re: [PATCH v3] MyFirstContribution: add avenues for getting help
References: <20191213013128.6268-1-emilyshaffer@google.com>
Date:   Fri, 13 Dec 2019 09:20:20 -0800
In-Reply-To: <20191213013128.6268-1-emilyshaffer@google.com> (Emily Shaffer's
        message of "Thu, 12 Dec 2019 17:31:28 -0800")
Message-ID: <xmqq36dom9bf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D788F9C0-1DCC-11EA-BA70-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Since #git-devel's traffic is fairly low, it should be OK to direct some
> questions there too.

Correct me if I recall wrong, but wasn't #git the original IRC
channel we developers hang out on, and then somebody thought "the
traffic is fairly low, so it should be OK" and directed non
developer trafic there, which caused the developers to migrate out
to #git-devel, a new channel?
