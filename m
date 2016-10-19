Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B62A20986
	for <e@80x24.org>; Wed, 19 Oct 2016 21:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754124AbcJSVmd (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 17:42:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50062 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753556AbcJSVmc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 17:42:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8BBE447CDD;
        Wed, 19 Oct 2016 17:42:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nnEXOIeNeYmok++GX34ukbR3yNc=; b=roZCEE
        eQxms8vkEnOp9Wvytvb9/M57ehdW9GaVMt5VsC+KNjo0lFdiQkNDdS16pRFQP8Ng
        6apaPkdfbR0QMhHlRt5EA4r5xjTPG5ydLiHdMwxzJz2e9QkWrw7cARQa/xQwSdcv
        OPWtKN75LV3RfsoQGsq7ZKvfIyMHrC4clj4S8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ln3+2Zw+R0J0XVHou/y6e5vovAmf+QTl
        C6HeMSsRRn+4ZpkvI1rsoobGmXZCj7t+Wup1EEaw8R5p6yNmQ0I6Dyb5dR1Wil8a
        4kGaNVu7HAM6exsXeOSSzAxUQ1TyDDOigJ+oisbW4jNP/X7cSSysb8KKxFTIc2mq
        SuzCt+6JWbE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8071547CDC;
        Wed, 19 Oct 2016 17:42:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F011A47CDB;
        Wed, 19 Oct 2016 17:42:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH] submodules: update documentaion for submodule branches
References: <20161019204254.97659-1-bmwill@google.com>
Date:   Wed, 19 Oct 2016 14:42:28 -0700
In-Reply-To: <20161019204254.97659-1-bmwill@google.com> (Brandon Williams's
        message of "Wed, 19 Oct 2016 13:42:54 -0700")
Message-ID: <xmqqmvi0j9rv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0029A78-9644-11E6-9EF0-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Update the documentaion for the the special value `.` to indicate that
> it signifies that the tracking branch in the submodule should be the
> same as the current branch in the superproject.

Thanks.  Will typofix while extending with info supplied by Stefan
like so:

    submodules doc: update documentation for "." used for submodule branches

    4d7bc52b17 ("submodule update: allow '.' for branch value",
    2016-08-03) adopted from Gerrit a feature to set "." as a special
    value of "submodule.<name>.branch" in .gitmodules file to indicate
    that it signifies that the tracking branch in the submodule should
    be the same as the current branch in the superproject.

    Update the documentation to describe this.

