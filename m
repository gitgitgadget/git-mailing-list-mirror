Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86D871F403
	for <e@80x24.org>; Mon, 18 Jun 2018 21:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934676AbeFRVnw (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 17:43:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50812 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933073AbeFRVnv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 17:43:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F842F92BC;
        Mon, 18 Jun 2018 17:43:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=Sp9e/+qbXAPyFGPScWINTZoYZ4o=; b=ZXhreMQ
        GFRswxNQYfdP0DZLFD/lIQE/pc7+m4xnWc0Logm9bWerKrG774d229j10OCqhgCN
        qS/SyFJXHsfFYKeM5JqaSE3mNKNqwNb6r9feInAxl+ZYv6KfmBxG9fvM1KATWnqW
        7MfRzTpd+O4j6+gS9nO4y07kJbEhCfrHpMh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=qJ67b8exWsFpm4YIdTnhLTtj0zxIXScGw
        asDY+p54X6OH9LV8dozbKjnFx3ScB3LccXRX4VGB6/8yctgsIqQvDXfd/RuVcI9D
        S1b8hQTphzNjq/po+3RI/rJfnVN3/Cl1bvP9bqJhZrQeoxBYg75UceKo5WIBuAnz
        2iw4oaQXrk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66E67F92BB;
        Mon, 18 Jun 2018 17:43:48 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB0CFF92BA;
        Mon, 18 Jun 2018 17:43:47 -0400 (EDT)
Date:   Mon, 18 Jun 2018 17:43:46 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2018, #05; Mon, 18)
Message-ID: <20180618214346.GP11827@zaya.teonanacatl.net>
References: <xmqqsh5jwzp3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsh5jwzp3.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: AEA59780-7340-11E8-85AE-44CE1968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Junio C Hamano wrote:
> * tz/cred-netrc-cleanup (2018-06-18) 3 commits
>  - git-credential-netrc: fix exit status when tests fail
>  - git-credential-netrc: use in-tree Git.pm for tests
>  - git-credential-netrc: minor whitespace cleanup in test script
> 
>  Build and test procedure for netrc credential helper (in contrib/)
>  has been updated.

It looks like 1/4 from that series didn't make it into the
tz/cred-netrc-cleanup branch: git-credential-netrc: make
"all" default target of Makefile, which is in
<20180613031040.3109-2-tmz@pobox.com>.

Thanks,

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I used to think the brain was the most advanced part of the body.
Then I realized, look what's telling me that.
    -- Emo Phillips

