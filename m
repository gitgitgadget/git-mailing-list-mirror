Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DC741F462
	for <e@80x24.org>; Wed, 19 Jun 2019 14:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfFSOcM (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 10:32:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64670 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfFSOcM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 10:32:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1290F15E362;
        Wed, 19 Jun 2019 10:32:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VBWbrW4ZhE61wRCRDv3OkO28hgk=; b=hrv8sH
        tr1JK1jq8arTiSpo4/qV6jzKJXxlX2IsSpaedh1LrtCJ53K01HlqZovqbBLdoqjA
        Dp6OuCms7V6pdVCoE2pESkxd8qcJWAtFCYZBDrxSKqHKLUUImeZO1EMT8pgq274S
        uEVtl76f3iIZrUVvBhwx5HXbqqzeSppNEPoiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gdEsXwkP4CHYcMsqSepWE5w4jNj26wFy
        jkyloZz/VO2jMQFKDgaLbl+WW4x9+L/1fSwaP799BJwwuYAZ7IH+j41SSXISuiyt
        r9EbLAmqmkCUxkFuzXZ7uEtXnE3jd39tGzsJR7b4aZX9IYhr8SrYbE5p2lHc7M94
        z8Hmzq4ycIM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A33015E361;
        Wed, 19 Jun 2019 10:32:10 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7105015E360;
        Wed, 19 Jun 2019 10:32:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: ds/commit-graph-incremental (was Re: What's cooking in git.git (Jun 2019, #04; Fri, 14))
References: <xmqqh88ruc1b.fsf@gitster-ct.c.googlers.com>
        <8690d49e-31f5-e12a-ae8c-dc217a5476cc@gmail.com>
Date:   Wed, 19 Jun 2019 07:32:08 -0700
In-Reply-To: <8690d49e-31f5-e12a-ae8c-dc217a5476cc@gmail.com> (Derrick
        Stolee's message of "Tue, 18 Jun 2019 09:36:08 -0400")
Message-ID: <xmqqo92tr6hj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 051D3CD4-929F-11E9-882C-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 6/14/2019 4:50 PM, Junio C Hamano wrote:
>> * ds/commit-graph-incremental (2019-06-12) 16 commits
>>  - commit-graph: test --split across alternate without --split
>
> Please hold on this one. I've found multiple issues while integrating
> this with VFS for Git and there are enough to merit a full re-roll.

Thanks.

> Please ignore the two patches I sent yesterday as I will incorporate them
> into the next version of this series.

I think I picked up "normalize c-g filenames" and queued it directly
on top of this topic, but I do not recall the other one, which
probably means I did ignore it so hopefully no harm done ;-)

