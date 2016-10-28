Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B73822035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942531AbcJ1Sqi (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:46:38 -0400
Received: from dmz-mailsec-scanner-7.mit.edu ([18.7.68.36]:60255 "EHLO
        dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S942303AbcJ1Spq (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Oct 2016 14:45:46 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Oct 2016 14:45:45 EDT
X-AuditID: 12074424-64bff70000000af3-5f-58139babc84b
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by  (Symantec Messaging Gateway) with SMTP id CE.DC.02803.BAB93185; Fri, 28 Oct 2016 14:40:44 -0400 (EDT)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id u9SIeh0Q024698;
        Fri, 28 Oct 2016 14:40:43 -0400
Received: from localhost (buzzword-bingo.mit.edu [18.9.64.24])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id u9SIefkI009954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 28 Oct 2016 14:40:42 -0400
Date:   Fri, 28 Oct 2016 14:40:41 -0400 (EDT)
From:   Anders Kaseorg <andersk@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: [PATCH] pre-receive.sample: Mark executable
Message-ID: <alpine.DEB.2.10.1610281438000.60842@buzzword-bingo.mit.edu>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixCmqrLtmtnCEwc83HBZdV7qZLBp6rzA7
        MHlcvKTs8XmTXABTFJdNSmpOZllqkb5dAlfG9Bsd7AXNLBX3bixibmDczNzFyMkhIWAicW3J
        b5YuRi4OIYE2Jokz3z8zQTgbGSUeTXrGCOHsZpL4fWoTC0gLi4C2xKUZJ8FsNgE1iQ9Hv7KC
        2CJA9sS2Q2BxZgFxiU3L3wBN4uAQBlqx4ngoSJhXwEPi8fk9YCWiAroSh/79YYOIC0qcnPkE
        qlVLYvn0bSwTGHlnIUnNQpJawMi0ilE2JbdKNzcxM6c4NVm3ODkxLy+1SNdcLzezRC81pXQT
        IyiI2F1UdjB293gfYhTgYFTi4bWIEY4QYk0sK67MPcQoycGkJMqb3wwU4kvKT6nMSCzOiC8q
        zUktPsQowcGsJMIrMxEox5uSWFmVWpQPk5LmYFES52Vw/xouJJCeWJKanZpakFoEk5Xh4FCS
        4D08C6hRsCg1PbUiLTOnBCHNxMEJMpwHaLgXSA1vcUFibnFmOkT+FKMux7vN7x4wCbHk5eel
        SonzPpsJVCQAUpRRmgc3BxL9DhKvGMWB3hLmfQcyigeYOOAmvQJawgS0ZHq6AMiSkkSElFQD
        4/bPL/nVPoV6t61tVeYJeNtW9fbe/iVS1e6LU6qEL+q9S/msIarUrhj430dsW63G4nvpV7v+
        3J3471arRFrDd8eb/Ss9ZsVO3S59zDki//v7ZfNXP0pWkPbbVHm26f6KttJ6jjL2/8kNrrK7
        mm78zwnnSeJTkv2qxFWuGSRakPzh+bkP9lkBSizFGYmGWsxFxYkA/LdGP9kCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For consistency with other hooks, allow the hook to be activated by
renaming pre-receive.sample to pre-receive without a separate step to
mark it executable.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 templates/hooks--pre-receive.sample | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 templates/hooks--pre-receive.sample

diff --git a/templates/hooks--pre-receive.sample b/templates/hooks--pre-receive.sample
old mode 100644
new mode 100755
-- 
2.10.1

