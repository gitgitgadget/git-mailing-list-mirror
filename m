Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AA9D1F42D
	for <e@80x24.org>; Wed, 23 May 2018 22:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935009AbeEWWyc (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 18:54:32 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:34133 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934895AbeEWWyb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 18:54:31 -0400
Received: from 79-74-250-18.dynamic.dsl.as9105.com ([79.74.250.18] helo=localhost.localdomain)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fLceK-0003md-G3; Wed, 23 May 2018 23:54:28 +0100
From:   Pedro Alvarez <pedro.alvarez@codethink.co.uk>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Pedro Alvarez Piedehierro <palvarez89@gmail.com>
Subject: [PATCH v2 0/1] import-tars: read overlong names from pax extended header
Date:   Wed, 23 May 2018 23:54:16 +0100
Message-Id: <20180523225417.10165-1-pedro.alvarez@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180522100548.29881-1-pedro.alvarez@codethink.co.uk>
References: <20180522100548.29881-1-pedro.alvarez@codethink.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pedro Alvarez Piedehierro <palvarez89@gmail.com>

Hello!

In this version I've trimmed and improved the commit message as suggested.

Regarding the error handling, as Jeff mentioned, could be improved
in general in the entire script. But I guess I could do it if needed
to get this patch approved.

Thanks for reviewing and giving me some feedback!

Pedro.

Pedro Alvarez Piedehierro (1):
  import-tars: read overlong names from pax extended header

 contrib/fast-import/import-tars.perl | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

-- 
2.11.0

