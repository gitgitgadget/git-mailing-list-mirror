Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5A631FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 16:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750850AbdA3QxY (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 11:53:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56099 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750772AbdA3Qve (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 11:51:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EC2463D76;
        Mon, 30 Jan 2017 11:51:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r+sg+33evMQDeo546XgD5GocD2U=; b=k4az/k
        sQRnXidDIVpafy+RQQAvxFFI7YevFAmJVcVAASQD0PqiBRyKHy+N06JZE8vel0XJ
        GO3cc4JqJ9ZYKa5VBRJjLp6meFwPV1gH1mM314diYuaQkYdasypo4I2o0wbQiQla
        GLK/6W6W9i+R1r68kof489rrou6naAsDIUcCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bWIqmj36rTuMmcXzKDPvUpU/JtkA/NT5
        l9Dy2ApDdUHdLHgrHDGunrMNdcgAQEzw00WorXblyLUyzuVWuOqm+fX1+Q4Opxsb
        3Dszf33wwWCUKHTs2jCfXXmaF/A57qNNGnufYdgiOC7a2Zz/7DnqTLsuGSr9sd8N
        J2CXPHhxIyI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85B2363D75;
        Mon, 30 Jan 2017 11:51:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B016563D70;
        Mon, 30 Jan 2017 11:51:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3] mingw: allow hooks to be .exe files
References: <9a27b90e771d4c97dc580d344e161d7cf8d632ce.1485433248.git.johannes.schindelin@gmx.de>
        <78a73c9d0a8e38fcc61302d0495533dcc4fab076.1485779272.git.johannes.schindelin@gmx.de>
Date:   Mon, 30 Jan 2017 08:51:26 -0800
In-Reply-To: <78a73c9d0a8e38fcc61302d0495533dcc4fab076.1485779272.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 30 Jan 2017 13:28:28 +0100
        (CET)")
Message-ID: <xmqqr33kwkxd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57A4217A-E70C-11E6-BC2A-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Executable files in Windows need to have the extension '.exe', otherwise
> they do not work. Extend the hooks to not just look at the hard coded
> names, but also at the names extended by the custom STRIP_EXTENSION,
> which is defined as '.exe' in Windows.

Will replace, and looks good enough for 'next'.  Let's stop
iterating and go incremental if/as needed.

Thanks.
