Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7A701F453
	for <e@80x24.org>; Mon, 24 Sep 2018 22:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbeIYEhQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 00:37:16 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:18992 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeIYEhP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 00:37:15 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Sep 2018 00:37:15 EDT
Received: from localhost.localdomain ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id 4ZHUgIql1oI6L4ZHUgLKqU; Mon, 24 Sep 2018 23:24:41 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=x_Pg9YQSPusYyZ0-0B8A:9
From:   Philip Oakley <philipoakley@iee.org>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Philip Oakley <philipoakley@iee.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        stas@stason.org
Subject: [PATCH 0/1] Re: git silently ignores include directive with single quotes
Date:   Mon, 24 Sep 2018 23:24:15 +0100
Message-Id: <20180924222416.5240-1-philipoakley@iee.org>
X-Mailer: git-send-email 2.19.0.windows.1
In-Reply-To: <29173fd8-ce72-0927-9bfe-786442dfd82c@stason.org>
References: <29173fd8-ce72-0927-9bfe-786442dfd82c@stason.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPx+X0h9CbkLhEPVIuHMdVnPQMXPn8CXHkcptULSBvg+RzReGxRipu+osFYsqVC2Pn9LxxUBFe/IcCMolUlWFZscibK07EBoSInAEYf9vrTw/f1JYdGK
 2V2EsHx/ELERU2o3mQlFxi8Te0dHklJXBALS3aoVX1k396pARJrlPGPYuybYR1xZoqXNtXCBBPCNj8yNHAZJcZPmWzPOOlh965BOxlXxAfgJDeIqZSlCLzoz
 xUYlS6ZNu4tFUOX5ogWpHQJ3oTOIxFp1j6HjdMBWAsWWobtmwnmFh47aimQQOCwP4V4Blhy3PVrhfby7RI8U2/peQBhjh+EyewZyCjjYA5fkxGGY9mNcCMeJ
 5GEUSgLq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than attaching the problem with code, I decided to simply update
the config file documentation.

As the userbase expands the documentation will need to be more comprehensive
about exclusions and omissions, along with better highlighting for core
areas.

I would be useful if Stas could comment on whether these changes would
have assisted in debugging the faulty config file. 

Philip Oakley (1):
  config doc: highlight the name=value syntax

 Documentation/config.txt | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

-- 
2.17.1.windows.2

