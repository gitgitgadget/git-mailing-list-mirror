Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D8BCCA48B
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 15:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiGUPjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiGUPjN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 11:39:13 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC2688F33
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 08:37:37 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 434BD137A3A;
        Thu, 21 Jul 2022 11:37:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s0KOCrmkR5siOe18Cv9DJCE2deIbFI1A7naq5o
        cKOLU=; b=mgeCm7kBGCR+a9iv0ChA4K4nu7SI8evJCx7PKa7CvuUu7NDXiXQzXH
        OUoZJwPFjDDITSQRn8rohiImu8aEPJiAPWZUZ7YDGoxbcIv3qcT9pD3U0CW33h2r
        fXRpKHx5EnZH/RjnmjxeAbDxYbLnt2/z6X7JFyg+mh2EuY/F9p28o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3ACF0137A39;
        Thu, 21 Jul 2022 11:37:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3C44F137A38;
        Thu, 21 Jul 2022 11:37:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Question: How to find the commits in the ancestry path of seen
 down to _and_ including a given topic?
References: <CABPp-BEK+SJh2uF=rrM-f1u9diMQJ7D3H0fJLdzWpyOww=ys+w@mail.gmail.com>
Date:   Thu, 21 Jul 2022 08:37:32 -0700
In-Reply-To: <CABPp-BEK+SJh2uF=rrM-f1u9diMQJ7D3H0fJLdzWpyOww=ys+w@mail.gmail.com>
        (Elijah Newren's message of "Thu, 21 Jul 2022 00:23:53 -0700")
Message-ID: <xmqqy1wmlbnn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09D60AD6-090B-11ED-B59E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> A simple question that I'm spinning out of [1]: How can I get `git
> log` to show the commits in the ancestry path from seen, back to *and
> including* a given topic (but not commits from unrelated topics)?

Drawing of a sample history, please.

I feel stupid asking this, but I do not think I even understand what
the question is X-<.

Commits that are ancestors of 'seen' and are descendants of the tip
of the topic?
