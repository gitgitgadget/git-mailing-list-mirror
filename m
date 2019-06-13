Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DF681F462
	for <e@80x24.org>; Thu, 13 Jun 2019 20:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfFMU4m (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 16:56:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56531 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfFMU4m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 16:56:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 460E47854D;
        Thu, 13 Jun 2019 16:56:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Th7zk/XcloAvA4TS+VTL2XtFEFg=; b=Ko3QWY
        3jpkMEox8muEviWyDfU/0IaWj6JC6A2iZsPL0GOlMg8Y2mG5gUMcbPn4hVuJpPUx
        dWijZLTCfWDBRwDMfJg8dp/oXJW3m2DBoI0aG1b1cY6LTZtlkIEZ6i0oq1gqbGVw
        6a4BdhEZupS5HWboo8g+8JlPZKoZ4usQ7NyYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gB1+rSfeoFgnn9+7NrQrzxwOyUDs0JxX
        zsbktdIgeMfDiDkeZj/AefY8PMMNYT/5BxFrCOehIYGVTrXUEj7IQiEiHa4TY+Pu
        ZhDcO+kTgGCMurw8J1QXI7bdkjOLDDMwUN/JkliH3/quGnnOQZBS59m6W1UJdOKk
        Ehv5H3lOnvg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3D5817854C;
        Thu, 13 Jun 2019 16:56:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B20E678548;
        Thu, 13 Jun 2019 16:56:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2019, #03; Wed, 12)
References: <xmqqk1dqigz1.fsf@gitster-ct.c.googlers.com>
        <20190613020517.GA15030@archbookpro.localdomain>
Date:   Thu, 13 Jun 2019 13:56:34 -0700
In-Reply-To: <20190613020517.GA15030@archbookpro.localdomain> (Denton Liu's
        message of "Wed, 12 Jun 2019 22:05:17 -0400")
Message-ID: <xmqqpnnhurul.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBCBF58C-8E1D-11E9-9FE4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Would it be possible for you to queue the "teach branch-specific options
> for format-patch" patchset[1]? Even if it doesn't make it in its current
> form, I believe that this patchset contains some changes that should be
> relatively uncontroversial.

Hmph.  I was under the impression that they were abandoned, allowing
"includeif.onbranch" to supersede it as a more general solution.

Looking back at the discussion thread cited

*1* https://public-inbox.org/git/cover.1558492582.git.liu.denton@gmail.com/

it seems that the more general includeIf topic stirred enough
interest but not those 8 patches from v3 (or from v2).  If you feel
strongly enough, re-post them to ignite renewed interest in list
readers' minds, perhaps?

Thanks.
