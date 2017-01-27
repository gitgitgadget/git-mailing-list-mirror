Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49C721F437
	for <e@80x24.org>; Fri, 27 Jan 2017 21:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751647AbdA0Vqv (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 16:46:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57647 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751294AbdA0Vqt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 16:46:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 933D863BB4;
        Fri, 27 Jan 2017 16:40:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LGsg5iBn7V+BrLFOpNsFkwjwWZM=; b=fO0GwH
        phmjNHItFLifNbiHBqOxovKpr89zUQEFRSHQmMMNXmwOPOOC2l319pxpn6eMTkkN
        hwtYoi0ExfjLEX1GeiwgxCoPM/ti/kdMM9IwIMH+NT/kPPFfHffQhxg4+qsKH+rA
        zxOw/DRo774Y/BxZ35A7w6svQr7p3RYgP6foY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TyUFRbPzp29GOG1t2RJ++/Lk34YzxaNf
        PkXXMN4DaFqkt3lcJ4p6aENU1imvkUnyaxTOFo9cNV67Vm+XsJ43uqz3OMezx9qV
        76qfg0dsQ3U97e9X0UUhR8IOIBYNHIDKhopZLvjNBmS6N/P6u0i90eTeuk6crU62
        uaoxTK8/pOE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C1A563BB3;
        Fri, 27 Jan 2017 16:40:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C764963BB2;
        Fri, 27 Jan 2017 16:40:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] doc: clarify distinction between sign-off and pgp-signing
References: <20170127200136.29949-1-cornelius.weig@tngtech.com>
        <d65bc165-9bd3-c7a6-9a55-1904d1bc095e@tngtech.com>
Date:   Fri, 27 Jan 2017 13:40:30 -0800
In-Reply-To: <d65bc165-9bd3-c7a6-9a55-1904d1bc095e@tngtech.com> (Cornelius
        Weig's message of "Fri, 27 Jan 2017 21:04:21 +0100")
Message-ID: <xmqqr33oxju9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A4A02A0-E4D9-11E6-925B-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cornelius Weig <cornelius.weig@tngtech.com> writes:

> Sorry, I forgot to mark this patch as follow-up to message
> <xmqq60l01jr9.fsf@gitster.mtv.corp.google.com>

I appreciate that you are very considerate, but in practice, if you
do not have too many topics in flight and your response time is less
than 48 hours, we can tell which new message is about which older
discussion thread.  Don't worry about it too much.

Thanks.
