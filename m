Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E124206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 18:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbcLLStM (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 13:49:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60823 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751742AbcLLStL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 13:49:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 69729552D9;
        Mon, 12 Dec 2016 13:49:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OCtvYVOvsqEDhFXnKIXgW8ELxuI=; b=jLi+ld
        1JADRbhyCu5k68CfVr6G2S1u6V6JiBMOTpri6B0E3NgvmmeKWPgh096We/aO5e/k
        ESPKvlkK6MHgssExltz1goGITDBSPJATG9ZIuFe1l6gRAvkUVcEQ42iNXV4wa9e7
        EtbeJYzpzzwSRqVdwTRJw5Nw+t4SXy4v1XbH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e0PZRkmC+aaCc7vxpJTAm40knVYTv/oJ
        +EIomS/SRvhwKV5yOSBtw35PXBZwaMZ8rYktPEUzhCe9IwVxSq17u9ryEmIdivg6
        wrf8AzDvwJViLHY5jq69Cn9RWJ0QU9vRgVx/UjJsHjljCJXhscG0bkzliq/hUNTy
        0FmwKBcWLJM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 627ED552D8;
        Mon, 12 Dec 2016 13:49:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D70E7552D7;
        Mon, 12 Dec 2016 13:49:09 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PULL] minor git-svn updates (probably for 2.11.x)
References: <20161212111320.GA25451@starla>
Date:   Mon, 12 Dec 2016 10:49:08 -0800
In-Reply-To: <20161212111320.GA25451@starla> (Eric Wong's message of "Mon, 12
        Dec 2016 11:13:20 +0000")
Message-ID: <xmqqmvg1m197.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AAC620C0-C09B-11E6-AE48-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> The following changes since commit 8d7a455ed52e2a96debc080dfc011b6bb00db5d2:
>
>   Start post 2.11 cycle (2016-12-05 11:31:47 -0800)
>
> are available in the git repository at:
>
>   git://bogomips.org/git-svn.git master
>
> for you to fetch changes up to 1b7edec78b754a1e901c164a4bf4e94bff96ed7b:
>
>   git-svn: document useLogAuthor and addAuthorFrom config keys (2016-12-12 11:09:29 +0000)
>
> ----------------------------------------------------------------
> Eric Wong (2):
>       git-svn: allow "0" in SVN path components
>       git-svn: document useLogAuthor and addAuthorFrom config keys
>
>  Documentation/git-svn.txt | 8 +++++++-
>  perl/Git/SVN/Ra.pm        | 2 +-
>  2 files changed, 8 insertions(+), 2 deletions(-)

Thanks; basing these two on top of "Start post 2.11 cycle" that is
on 'master' would mean that this won't merge to 'maint' for 2.11.x,
though.  I hope you wouldn't mind if I rebased them on top of
'maint' before merging?
