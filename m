Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF74C433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 21:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358153AbiCPVqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 17:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358172AbiCPVqG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 17:46:06 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDFE2125E
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 14:44:51 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4DF5116FF8E;
        Wed, 16 Mar 2022 17:44:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4z5VE9tRy1pW/eZLhDSqYadJJM6QAy6VKdVDl4
        9f+Pk=; b=nDph6oPWiWYpBjCYj+jFbJ2Dk3aNtDIchJANQPplbXfY1/R70m/UOm
        nZDQM5HOSeKelg24RDgsdMPidBZ9IQrLRLQb44qCYmwwxRrMaQg1jhhR60Yg6dnd
        Rx7w7LVqjL+tYjrVnt/JNC1r4YQ3i6+hkeN3uAaMz0KHiPnkZrMGk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 46EC916FF8C;
        Wed, 16 Mar 2022 17:44:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ACE0516FF89;
        Wed, 16 Mar 2022 17:44:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 6/6] doc: add stash export and import to docs
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
        <20220310173236.4165310-7-sandals@crustytoothpaste.net>
        <xmqq35jhn6ni.fsf@gitster.g>
Date:   Wed, 16 Mar 2022 14:44:47 -0700
In-Reply-To: <xmqq35jhn6ni.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        16 Mar 2022 10:34:09 -0700")
Message-ID: <xmqqr171k1ww.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D879404-A572-11EC-8294-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> Now that we have an easy way for users to import and export their
>> stashes, let's document this in manual page so users will know how to
>> use it.

It was raised during the review club meeting that it would be easier
to read if these documentation updates are made in the same commit as
the ones that added the feature.
