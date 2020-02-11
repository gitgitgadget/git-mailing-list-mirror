Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2B8C35242
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 20:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78618206D6
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 20:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vMtQDUeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbgBKU5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 15:57:02 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50432 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731844AbgBKU5C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 15:57:02 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CEE244382;
        Tue, 11 Feb 2020 15:57:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=60OPHRiEvlc6ylVuhkOs8YK65JM=; b=vMtQDU
        eWkIbhOTh/AHQ9QM6HBpIxul3JggDwd0CIaodGi+YiOat8Br2lbc50zPMN+2ch01
        Kf9fs1wLrZAeOPsGoDu3jdshpoLFUKm/3Wx9ncrUh9zNKxJAjYL3Z6b6VV+uEIPN
        8SW49PvCFeP83IA5H42IS0lOxcwadq/UteH3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qXUe4J/nu1UlLKXnFHdru0g0QkLS7qwW
        enwSuFyG6yoWoE7QP762hZLksLu5Fz1OdPUvcJNNtzlj92IeX9V930KLeQE3oqEP
        jy0tVKP3cueqqvwZ+SNpdkcZfdJOtuuOGzFYxOZqvBf/6dV40z0pZZ+V/iPZxh+x
        eiSaaJ053SQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 104EF44381;
        Tue, 11 Feb 2020 15:57:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 32EDE44380;
        Tue, 11 Feb 2020 15:57:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Garima Singh <garimasigit@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2020, #02; Mon, 10)
In-Reply-To: <819852c9-68dc-11e3-d81d-ddd216953d72@gmail.com> (Garima Singh's
        message of "Tue, 11 Feb 2020 15:04:21 -0500")
References: <xmqqimkexeed.fsf@gitster-ct.c.googlers.com>
        <819852c9-68dc-11e3-d81d-ddd216953d72@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date:   Tue, 11 Feb 2020 12:56:59 -0800
Message-ID: <xmqqsgjgvo4k.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C2CDFB6-4D11-11EA-A62F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Garima Singh <garimasigit@gmail.com> writes:

> I am squashing this patch into the appropriate commits in v3, which I will 
> send out after people have had a chance to complete their review of v2. 

Good.  Thanks.
