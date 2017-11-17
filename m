Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A5E7201C8
	for <e@80x24.org>; Fri, 17 Nov 2017 06:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933646AbdKQGfG (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 01:35:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65153 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933562AbdKQGfF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 01:35:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0BDAA7233;
        Fri, 17 Nov 2017 01:35:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BKX1KFHMgpaB7Ih+X6uknKYZM9E=; b=JR9rCM
        5P8BZ2TofvYX3es0JTm21b+UVQRErW/jMRtsifuryPFi08At8/s1eggiHLBO4ooD
        NGq9bY7kF8fjcP/hAOx5qzW/21ubs5hyP8CLb8AbSjIrNmJ7gIOYlLPm6r5T4uwM
        RZnIJ8pRMt6fDX3kDuLj08KRNWJnISx8dKJcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uzGvbR3UumbXQLA3B4P5HMc8KnMBGW8K
        v+0/sHB0UKFZlTh/I2Acgx6OP3rcFv/n2TXa0KLgRjGyioHarqxelPjYoVLT2dKj
        wvspOFmbNhp4xSdrh5pGIidq28Z9a1N8FvStGGVnlcr1hWw0iUYfjw/1GDN0umM6
        MBhefW0b7L8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B7FCFA7232;
        Fri, 17 Nov 2017 01:35:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2FF3FA722E;
        Fri, 17 Nov 2017 01:35:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2017, #05; Fri, 17)
References: <xmqqbmk1sabs.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 17 Nov 2017 15:35:01 +0900
In-Reply-To: <xmqqbmk1sabs.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 17 Nov 2017 15:12:07 +0900")
Message-ID: <xmqq375ds99m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 715B54F0-CB61-11E7-94C8-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * av/fsmonitor (2017-11-13) 7 commits
>   (merged to 'next' on 2017-11-13 at db56ad7eef)
>  + fsmonitor: simplify determining the git worktree under Windows
>  ...
>
>  Various fixes to bp/fsmonitor topic.
>
>  Waiting for follow-on fixes to settle.
>
>
> * bp/fsmonitor (2017-10-05) 15 commits
>   (merged to 'next' on 2017-11-07 at b08d44ba60)
>  + fsmonitor: preserve utf8 filenames in fsmonitor-watchman log
>  ...
>
>  Originally merged to 'next' on 2017-10-05
>
>  We learned to talk to watchman to speed up "git status" and other
>  operations that need to see which paths have been modified.
>
>  Waiting for follow-on fixes to settle.


The two topics were waiting for updates to av/fsmonitor to quiet
down, which seem to have happened by now, so I'll consider merging
them to 'master' soonish.

Please let me know if I should wait for a bit longer.

Thanks.

