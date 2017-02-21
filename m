Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D73F201B0
	for <e@80x24.org>; Tue, 21 Feb 2017 16:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753871AbdBUQpe (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 11:45:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54433 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753838AbdBUQpb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 11:45:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 605686A337;
        Tue, 21 Feb 2017 11:45:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=g0H13KmEkN0HZvh2hwxIyTNZ9IQ=; b=LsSkvQ
        aPlTgWaBWlsE5xisfO9QPZxwuV2lOvglVpiCYFGcLuRxQI+aYaPQ2jdrpjIWU8dV
        DiMJmU3CkhNON/XomnIoALl3YbteTBSUYE+aax7Yae7jzD2okSDUWhvDWGd1b6fG
        Zp2BaI9FmXk2ceBDsT7pHAyKsK2a77fK5TzKY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 57FAA6A336;
        Tue, 21 Feb 2017 11:45:29 -0500 (EST)
Received: from localhost (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CDD646A335;
        Tue, 21 Feb 2017 11:45:28 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] delete_ref: support reflog messages
In-Reply-To: <xmqqr32sggfo.fsf@gitster.mtv.corp.google.com>
References: <20170217035800.13214-1-kyle@kyleam.com> <20170221011035.847-1-kyle@kyleam.com> <xmqqr32sggfo.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 21 Feb 2017 11:45:27 -0500
Message-ID: <87d1eb4hnc.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26D23A6E-F855-11E6-B011-FE3F13518317-24757444!pb-smtp1.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=g0H13KmEkN0HZvh2hwxIyTNZ9IQ=; b=NRf+Xtxzl/cVprcWv1UhIIp/8prHGIFnpj2+jy3L2MpyGg+1f0he7NJNa0z4AVunvEvgJ91b8Giz8aDrr2dyu2A71QgKpiH7VXQ8UennPNGPy35U1G3WzX091NDDEcznqBZBDoILXa3ToEB9P6j+jUCBi8ctSqwyQzDeepQSkdw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> These looked reasonable.  I had to resolve conflicts with another
> topic in flight that removed set_worktree_head_symref() function
> while queuing, and I think I resolved it correctly, but please
> double check what is pushed out on 'pu'.

The merge looks right to me, thanks.  Thanks also for touching up the
tab/space issue in t3200-branch.sh.

-- 
Kyle
