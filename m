Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3A0D207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 19:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161674AbcIZTJO (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 15:09:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50286 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752814AbcIZTJO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 15:09:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A9C9641FE6;
        Mon, 26 Sep 2016 15:09:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XybOLN163zc3kzF30SeRyOVTx8U=; b=Gg0qyF
        FDTVTlqccfwaVD62YcYlU2zcyxvVIr1esYXHQPTO+/Zbn7iPe+JReTBNnZ0w8XMW
        fgz1A9TsWnjAQTNG7D3mvc3v3jfL9trw9dfkVbFb0gNedhcppuJLmVLDqC9nOz+C
        P8JOwKtP7VdrNEpBZI8hWdAzcKYovbtDISVi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BjBXeClricTwJrNyy4rKRPjohjJB8MHp
        jsiRi9V47cgZ25rf0uQl+ul6/Tr4hra2LP7Mh7MdsjKaXo5sdmXqoh9G8lyVObgN
        6feQ9ypPW1eS5lVar0bRAYdH4/U8x0kM+Vzdzi3XMwuR9R795BtBLM88YKmzvCSP
        +P0Iw9uM++Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1DC441FE5;
        Mon, 26 Sep 2016 15:09:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2E73241FE4;
        Mon, 26 Sep 2016 15:09:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2016, #07; Fri, 23)
References: <xmqqlgyiz0lr.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1609242101100.129229@virtualbox>
Date:   Mon, 26 Sep 2016 12:09:10 -0700
In-Reply-To: <alpine.DEB.2.20.1609242101100.129229@virtualbox> (Johannes
        Schindelin's message of "Sat, 24 Sep 2016 21:05:32 +0200 (CEST)")
Message-ID: <xmqq8tuesckp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5990F1E-841C-11E6-98B9-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Also, I found https://tinyurl.com/gitCal very convenient a URL to point
> to, do you plan to update that for v2.11.0?

Thanks for reminding.  I've barely had enough bandwidth to keep up
with the list traffic for the past few weeks, and haven't got around
to it.  Will find time this afternoon to do so.

Please just assume the usual 8-12 week cycle til then ;-)
