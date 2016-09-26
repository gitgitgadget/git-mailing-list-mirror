Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCE59207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 18:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422670AbcIZSsN (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 14:48:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57781 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1161228AbcIZSsN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 14:48:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8CD6B41C88;
        Mon, 26 Sep 2016 14:48:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VTvQZn5I4JmhU4BCqkBOHkXrNv8=; b=szNrnV
        dZAcD4FUPw1abVD6/doNCEzlDvw9UW73iZDhfjB/7/YmJUNBtT+ZlyoBs+stF6xy
        iSsAUBdBVdDALvXzMD/9rVqDVrIbJHx9mt3BZ19Nm23c4YvH8A/MN60yA/qVP/xq
        x2ioizxqBbIGK9Z2JxuKYNwsaDDUXUn5J/f3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nSs0aRVV/zFjtxbCj/57//Ab0MQumCGK
        SpGNsMevWFAZ0soIlAtQWGIER+CM6Dda0bENNlms07LTfqDs1ECd98nd6xm5se3P
        1qMeg/G7Mkuzd9ElW2sXE04zQ0f0bkCwRYG3hnsU71DnGvDZtOtrqLMQiDvET4M0
        tKFXS6O6gxk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8619D41C87;
        Mon, 26 Sep 2016 14:48:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 126AC41C86;
        Mon, 26 Sep 2016 14:48:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] recursive support for ls-files
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
        <20160925071744.2qcz7cntc7xxpjqv@sigill.intra.peff.net>
        <20160925163244.GB66080@google.com>
        <xmqqzimvygdt.fsf@gitster.mtv.corp.google.com>
        <20160926170429.GA3624@google.com>
        <xmqqponqseya.fsf@gitster.mtv.corp.google.com>
        <20160926183811.GA5123@google.com>
Date:   Mon, 26 Sep 2016 11:48:09 -0700
In-Reply-To: <20160926183811.GA5123@google.com> (Brandon Williams's message of
        "Mon, 26 Sep 2016 11:38:11 -0700")
Message-ID: <xmqqh992sdjq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C5EA1D3E-8419-11E6-8278-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> or something along those lines.  That way we only need to add the flag
> to each command as we go ...

Sounds good.  Thanks.
