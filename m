Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50257C19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 17:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbiHKRxw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 13:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKRxu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 13:53:50 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B72A0624
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 10:53:47 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 088481551EE;
        Thu, 11 Aug 2022 13:53:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CxeeW6fmytQi2E0HT1q0dPcwuLyHdOzFjwdY3d
        5Ms/Q=; b=XVvelFUPXFguW/nwriQcbNLc0dfhGRjcczV8aJHKqeGwgO6Q7jgtqk
        WpypbEVQOAccHja1gINwBUfPAqT/9lksvejxZwxh9FBdkiq8QvAjnBuaWa5R9jla
        M+ywS3S++nzc7eXsFWi3PMP3KJDDuIOBjk9TfM84pgSGkH4Bs6tHw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3E1A1551ED;
        Thu, 11 Aug 2022 13:53:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6816E1551EC;
        Thu, 11 Aug 2022 13:53:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric D <eric.decosta@gmail.com>
Cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v2 2/2] fsmonitor.allowRemote now overrides default
 behavior
References: <pull.1317.git.1660067049965.gitgitgadget@gmail.com>
        <pull.1317.v2.git.1660233432.gitgitgadget@gmail.com>
        <7a071c9e6be68b58306582dbac5952a5b1bcbc6a.1660233432.git.gitgitgadget@gmail.com>
        <xmqqtu6ig1s5.fsf@gitster.g>
        <CAMxJVdEV=rSXtM-nagvtMPdArkvQgoNauaQb1sk0CL3sPSvKmw@mail.gmail.com>
Date:   Thu, 11 Aug 2022 10:53:43 -0700
In-Reply-To: <CAMxJVdEV=rSXtM-nagvtMPdArkvQgoNauaQb1sk0CL3sPSvKmw@mail.gmail.com>
        (Eric D.'s message of "Thu, 11 Aug 2022 13:49:07 -0400")
Message-ID: <xmqqpmh6fyzc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8AE97E5C-199E-11ED-A978-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric D <eric.decosta@gmail.com> writes:

> Well, needless to say I wasn't expecting GitGitGadget to do what it
> did.I had squashed things down to just two commits and forced-pushed
> the second commit thinking that just the relevant stuff from the
> second commit would show up in the next patch. Obviously that didn't
> happen. Sorry about that.

Oh, sorry to hear that.  If your ideal "logical progression" needs
two commits, then please do present the series that way.  What GGG
sent out was apparently not that (i.e. the same one from v1 with
full of fix-ups for it in 2/2).

