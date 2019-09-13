Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21CF41F463
	for <e@80x24.org>; Fri, 13 Sep 2019 17:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbfIMRZ2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 13:25:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64670 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfIMRZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 13:25:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1F296839EC;
        Fri, 13 Sep 2019 13:25:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0ec/7kXkcFQaOnggGYJthTO51rw=; b=FNi0Sg
        Qy5GTuKnUP0lxmLRks98fRSD0XmzsIs85Gy+DuunXbZBQTy8a1PPg2ggj/B2/1BI
        w49Ky9Gcj8GZqEuHZ9dTKXvL3RZkODiP3/gSueWXcQliGDfJcGagODwJpyNoS6Hg
        8hhNg9cPSZwuT4WXvKNUM0/VFSWBg/kksAdwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pFDfo4QHXPWLGrJAKsfjDIqMiL8uDF+B
        sBxJDgGDoO2CMdwlCPuCD4rK6izXiqu55nCvJ9YqaonRT3xU/JX6GxGlfDWd3Dnl
        iTukQBKHLVaOrVRMW/zIEvZy/u4LvWJmfDufUvs/XZ1Ij+mXaL1anxfHYft+yc/e
        PJWR0Kshjog=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 17A3F839EB;
        Fri, 13 Sep 2019 13:25:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BEA5F839E4;
        Fri, 13 Sep 2019 13:25:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Stephen P. Smith" <ischis2@cox.net>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Date test code clean-up
References: <20190909014711.3894-1-ischis2@cox.net>
        <20190912041102.16266-1-ischis2@cox.net>
        <20190913050809.GA28353@sigill.intra.peff.net>
Date:   Fri, 13 Sep 2019 10:25:20 -0700
In-Reply-To: <20190913050809.GA28353@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 13 Sep 2019 01:08:10 -0400")
Message-ID: <xmqqwoecds73.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 778A9326-D64B-11E9-8F8F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Sep 11, 2019 at 09:11:00PM -0700, Stephen P. Smith wrote:
>
>> Range Diff:
>> 1:  f4170ad553 ! 1:  e2b8322d58 Quit passing 'now' to date code
>> [...]
>
> Thanks, this version addresses all of my concerns from v1 (and overall
> looks good).

Yup, the result of applying these look good.

Thanks, both.
