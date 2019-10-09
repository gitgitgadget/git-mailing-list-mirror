Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A4561F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 01:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbfJIBVD (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 21:21:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58731 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfJIBVD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 21:21:03 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 66BD736543;
        Tue,  8 Oct 2019 21:21:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ib5Rcd5dFNdfxkfAyiKuhbMeuWg=; b=Xgqj97
        77j9xmy8U96cwEUXL3Tj0n1pERcTPx36zIJYkybbIINJS9QllKNuFvkmTxiAiR7s
        bqqKPGqeb2xMm65Ha6mDVwEqnO+iAg3coeGNOD3oehBAI3JJ0b4EcRHKFiEhV2/T
        eXnqN1mJjjw6dsKF/Zabu6xy/HUPsnPdOLQzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LrEey+C3XNQisdFHQ4nCRAVsheWjmFGR
        Sj6ZtAqIH7PKOCxw4UpdMUM83W/+RDoLxEEIeMcviilqLQCaFsiUBB0FtJ//eX8u
        rqAp/56ZW1RLDALfeGhQbhR8wUgFND4Jes1xvRoUlacFA9K1LRF3pReYuZdhkc+5
        +Mbltd+7uAU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B1BB36542;
        Tue,  8 Oct 2019 21:21:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 64FCD36541;
        Tue,  8 Oct 2019 21:20:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 00/20] hashmap bug/safety/ease-of-use fixes
References: <20191006233043.3516-1-e@80x24.org>
        <b4e667d3-89ee-7f0f-55a5-10926d615ace@gmail.com>
Date:   Wed, 09 Oct 2019 10:20:58 +0900
In-Reply-To: <b4e667d3-89ee-7f0f-55a5-10926d615ace@gmail.com> (Derrick
        Stolee's message of "Tue, 8 Oct 2019 09:59:37 -0400")
Message-ID: <xmqq1rvmn285.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D0723A6-EA33-11E9-88FC-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 10/6/2019 7:30 PM, Eric Wong wrote:
>> v3 changes:
>> - use __typeof__ to avoid invalid clang warning on uninitialized var
>> - formatting fixes recommended by Stolee
>> - add Reviewed-by for Stolee
>> - add patch 20 to update docs to drop first member requirement
>> 
>> Range-diff against v2:
>
> I scanned the range-diff (and patch 20) and think this series is in good shape.
> My Reviewed-by stands.

Thanks.
