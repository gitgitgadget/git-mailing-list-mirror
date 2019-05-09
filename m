Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91F161F45F
	for <e@80x24.org>; Thu,  9 May 2019 06:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfEIGJW (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 02:09:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51344 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfEIGJW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 02:09:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1EC46158724;
        Thu,  9 May 2019 02:09:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F7IctbGmdM/xfUoFmcfB1aRm4io=; b=aAKttJ
        cZjkWtbDj8HeEzzKluKdYn+ZHWnIWmPet9cLdyRJHkVSKmWF6161q1PE8tB6nvPe
        86FblD/6/ALF1k1jNqGwlplN06SJxDq42veUFwA2vmh1sC7gfUnIi88XrtfDvPEJ
        Ib85BneXKoZ1+ELDGgQDfPs6EggtwOHTCYmXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mi1RhALJk5e9t96PNJBkMk8S0Tu8ZZSu
        i9mcAVA1MglmlwpH6C6OO7bTt0IvQvrqN6eIuQrS2FFAJbokbGO64VTpyiqeECkP
        JFCVLFfGP53F9509rgB2R19lkvuBMzHzEQAyty/Xd4SUOHUUQzgsLY+qmhnA/FVx
        /OFQ9B+f+z0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 169FD158723;
        Thu,  9 May 2019 02:09:20 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 825E6158722;
        Thu,  9 May 2019 02:09:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] tag: fix typo in nested tagging hint
References: <4213b04b1f7262bc53c83dffc82956951dfe869f.1557342925.git.liu.denton@gmail.com>
Date:   Thu, 09 May 2019 15:09:18 +0900
In-Reply-To: <4213b04b1f7262bc53c83dffc82956951dfe869f.1557342925.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 8 May 2019 15:16:41 -0400")
Message-ID: <xmqq4l64f9bl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB7F9E04-7220-11E9-82CD-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In eea9c1e78f (tag: advise on nested tags, 2019-04-04), tag was taught
> to hint at the user if a nested tag is made. However, this message had a
> typo and it said "The object referred to by your new is...", which was
> missing a "tag" after "new". Fix this message by adding the "tag".

Thanks.  Makes sense.  Will apply.
