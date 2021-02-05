Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E543C433E6
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 01:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F34AE64FAF
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 01:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbhBEBf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 20:35:29 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55978 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbhBEBf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 20:35:28 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D8CAF11D8F3;
        Thu,  4 Feb 2021 20:34:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=O
        7DT/FowQjcdQp3V8Cmh/eJYTHA=; b=NPB4fbIrVo2DcLtnIOcKCsSf3i3um/IYO
        GNm1pQwe9KvNunrtGYS6S9VvNnaIU3cCnK/FYkfZtFdPOF8ZTSgSnbqkS3zJJvjL
        Z8p8ac2d9U3SXriIKPMrhSa0o8IvCxEGni33Sg/wZWYLpm17Yztgf7ri9pO5bM9d
        RJu2Zi/D88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=Q1D
        TVwd3o7+qjo5jrnv/i2SWspzOj7T2cu1N1Xi/rFF5LrnMmgfiJ0HJj4nkYscKA4w
        Em3wGwKFrywHhBtAaqt0hbx7CDh3hFcFoK4pCnxX+GRjagq5OJp+WxGQk+c5na+v
        vUX0sWJQnlETVhauzKJP1BwIB7v/cbgdmqxuvPkA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D178611D8F2;
        Thu,  4 Feb 2021 20:34:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 032FC11D8F1;
        Thu,  4 Feb 2021 20:34:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [rfh] where is coccinelle these days on Ubuntu?
Date:   Thu, 04 Feb 2021 17:34:42 -0800
Message-ID: <xmqqeehv2t71.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52DFDC2C-6752-11EB-B973-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is probably something that is very obvious for GitHub folks or
a debian person, but does anybody know what made it suddenly wrong
that we have been doing to obtain coccinelle?

https://github.com/git/git/runs/1835560289?check_suite_focus=true#step:3:108

