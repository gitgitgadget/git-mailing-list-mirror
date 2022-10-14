Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D745C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 20:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiJNUld (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 16:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiJNUl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 16:41:29 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B1BDF45
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 13:41:27 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 31E881C462B;
        Fri, 14 Oct 2022 16:41:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9gVAoUCj3qeg8S6Y0oUlhOyRpUWZO9nRABLcYe
        tjgNU=; b=qSuio17SkthuLPEtwUHpqhfPYTScBjLgqDuyd22VRn+RnpyqNvv4cx
        aH9yUbVcfK9OXp0MPT2bt51ncca7UjDaN4lGdRpOET1vB3noekMK+GhZRZoLfMq6
        0sPs53DYkyHGoAOR3A8GT9UzZsf8sG1iYVPMZrf7e6GcI3JEtiQro=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 28ADA1C462A;
        Fri, 14 Oct 2022 16:41:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4B62C1C4629;
        Fri, 14 Oct 2022 16:41:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        nsengaw4c via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, nsengaw4c <nsengiyumvawilberforce@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v3] [OUTREACHY] t1002: modernize outdated conditional
References: <pull.1362.v2.git.git.1665733647421.gitgitgadget@gmail.com>
        <pull.1362.v3.git.git.1665734502591.gitgitgadget@gmail.com>
        <xmqqv8om9yaz.fsf@gitster.g>
        <f064ce46-8ed0-a9c1-8df5-5c258677d95f@github.com>
        <CAPig+cT=bJ7BP9CDh5-oYYF376vVxsh7E0UAE_QN0wfAgR3AAg@mail.gmail.com>
        <xmqqh7068bta.fsf@gitster.g>
        <CAPig+cR2R3EY=53ELaFY3wqy7danQmHNm0Qeqqh9nW7n8XHNHg@mail.gmail.com>
Date:   Fri, 14 Oct 2022 13:41:23 -0700
In-Reply-To: <CAPig+cR2R3EY=53ELaFY3wqy7danQmHNm0Qeqqh9nW7n8XHNHg@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 14 Oct 2022 15:14:24 -0400")
Message-ID: <xmqq4jw687f0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9181ABBA-4C00-11ED-94FA-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> ... However, clarification about whether or not there needs to
> be a blank line before the CC: line would be nice (I presume the blank
> line is needed), but also whether or not GitGitGadget correctly deals
> with multiple people mentioned on the same CC: line or if they each
> need to occupy a single CC: line.

Indeed it is very good to have such a documentation that tells us
all these things.  Is the "Welcome to GGG" comment it adds to first
time users a good place to have this kind of information (I am
guessing not, as more advanced features may become needed after you
used the tool several times)?
