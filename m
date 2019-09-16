Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65A7E1F463
	for <e@80x24.org>; Mon, 16 Sep 2019 17:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfIPRSz (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 13:18:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61912 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbfIPRSz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 13:18:55 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CDA7A25F5B;
        Mon, 16 Sep 2019 13:18:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DNT05+lNHPgjPBz4PEGli/WhkBs=; b=gvd4ox
        zhAfSKnGktiQu5OpQB0ragoVEXx/ill7EU71vGorSo0LIfHQq6fhay+kaEkB/2rg
        zWty2taubZwV3je44kOE3Nzfbimwit3uxDGlzLo+K7k4yzfFdPTdJRfZczAbXu7z
        eOU2zhO46o6x/6iGV3o0yppNW6SD5Hs4LeUeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Nd1JGs0pXFeJXwYQvn+9k/MYVdzrm1NV
        /u7JUXZBejT8q/RRYXUNlgkmGOn+1D2dkiiFVVILEI/yOk4ZgGaBSQlvG6ZhOGAs
        qxDEOTnzl2Tb+sDGyqGWnxUVMRopo5QBmkr1m88UmxyiPEQJRCoBO7kG+pYmsPEH
        UVWht1Ct3Qg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C542425F5A;
        Mon, 16 Sep 2019 13:18:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F077425F59;
        Mon, 16 Sep 2019 13:18:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     git@vger.kernel.org
Subject: Re: [GIT PULL] gitk update
References: <20190915233328.GD9560@blackberry>
Date:   Mon, 16 Sep 2019 10:18:50 -0700
In-Reply-To: <20190915233328.GD9560@blackberry> (Paul Mackerras's message of
        "Mon, 16 Sep 2019 09:33:28 +1000")
Message-ID: <xmqqpnk0b1mt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DD8DFFC-D8A6-11E9-95CE-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Mackerras <paulus@ozlabs.org> writes:

> Hi Junio,
>
> Whenever it's convenient, please do a pull from my gitk repository at
> git://ozlabs.org/~paulus/gitk.git to get four commits updating gitk.
>
> Thanks,
> Paul.

Will do.  Thanks.
