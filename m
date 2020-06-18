Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BA4C433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 16:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD0A620888
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 16:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="umTdySaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbgFRQSj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:18:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54835 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgFRQSh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 12:18:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A8D6D7478;
        Thu, 18 Jun 2020 12:18:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GYGHDR1pz3cDR0JLfotSNnEZjXs=; b=umTdyS
        aHXFyp+OCW/gk64p+YTaOk7rk0RrxCPXCfhN5tW0AZLZ0MjX4SRhTJ8Xo8RvAh/3
        xkyAlYxVCsCFtfKFxEc/gLWzrRol2nR/cXdGzTBMHEUUv2fIDQL5NM0J+OxzBJrT
        nnZK3JYfmzejG3yrBZUaKNdkArdeOfCqmxU6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aNI6hcUegqNMSqHNzg6xmhTpIIUjkqaK
        g2acC/uZwolVRInx5HDqQMrR+8d8NtfVZhJDLZ9XqLi0c1sPEzqhiWGVwSBPxvIT
        QlB4TBleMJUBFC7V9D9ctNd+etpcg7isAiZKi4KufxTly9wRPtec/2UTg8+IX45B
        vgILQlSrMaA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 53640D7477;
        Thu, 18 Jun 2020 12:18:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9009ED7476;
        Thu, 18 Jun 2020 12:18:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: sg/commit-graph-cleanups (was Re: What's cooking in git.git (Jun 2020, #03; Wed, 17))
References: <xmqqpn9wq3tl.fsf@gitster.c.googlers.com>
        <76f63479-c142-86f2-c045-f802f7794a7d@gmail.com>
Date:   Thu, 18 Jun 2020 09:18:31 -0700
In-Reply-To: <76f63479-c142-86f2-c045-f802f7794a7d@gmail.com> (Derrick
        Stolee's message of "Thu, 18 Jun 2020 09:32:34 -0400")
Message-ID: <xmqq5zbopctk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A87E6F6-B17F-11EA-BE0D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> In summary, if you would like to keep these together as a single
> topic, then perhaps this summary might be good:
>
> 	The changed-path Bloom filter is improved using ideas from
> 	an independent implementation.

Wonderful.  Thanks.
