Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F33F1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 20:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbfH0UCS (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 16:02:18 -0400
Received: from elephants.elehost.com ([216.66.27.132]:31879 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbfH0UCS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 16:02:18 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x7RK2GKb093831
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 16:02:16 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: Question of intent: stash push --include-untracked
Date:   Tue, 27 Aug 2019 16:02:10 -0400
Message-ID: <019501d55d12$534b5ca0$f9e215e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdVdDYHrnTjodDI+RBKEjsx8u4qFsQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm a bit perplexed about what is intended follow a git stash push
--include-untracked. Suppose I have files a,b,c,known modified, but only
known is in the index. After the stash, stash show only displays known. A
subsequent pop will restore a,b,c. So functionally push and pop are fine,
but show appears to ignores files in the stash. The log shows a previous
commit (dce2e3e) to the WIP stash (ab0834c) that does contain the untracked
files, and git diff is happy to show the contents when using the ref
directly. It is just counterintuitive for stash show not to display all
entries previously pushed. I would have expected symmetry. Is this new, or
intended.

*-.   ab0834c (refs/stash) WIP on master: bf223fc Updated known
|\ \
| | * dce2e3e untracked files on master: bf223fc Updated known
| * a5ad1ef index on master: bf223fc Updated known
|/
* bf223fc (HEAD -> master) Updated known
* db0efd4 (origin/master, origin/HEAD) initial

This on git 2.23.0

Thanks,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



