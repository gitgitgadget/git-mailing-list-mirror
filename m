Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A040F208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 21:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753306AbdHJVwl (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 17:52:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51778 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753167AbdHJVwk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 17:52:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EEFD0A0BB5;
        Thu, 10 Aug 2017 17:52:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7qIOYdqANa4VStFt+1+3t/mLtiY=; b=qihFQ/
        /+Fa5K3oLIHUJPgUIDH6Q9/QY7mbE4NbxEst+EtHsxlrdQ33lvDGDVnaMNTs41m8
        EX+w0X1cTZIt3wyu1b8XLMTnsh3Bo+vl4L/G55ZQRPaFOtIWaopeCdSu+Eo+qqRZ
        R8+zP5j4HvpnAv1yv6vmSQGuiPKX0aJ4ClDqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UPzYrVt7fjTMXo+T6zvmyVjhD32gjgmb
        1bXtDWcSIuVbrm6fauDHD2Q1wpkf5As+qSEjHjw/c+9COJunVUq+nwxFBhj2gDcu
        Nx8e8jLwYR323kV+rei2Go7Ac4FjBS0fGiNqhLDGy0fWmtqxR3+N0L2SEqmSn7/j
        nH8O+jNgpzc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E5A26A0BB4;
        Thu, 10 Aug 2017 17:52:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 41DDEA0BB1;
        Thu, 10 Aug 2017 17:52:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 3/4] Convert zlib.c to size_t
References: <1502388789-5775-1-git-send-email-martin@mail.zuhause>
Date:   Thu, 10 Aug 2017 14:52:37 -0700
In-Reply-To: <1502388789-5775-1-git-send-email-martin@mail.zuhause> (Martin
        Koegler's message of "Thu, 10 Aug 2017 20:13:08 +0200")
Message-ID: <xmqqy3qr1462.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A6F79B4-7E16-11E7-B478-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Koegler <martin.koegler@chello.at> writes:

> From: Martin Koegler <martin.koegler@chello.at>
>
> Signed-off-by: Martin Koegler <martin.koegler@chello.at>
> ---

Thanks.  I haven't thought things through but this looks sensible.
Will queue.
