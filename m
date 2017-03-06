Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03F6D20133
	for <e@80x24.org>; Mon,  6 Mar 2017 20:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932373AbdCFU2U (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 15:28:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62894 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932350AbdCFU2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 15:28:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A05D56F778;
        Mon,  6 Mar 2017 15:22:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sbhsI4YPxgC2xrUVNmRBb/P+UeU=; b=Dyo6FV
        Vc/qCSVPv0DSljKZr2dwCpJYLumEH/y8zg8zBp8naSVMD652UiF8dO0mgS0g/48N
        OgNFgewXEja7uOGG8YAOnmQLEzyjlwOFisXuAHcv+sm9VNjagHBbQA6j2Ic8aGVf
        oY4c9tL46mlKYsoXm6WSgsYcUZi9BE4ntgy98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aAwTwF+1JP2rwJGD1FDHRGDGf2f6Omi/
        u3c7KV1nevbdXSKK4Vbm2vgKN/vecx1f6YZRoT10ZY4RMzfKAFBv8Ae+D7I58HI8
        5ev5R4AmA2aKzksAP24ysRcYI1gOkbA3IQ+X/lFiiaE+XQJBN3asp4KOvfddlHYz
        e5PEBrtVpJo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 99AB36F777;
        Mon,  6 Mar 2017 15:22:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.84])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ECC356F776;
        Mon,  6 Mar 2017 15:22:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     <git@vger.kernel.org>,
        "Christian Couder" <christian.couder@gmail.com>
Subject: Re: bisect-helper: we do not bisect --objects
References: <xmqqvarq9vzo.fsf@gitster.mtv.corp.google.com>
        <D9E30A61FAC84D3B90981B388C9699D0@PhilipOakley>
        <xmqqd1dx7wbl.fsf@gitster.mtv.corp.google.com>
        <5556D465CF3A42C8B117759A170FE3A7@PhilipOakley>
Date:   Mon, 06 Mar 2017 12:22:25 -0800
In-Reply-To: <5556D465CF3A42C8B117759A170FE3A7@PhilipOakley> (Philip Oakley's
        message of "Sun, 5 Mar 2017 15:05:19 -0000")
Message-ID: <xmqqbmtenoji.fsf@junio-linux.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D992F90-02AA-11E7-8546-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> The study of human error is quite interesting....

Yes ;-)
