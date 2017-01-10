Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 749E720A93
	for <e@80x24.org>; Tue, 10 Jan 2017 20:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751651AbdAJUpI (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:45:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50544 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751630AbdAJUpH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:45:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E3E2F5E543;
        Tue, 10 Jan 2017 15:45:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=thQZVMz4d6EByd0+tI/Rv3WercM=; b=p7SMMM
        gfaH7ONmpPAVyFAKv/1JzK63zcezkteMABRQs467FeZy654yqf3clN9LzjDm4cUU
        uc8N2aw88ytJXCgZlgFiwxejQ+xf8HanqTO2N4vd61APhEnPkbEZK41RvztM0G8e
        /v7fV2tGdqcIEkevbxCMxeKS8ppBmfPlxpOes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fZZqyVsSlOQQ0VVStkL0PRRqCZF82OUY
        I+Mh6osYl9Uo1k12GLeBpNIQPIz1S8KZjRp1gMZmiR7nyDJPCSmtFHbDjfwB5zZX
        JlIirZB/51KxRt0ET5FtB6VvKL06RBROmbXNclu6NsTKCb9VewZEIRQBvFl3h0jJ
        OwUDCfCScbA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB21E5E542;
        Tue, 10 Jan 2017 15:45:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F08725E53B;
        Tue, 10 Jan 2017 15:45:04 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com
Subject: Re: [PATCH v10 03/20] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
References: <20170110084953.15890-1-Karthik.188@gmail.com>
        <20170110084953.15890-4-Karthik.188@gmail.com>
Date:   Tue, 10 Jan 2017 12:45:02 -0800
In-Reply-To: <20170110084953.15890-4-Karthik.188@gmail.com> (Karthik Nayak's
        message of "Tue, 10 Jan 2017 14:19:36 +0530")
Message-ID: <xmqqfukqr6ep.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA523778-D775-11E6-8C1E-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> +			if_then_else->condition_satisfied = 1;
> +	} else 	if (if_then_else->cmp_status == COMPARE_UNEQUAL) {

Please, no space before tabs (locally fixed--no need to resend).
