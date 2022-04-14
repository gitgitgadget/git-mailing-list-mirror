Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B5FC433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 00:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238307AbiDNAYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 20:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236640AbiDNAYe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 20:24:34 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8131EC45
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 17:22:09 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4728112DA47;
        Wed, 13 Apr 2022 20:22:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xx78K43SGUXlOIvXQFyEoxbDJI+nlQUgODfO4i
        lZg5o=; b=K1tZjd8BmZ4CTF/BNJGLcCq6N0eeeBRixIQY7vSKSYIDWT0q2VX2/k
        COiH/7aY5ryOvTKAZq3qZDaQN5XgyjmlCE6TuYH1Lkwd2bFvfLhhCkJDjnTivxrt
        nOdUsJCTBmgM6nXZttub3Op/+son0S9DYHOlrl3CWHeq/kkAEU45Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C16A12DA46;
        Wed, 13 Apr 2022 20:22:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D2A212DA45;
        Wed, 13 Apr 2022 20:22:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.35.3 and below as a usability fix
References: <xmqqv8veb5i6.fsf@gitster.g>
Date:   Wed, 13 Apr 2022 17:22:05 -0700
In-Reply-To: <xmqqv8veb5i6.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        12 Apr 2022 10:01:21 -0700")
Message-ID: <xmqq1qy04iqa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA639F30-BB88-11EC-BAF0-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance releases Git v2.35.3, together with releases
for older maintenance tracks v2.30.4, v2.31.3, v2.32.2, v2.33.3,
and v2.34.3, are now available at the usual places.

These maintenance releases are to address usability issues in the
recent releases 'v2.35.2', 'v2.34.2', 'v2.33.2', 'v2.32.1',
'v2.31.2', and 'v2.30.3', where each "safe" directory has to be
listed on the safe.directory configuration variables.  A broader
escape hatch has been added so that the value '*' can be used to
declare "my colleagues and their repositories I may ever visit are
all trustworthy".

The same fix appears in the tip of 'master' and all the integration
branches of the project above 'master', too.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the tags
mentioned above in the first paragraph.

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = https://github.com/gitster/git


Credit for the usability fix goes to Derrick Stolee.


