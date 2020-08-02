Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38DBC433DF
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 21:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6DF620738
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 21:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yG0s1mNX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgHBVoi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 17:44:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53161 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgHBVoi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 17:44:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FCF470743;
        Sun,  2 Aug 2020 17:44:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3XC7NBB62yadvuHCbEWG2UQJsRU=; b=yG0s1m
        NXnHdxqY3aZJbdXrDVoeEIhaJIxLsXgL/ct7LAhxTB4VnRboBsYxJMnSXIkUVyaA
        MaYJP2lo9VmpyN3n8abD+I0FtaQUmdjYSZfSilPwSorKtkx2sOhiEhL0HqyB0Z2B
        SokGkVFPq8B3T+aTx+F7O/8JkhePUvVblx8ko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Vxyu9ZpoIoCQ5rH1jj1p/MmpuA0UEf7L
        XodDv3cLBhHirNZd1nZAzFlrFloOMMnM246KmVUEDM4U5PEY47gnvqKGFHuTpkxW
        BLfUrDwnJVippkp7pL6tAcYwxT9ZMb3bmgSgC2hSzVKitWoUuauJLRvRJHvMEHQ5
        4wRhhyXCVtI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8851270742;
        Sun,  2 Aug 2020 17:44:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 19C5E70741;
        Sun,  2 Aug 2020 17:44:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 3/3] git.txt: add list of guides
References: <pull.691.git.1596381647.gitgitgadget@gmail.com>
        <9374d80f0c37a6b6a7f5f76601ee757f89712d0c.1596381647.git.gitgitgadget@gmail.com>
Date:   Sun, 02 Aug 2020 14:44:35 -0700
In-Reply-To: <9374d80f0c37a6b6a7f5f76601ee757f89712d0c.1596381647.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Sun, 02 Aug 2020
        15:20:47 +0000")
Message-ID: <xmqqsgd4rad8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BE34312-D509-11EA-99AE-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Not all guides are mentioned in the 'git(1)' documentation,
> which makes the missing ones somewhat hard to find.
>
> Add a list of the guides to git(1).
>
> Tweak `Documentation/cmd-list.perl` so that it also generates
> a file `cmds-guide.txt` which gets included in git.txt.

Who cleans this?  Do we need a change to Makefile?
