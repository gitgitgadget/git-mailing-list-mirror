Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C6C520756
	for <e@80x24.org>; Tue, 10 Jan 2017 20:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751229AbdAJUiS (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:38:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54872 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751045AbdAJUhF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:37:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 69FEE5FC72;
        Tue, 10 Jan 2017 15:37:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QkZIeiVdJBLos8dLdiAO5Fp3cgE=; b=qofJVA
        oFkoyP5mrdvMDEFqr1XQsjXssiwiBtOwxWH0G0n4R1L1fBgNCaHPAaDbMTmVYxpi
        nO607Rbp55gFxyaeRxed1Ckd9x+M6R94lcM8AW86JTkLqkjiZbBV/Tfa9c8g2rLU
        apmKnOByyN+7i0meJWRwLVmyi6qBfsh5Uk+JI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MaXMKF4t0VnV+D0s6elg8hDVTCmWEYSs
        MO2/IdfD3qextLu/FuUU/U8+6DJTMaft9cge/VaPlGE1+4O+obRqz48FuRKXrfkq
        JnEjpP4p4WvOn/ElI6Ma8UTM3xnc56wms0izfNAGsFq5mD/KoUxwm0slvdsZPnQ6
        dKaL4aeoeAQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6128D5FC71;
        Tue, 10 Jan 2017 15:37:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AAE615FC6D;
        Tue, 10 Jan 2017 15:37:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, novalis@novalis.org, git@vger.kernel.org
Subject: Re: [PATCH 2/4] t1000: modernize style
References: <20170110014542.19352-1-sbeller@google.com>
        <20170110014542.19352-3-sbeller@google.com>
Date:   Tue, 10 Jan 2017 12:37:02 -0800
In-Reply-To: <20170110014542.19352-3-sbeller@google.com> (Stefan Beller's
        message of "Mon, 9 Jan 2017 17:45:40 -0800")
Message-ID: <xmqqr34ar6s1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B7A9E90-D774-11E6-8094-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The preferred style in tests seems to be

s/seems to be/is/;

>
> test_expect_success 'short description, ended by 2 single quotes' '
> 	here comes the test &&
> 	and chains over many lines &&
> 	ended by a quote
> '

Thanks.  This is way overdue.  During the time the script has been
dormant for more than two years, we should have done this.
