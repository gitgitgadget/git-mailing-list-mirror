Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 277A91F403
	for <e@80x24.org>; Wed, 13 Jun 2018 03:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754328AbeFMDKn (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 23:10:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52535 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754263AbeFMDKn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 23:10:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3FE8FD38D;
        Tue, 12 Jun 2018 23:10:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=wvhg
        g80CC8hA37TBZb9t3fEIJfA=; b=HNXs7KQEDj2Bqik7j+eqT6g6qIej2D4+4gzp
        yGKuEjtKde88vwf7l/7xWp/HIR1Tpz7EyIVHzwxWLrWqmwXLIDgkKipSURXHIH0r
        l0jpTxdnjETqPhVK7AS5xicQ7QevQUjj4OhVZCqa83XtyDPvFyd0gDPfVZfzs+rs
        jQ8su9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        fvxTW/ZTJHLTPiA/QeTLaIcHF/WEjOvnMHqL8O52XcayY8gFancJDgNjSjxM70/F
        dEniEXc26PjhQ6QaUB2VAsbxl1dnGSM8Vk1olsD25G7Jd46DJXyeffWpm9VD2F5W
        ozKyvYZtvL44rdeKlofsM2gj/K+NuIc1YwZ08NoX818=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AC766FD38C;
        Tue, 12 Jun 2018 23:10:42 -0400 (EDT)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.85.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D734FFD38A;
        Tue, 12 Jun 2018 23:10:41 -0400 (EDT)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Luis Marsano <luis.marsano@gmail.com>,
        Ted Zlatanov <tzz@lifelogs.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 0/4] contrib/credential/netrc Makefile & test improvements
Date:   Tue, 12 Jun 2018 23:10:35 -0400
Message-Id: <20180613031040.3109-1-tmz@pobox.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607051958.759-1-tmz@pobox.com>
References: <20180607051958.759-1-tmz@pobox.com>
X-Pobox-Relay-ID: 5B11BDC0-6EB7-11E8-B42E-44CE1968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This replaces my 2/2 "use in-tree Git.pm for tests" with
Luis's improved version.  It also adds Luis's fix to ensure
the proper exit status on test failures and a minor
whitespace cleanup.

Is it alright to forge your signoff Luis?

Luis Marsano (2):
  git-credential-netrc: use in-tree Git.pm for tests
  git-credential-netrc: fix exit status when tests fail

Todd Zullinger (2):
  git-credential-netrc: make "all" default target of Makefile
  git-credential-netrc: minor whitespace cleanup in test script

 contrib/credential/netrc/Makefile                  | 3 +++
 contrib/credential/netrc/t-git-credential-netrc.sh | 9 +++++----
 contrib/credential/netrc/test.pl                   | 5 +++--
 3 files changed, 11 insertions(+), 6 deletions(-)
