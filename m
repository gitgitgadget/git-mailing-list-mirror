Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4105D20281
	for <e@80x24.org>; Mon,  6 Nov 2017 02:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751564AbdKFCeD (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 21:34:03 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60059 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750917AbdKFCeD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 21:34:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8AEE4B635A;
        Sun,  5 Nov 2017 21:34:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+/jDBFS4JAff53f080n7YPsENjc=; b=LCaAOv
        ZjDx4lTrs8xPqFdIt9l3/5xj36V1JHvdiIzA5eowQIKKEYDHjdNFw0rcgAB6bbGa
        ayMLSkcowaLXYLhgCmHo2PdaNTnNpXicmsCLKOpKnSCqmUiEL7F1hoGGmvPisEGt
        CvewnfRmoYmK3VlBqQ3vElyFF2aKpUBKXuFsY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E3EaFlmk60yZEhczkiyIjnszrfgTT3FJ
        HvNE6MHXMss95kCzi8CtLuyWGjONE1/+QgiddGldMA3kiwZt/JrqaYRMbuWbxirP
        UWmMzH2eLY+iTaTW1e26YlSAMMwUuk5hBiKH4GfrhWnbqzzj8jgCpy27PLwF4p+H
        wrLV1p0aJRE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 82EE7B6359;
        Sun,  5 Nov 2017 21:34:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 78698B6357;
        Sun,  5 Nov 2017 21:34:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jean Carlo Machado <contato@jeancarlomachado.com.br>
Cc:     jrnieder@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] fix typos in 2.15.0 release notes
References: <20171103232831.yrfi6qdq4q4zul4e@aiede.mtv.corp.google.com>
        <20171104121616.22264-1-contato@jeancarlomachado.com.br>
        <20171104121616.22264-2-contato@jeancarlomachado.com.br>
Date:   Mon, 06 Nov 2017 11:33:59 +0900
In-Reply-To: <20171104121616.22264-2-contato@jeancarlomachado.com.br> (Jean
        Carlo Machado's message of "Sat, 4 Nov 2017 10:16:16 -0200")
Message-ID: <xmqqy3nki19k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2FB780C-C29A-11E7-BEA5-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean Carlo Machado <contato@jeancarlomachado.com.br> writes:

> Signed-off-by: Jean Carlo Machado <contato@jeancarlomachado.com.br>
> ---
>  Documentation/RelNotes/2.15.0.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

It is pretty much pointless to update release notes after a release
is made, as the fixed version will not be seen as many people as it
should be.  So the next time it would be appreciated 10x if you send
such a patch before the release happens.

Will queue for the 'maint' track.  Thanks.



