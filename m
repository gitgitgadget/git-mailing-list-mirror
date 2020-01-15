Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43764C32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 23:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18BB2187F
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 23:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UlabYGWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbgAOXw3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 18:52:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56602 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbgAOXw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 18:52:29 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 486DE3D5E5;
        Wed, 15 Jan 2020 18:52:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=B
        88pRU3b0EiqsfN5JRL/8zaDRCE=; b=UlabYGWiwASDgmGPWWIi2Xim3PvsWd1+x
        92QJFpYEI5yQOxMPU6zso8HmaXGD57fMVsuyM/TX8F6av2ngDyRrAE1Q29aY7YHF
        P7JIit34SiL8HteRhJTQolemQQYyYz0W5XfefY8yxOxj2j9WtlldksK5nm5lTN84
        v1IPgztU54=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=FrA
        dYap8wVYDBxdYkm36bCNlzpT6pEXeV+0ymsKGxLtjs86dEkD6f9JgI4KgUEJPnz0
        /JP3POJqLm/dtYrz6fA1UngucGRQX6NxnWvvI3PR9swrd0BwwbsXRKAZKbTF7Eeb
        yuSccSx6kFbpmEZ/tNa7te48wkXYyZjCpeY5plcI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 416D73D5E4;
        Wed, 15 Jan 2020 18:52:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A76303D5E2;
        Wed, 15 Jan 2020 18:52:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Preparing to kick off the post 2.25 cycle
Date:   Wed, 15 Jan 2020 15:52:25 -0800
Message-ID: <xmqqblr4i8g6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1549E2F8-37F2-11EA-B9AB-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tip of the 'next' has been rewound by ejecting a handful of
topics.  

All topics in flight that have been forked off of 'master' between
5d9324e0 ("Merge branch 'ra/rebase-i-more-options'", 2019-12-10) and
4d924528 ("Revert "Merge branch 'ra/rebase-i-more-options'"",
2020-01-12) have been rebased on top of either v2.25.0, or a commit
that used to be at the tip of 'master' before 5d9324e0.

I haven't finished adjusting "What's cooking" report for the above,
but I'd like to ask authors of the topics not in (or no longer in)
'next' if their topics still make sense (with my rebasing), and send
in a rerolled version otherwise.

Thanks.
