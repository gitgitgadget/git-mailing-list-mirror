Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCBEB203C2
	for <e@80x24.org>; Fri, 15 Jul 2016 20:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbcGOUah (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 16:30:37 -0400
Received: from atl4mhib21.registeredsite.com ([209.17.115.115]:33631 "EHLO
	atl4mhob21.registeredsite.com" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751805AbcGOUah convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 16:30:37 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.209])
	by atl4mhob21.registeredsite.com (8.14.4/8.14.4) with ESMTP id u6FKUTQw007663
	for <git@vger.kernel.org>; Fri, 15 Jul 2016 16:30:29 -0400
Received: (qmail 24571 invoked by uid 0); 15 Jul 2016 20:30:29 -0000
X-TCPREMOTEIP: 23.28.40.196
X-Authenticated-UID: andrew@kellerfarm.com
Received: from unknown (HELO ?192.168.0.195?) (andrew@kellerfarm.com@23.28.40.196)
  by 0 with ESMTPA; 15 Jul 2016 20:30:29 -0000
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: obsolete index in wt_status_print after pre-commit hook runs
From:	Andrew Keller <andrew@kellerfarm.com>
In-Reply-To: <5988D847-25A2-4997-9601-083772689879@covenanteyes.com>
Date:	Fri, 15 Jul 2016 16:30:28 -0400
Cc:	Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <2ED67396-2530-4D1C-8F21-1C30983DB9DC@kellerfarm.com>
References: <5988D847-25A2-4997-9601-083772689879@covenanteyes.com>
To:	Git List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.2104)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 15.07.2016 um 12:34 nachm. schrieb Andrew Keller <andrew@kellerfarm.com>:

> I pulled out the source for version 2.9.1 and briefly skimmed how run_commit and
> prepare_to_commit work.  It seems that Git already understands that a pre-commit
> hook can change the index, and it rereads the index before running the
> prepare-commit-msg hook: https://github.com/git/git/blob/v2.9.1/builtin/commit.c#L941-L951

Quick question: Why does Git reread the index after the pre-commit hook runs?

Thanks,
 - Andrew Keller

