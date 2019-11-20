Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2668AC432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 01:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED48D22429
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 01:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ieRGu8sp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfKTBSo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 20:18:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53689 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfKTBSo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 20:18:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D72C21EBB;
        Tue, 19 Nov 2019 20:18:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gUFoGxJn7hI/
        5GKWEsMj9O8ucEw=; b=ieRGu8spfqvXwF2KwAOTBgpm1gX6sIbTSJNQWUka9pA/
        BUYEeDeSpPpMx/OeBe9OdN97FYZJqL19CFyz18XUO7DbNgTlRpmu8qrKfo+VMci1
        YFpRqqcZ3bEP9AqycvCjTqFC260yaArDHBfOZ1rsQe4PuFLpMFCvccpu3Pll0so=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=flsQ8W
        XLEWRXgKZmIdOwQ2jQi9qc5Ous325gMk0RHjJAX+eSEGzkrMcVRBBLgLVvHkBfLM
        ypkM0B4k14r22LlGjBhfEm5VNkF/47hYe39ON3qMN2seXb7sefwPwXq8p5KSHH+/
        PQgzBFXEH1XmKk1dIpiRuaJLZJ13Pkubby30A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 44E9521EBA;
        Tue, 19 Nov 2019 20:18:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9CD0F21EB9;
        Tue, 19 Nov 2019 20:18:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 1/1] ci(osx): use new location of the `perforce` cask
References: <pull.400.v2.git.1571316454.gitgitgadget@gmail.com>
        <pull.400.v3.git.1571789978.gitgitgadget@gmail.com>
        <9d80e845bf923c4543c49f9947aacb10c59ff6ce.1571789978.git.gitgitgadget@gmail.com>
        <20191118221804.GA23183@szeder.dev>
        <nycvar.QRO.7.76.6.1911192155140.15956@tvgsbejvaqbjf.bet>
Date:   Wed, 20 Nov 2019 10:18:39 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1911192155140.15956@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Tue, 19 Nov 2019 21:59:21 +0100
        (CET)")
Message-ID: <xmqqk17ve45s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B0428256-0B33-11EA-814B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > +	brew cask install perforce || {
>> > +		# Update the definitions and try again
>> > +		git -C "$(brew --repository)"/Library/Taps/homebrew/homebrew-cask=
 pull &&
>>
>> In the build of v2.24.0 this 'git pull' printed just short of 600
>> lines worth of diffstat.  Two weeks went by since then, and in today's
>> 'pu' build that diffstat is already over 1000 lines long.
>>
>> Perhaps we could use --quiet here, though that would suppress the
>> transfer progress as well.
>
> Isn't there an option to suppress the diffstat specifically?

-- >8 --
Subject: ci(osx): update homebrew-cask repository with less noise

The OSX CI build procedure updates the homebrew-cask repository
before attempting to install perforce again, after seeing an
installation failure.  This involves a "git pull" that by default
computes and outputs diffstat, which would only grow as the time
goes by and the repository cast in stone in the CI build image
becomes more and more stale relative to the upstream repository in
the outside world.

Suppress the diffstat to both save cycles to generate it, and strain
on the eyeballs to skip it.

Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/install-dependencies.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 4e64a19112..b6b4f4707f 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -42,7 +42,8 @@ osx-clang|osx-gcc)
 	brew link --force gettext
 	brew cask install perforce || {
 		# Update the definitions and try again
-		git -C "$(brew --repository)"/Library/Taps/homebrew/homebrew-cask pull=
 &&
+		cask_repo=3D"$(brew --repository)"/Library/Taps/homebrew/homebrew-cask=
 &&
+		git -C "$cask_repo" pull --no-stat &&
 		brew cask install perforce
 	} ||
 	brew install caskroom/cask/perforce
