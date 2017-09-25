Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB35520A26
	for <e@80x24.org>; Mon, 25 Sep 2017 08:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934056AbdIYI7O (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 04:59:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51679 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933513AbdIYI7N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 04:59:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 637CDB515A;
        Mon, 25 Sep 2017 04:59:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qh6XZqnZwl5psS6jy5OdgecINUo=; b=lPmz/r
        mUTrTEggA2/rWxhnipvxpsPWXOZAnx6IVTsAn+0gyKycXgf5OLVFYw2BjidnJ+Ee
        5h5Q1yw0ihqoxV4LJZw+V2OM+I/IqUlOfl0meApCv8vMXAMLpzm+jh4UUsHKdnCj
        GQJz1Jn+kdnzK1pItmtNwg/GOezS8UIpu7JKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EFX7BpXOCa61UhDxSi+p1eOnHPa57ml3
        30VXT2M68U3HYYLKFQol5vmpSXKADEZnrSYwKwxO4YwNf6ZsESKFg3Dv32PSlH2X
        ZTo0wHfrZvIf30ITGrLsrGFgUum51jdlPMCp4acGZ4MdpHn+g+ekAOQ8SKE3I2fa
        RYxes/fip+g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59BFBB5159;
        Mon, 25 Sep 2017 04:59:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AC258B5158;
        Mon, 25 Sep 2017 04:59:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Manav Rathi <mnvrth@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCHv2] docs: improve discoverability of exclude pathspec
References: <CAEuZsW8vR0LesL=+ZoiFa=BBwhhm=KON+U3H2H9sNdTT+jgBkQ@mail.gmail.com>
        <xmqq1smvh9my.fsf@gitster.mtv.corp.google.com>
        <20170925080900.GA60206@r>
Date:   Mon, 25 Sep 2017 17:59:10 +0900
In-Reply-To: <20170925080900.GA60206@r> (Manav Rathi's message of "Mon, 25 Sep
        2017 13:39:00 +0530")
Message-ID: <xmqq377bduht.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC5F45CA-A1CF-11E7-8351-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Manav Rathi <mnvrth@gmail.com> writes:

> Hopefully this one should not be broken.

Looks good.

Thanks.
