Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30B491FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 21:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757308AbcLUVVV (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 16:21:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65480 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753982AbcLUVVU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 16:21:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 060B859806;
        Wed, 21 Dec 2016 16:21:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3M6w/bIzOURuQIJIForjLzxsrhk=; b=XRIoOg
        xKtIHLvyOLJOj0MDa4zituczv+BR13ARbIuYSyERw35hX+ntv/eaRxXwM71gQTl3
        VOmhQX3d8aYivKeFYUp1Q5L4iyCShlJCx/5qvXFB2jvDCQEKlmj+jONFIPvYpcSn
        BH9VYebFIU4OCpYC4h4Qosox7jq0SLwaQy+d8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hc07OLSgDm9pEfGlcHZsx4opP/LAtib/
        PB6sEs3CR0YCdHYzol6Ve4QHCQ3yQZsQQkxgiyqZ/IPdvNTTfscu4jq/T8VWMCno
        MW/f+rIt8A1AIDTeY4dtmZ2Oms/jujfM23g+i+dOAylJdoLwNDA3AtFqgJy9HF0G
        hEy7ZwRrSwQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F2C3F59805;
        Wed, 21 Dec 2016 16:21:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6FD0C59804;
        Wed, 21 Dec 2016 16:21:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 0/2] Really fix the isatty() problem on Windows
References: <cover.1482342791.git.johannes.schindelin@gmx.de>
        <b0541907-ee79-207b-dc0f-1e3e7d761950@kdbg.org>
Date:   Wed, 21 Dec 2016 13:21:17 -0800
In-Reply-To: <b0541907-ee79-207b-dc0f-1e3e7d761950@kdbg.org> (Johannes Sixt's
        message of "Wed, 21 Dec 2016 22:15:10 +0100")
Message-ID: <xmqqzijpger6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 698C3534-C7C3-11E6-AA6A-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 21.12.2016 um 18:53 schrieb Johannes Schindelin:
>> The current patch series is based on `pu`, as that already has the
>> winansi_get_osfhandle() fix. For ease of testing, I also have a branch
>> based on master which you can pull via
>>
>> 	git pull https://github.com/dscho/git mingw-isatty-fixup-master
>
> Will test and report back tomorrow.

Thanks.
