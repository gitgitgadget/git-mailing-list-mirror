Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E19520988
	for <e@80x24.org>; Tue, 18 Oct 2016 21:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935195AbcJRVM1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 17:12:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50137 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934757AbcJRVMY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 17:12:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63D1249CB7;
        Tue, 18 Oct 2016 17:12:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IPMSvGDopAlFK3/W/oOmXgbNvQY=; b=eeAdIZ
        fc0GMA2TqOyMxBwOPYWixeTxkV+I2i1m411jhcAX2s+2tsgmYwja+42YSxsqBnz9
        lNGJXt2sNG7qT2CTN/U6Pf1rik8VxsEDbcYDYIZS883hUhQhcVj+nJZu7OOBzNC4
        uJMrr7sFATnebn6d+hA/oWGFrbzb8ivi3WMyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JOJ/73iqNHCTvQVmG5FFupm3qO/CtN9W
        T51NkEH4AMts+c0ETilouR6x/aOHOICuEdVlFsOJb8D15QfId+oGil4ph51JK4An
        /325TSZ2kvAVDURFZaEGWsK+dcAB0uOCgJ3WGVMnLbVuZACHty8T8n/+9el2Cquf
        guAOQmVZ+Ho=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B44849CB6;
        Tue, 18 Oct 2016 17:12:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D578E49CB4;
        Tue, 18 Oct 2016 17:12:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     j6t@kdbg.org, Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        venv21@gmail.com, dennis@kaarsemaker.net, jrnieder@gmail.com
Subject: Re: [PATCHv3] submodule--helper: normalize funny urls
References: <20161018210623.32696-1-sbeller@google.com>
Date:   Tue, 18 Oct 2016 14:12:19 -0700
In-Reply-To: <20161018210623.32696-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 18 Oct 2016 14:06:23 -0700")
Message-ID: <xmqqzim1nyz0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F51B2AE-9577-11E6-8B5A-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The remote URL for the submodule can be specified relative
> ...
> v3:
>  * fixed the coding style.

Ah, thanks.  I had a squash queued on top but will replace with this
one.
