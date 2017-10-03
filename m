Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FD0120281
	for <e@80x24.org>; Tue,  3 Oct 2017 00:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbdJCAVh (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 20:21:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52944 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750927AbdJCAVg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 20:21:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EE8ECA4D00;
        Mon,  2 Oct 2017 20:21:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q+guK/0Wwrx/WnclBmkh35+vuFA=; b=PhjGwX
        KsiWxaeZvIvkM7mCs+lk0Yc7rhsIk2wHD4clT7IIq5rfRlN9uPDKRu/OhDDYsW5r
        Ndo1O8UhEpG19KLSNjj/OyL4SdW9fmhwWShFD5OsytQD3kmVSwuaYPtp5t5YEHyQ
        FR0cmDCpnHNpdVxuAB5Z/601Eyndmv77oU5i4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FYO+HH1swNoqQSkL2lbNNprVURNWh/MS
        vSgnl2FlZZy8nVAyT+ohd2Ibi1/tklk66oCpxBSOilm9yoIyT+CXckkvtvOe9Tsz
        OAPKgX0iX/7Zv6I5oBDXy/AxcdYaOUToLRcfeoglyxjVNks6WM/sgp4kZyfqUOvW
        CgbKQiuYcXs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E6F6BA4CFF;
        Mon,  2 Oct 2017 20:21:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5FD9BA4CFE;
        Mon,  2 Oct 2017 20:21:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] branch: change the error messages to be more meaningful
References: <20170730115908.13841-1-kaarticsivaraam91196@gmail.com>
        <20170821133608.5652-1-kaarticsivaraam91196@gmail.com>
        <1506964786.3504.3.camel@gmail.com>
Date:   Tue, 03 Oct 2017 09:21:34 +0900
In-Reply-To: <1506964786.3504.3.camel@gmail.com> (Kaartic Sivaraam's message
        of "Mon, 02 Oct 2017 22:49:46 +0530")
Message-ID: <xmqqbmlpm67l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0ABF928-A7D0-11E7-8662-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> I was recently searching to find the patches have gone missing in to
> the void for no obvious reason and found this. Should I consider this
> to be "Dropped" in terms of the "What's cooking" emails? or has this
> just not received the required attention?

I do not even recall what the patches did and if I thought what they
wanted to do made sense, so I wouldn't be surprised if I did not
pick them up, after seeing nobody's commenting on it.

