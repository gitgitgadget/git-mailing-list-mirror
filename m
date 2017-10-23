Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96651202DD
	for <e@80x24.org>; Mon, 23 Oct 2017 04:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751208AbdJWEqN (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 00:46:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53156 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750995AbdJWEqM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 00:46:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A70ABAE2BB;
        Mon, 23 Oct 2017 00:46:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZzvoCGXr6mEgxIugLHlbjzQ5zko=; b=OABj9G
        gI5rShiKgKBdE/zOIoL3OFtuMC/6OP5AydK5vGlcqQiDtV1tbnh5xMpW43wnlKju
        RaxysM5hNDbb9cbekz7KLd5e5sUQ4qqP9DGoW9OjhpVa0XJ1maSHDooyJalcaiXZ
        Fehd+ASGiNE/7Kd92zqLhpfbN1dRkZT8Vj6GY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=biQ5M11pRK22rSQtmAHU2MlH9QCjm252
        pNgnPkqGRqZUgEjSMpiCEjtMkCpUWT3APzUfpMdWXyH7gjN70dkFTkpLxIpDMq9F
        GBOpTDeKLVRXXiF8lxyafC/c4m7RAOk3uBObKWL376X7iGiGHx/mfAkwlcWAza38
        65taudlF5sY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E6A0AE2BA;
        Mon, 23 Oct 2017 00:46:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 24D23AE2B9;
        Mon, 23 Oct 2017 00:46:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jameson Miller <jameson.miller81@gmail.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jamill@microsoft.com,
        peff@peff.net, sbeller@google.com
Subject: Re: [PATCH v3 0/4] status: add option to show ignored files differently
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
        <20171019160601.9382-1-jamill@microsoft.com>
Date:   Mon, 23 Oct 2017 13:46:10 +0900
In-Reply-To: <20171019160601.9382-1-jamill@microsoft.com> (Jameson Miller's
        message of "Thu, 19 Oct 2017 12:05:57 -0400")
Message-ID: <xmqqvaj6bhf1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 179F5960-B7AD-11E7-BF7C-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jameson Miller <jameson.miller81@gmail.com> writes:

> Jameson Miller (4):
>   status: add option to show ignored files differently
>   status: report matching ignored and normal untracked
>   status: document options to show matching ignored files
>   status: test --ignored=matching

Thanks, queued.
