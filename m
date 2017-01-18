Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BD091F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 19:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753268AbdARTMl (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 14:12:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52331 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751863AbdARTMl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 14:12:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 009DA61495;
        Wed, 18 Jan 2017 14:12:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oXuPMqICT7dVQnZt51ikXR4/SuI=; b=mIEi+I
        fGTNBVc6Bn9iLF23tl+cN761U4U4IKQyzrvgZw2WlQIY8pj+8bCBBz6uECC/a8Rr
        oCDCMYsJnF9mrcff3L3KWjr6hJGo9DeFUyIYPy8IRS6iOaGMRCVtPsSf1jzzjhGx
        diaoUPjGk0T2RsyRZGisQA0qdWJpn2ArWXxIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZG0vwwlt73r/15phoxER/DuF445ImBuu
        5aw5498mZLJvVYTP9wmM28V0pNCvAScyXerFmE/+P7E25ef8CyUZJyfNFuJ7+W0M
        9hq4MMYZGVwGe3XPaQX+wihpcyGuYh9Jb8IXybA9P88tEgOS1TIuP0h1CSiqnEcW
        SPvYPClP/04=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E816061493;
        Wed, 18 Jan 2017 14:12:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 05A496148E;
        Wed, 18 Jan 2017 14:12:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2017, #02; Sun, 15)
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com>
        <257b4175-9879-7814-5d8d-02050792574d@kdbg.org>
        <alpine.DEB.2.20.1701161251100.3469@virtualbox>
        <20170116160456.ltbb7ofe47xos7xo@sigill.intra.peff.net>
        <alpine.DEB.2.20.1701161746200.3469@virtualbox>
        <677a335f-889c-2924-b7bd-93c2b6663175@kdbg.org>
        <20170116214411.a6wnp66vxydmpmgw@sigill.intra.peff.net>
        <xmqqo9z5fqdj.fsf@gitster.mtv.corp.google.com>
        <1aa4a8b0-4bda-edbc-7be8-1ffd9f74eef7@kdbg.org>
Date:   Wed, 18 Jan 2017 11:12:37 -0800
In-Reply-To: <1aa4a8b0-4bda-edbc-7be8-1ffd9f74eef7@kdbg.org> (Johannes Sixt's
        message of "Wed, 18 Jan 2017 07:50:17 +0100")
Message-ID: <xmqqfukg9o7u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13F9A976-DDB2-11E6-87C1-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 17.01.2017 um 20:17 schrieb Junio C Hamano:
>> So... can we move this forward?
>
> I have no objects anymore.
>
> -- Hannes

Alright, thanks.  

Dscho what's your assessment?  My "I do not think" before the quoted
"can we move" above was more about giving a statement for people to
argue against, by saying "no your understanding is wrong", in the
hope that it would highlight why we need more work in this area if
needed and in what way.

Thanks.
