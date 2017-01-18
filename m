Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB90E20A17
	for <e@80x24.org>; Wed, 18 Jan 2017 10:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751918AbdARKr5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 05:47:57 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:49482 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbdARKr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 05:47:56 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id DF95724E0173;
        Wed, 18 Jan 2017 02:40:54 -0800 (PST)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
        by mailhost.synopsys.com (Postfix) with ESMTP id C8C50811;
        Wed, 18 Jan 2017 02:40:54 -0800 (PST)
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id BE57E80A;
        Wed, 18 Jan 2017 02:40:54 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Wed, 18 Jan 2017 02:40:54 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Wed, 18 Jan 2017 11:40:53 +0100
Received: from [10.107.19.116] (10.107.19.116) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.266.1; Wed, 18 Jan 2017 11:40:53 +0100
To:     <git@vger.kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        "CARLOS.PALMINHA@synopsys.com" <CARLOS.PALMINHA@synopsys.com>
From:   Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Git: new feature suggestion
Message-ID: <4817eb00-6efc-e3c0-53d7-46f2509350d3@synopsys.com>
Date:   Wed, 18 Jan 2017 10:40:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.107.19.116]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

My name is Joao Pinto, I work at Synopsys and I am a frequent Linux Kernel
contributor.

Let me start by congratulate you for the fantastic work you have been doing with
Git which is an excellent tool.

The Linux Kernel as all systems needs to be improved and re-organized to be
better prepared for future development and sometimes we need to change
folder/files names or even move things around.
I have seen a lot of Linux developers avoid this re-organization operations
because they would lose the renamed file history, because a new log is created
for the new file, even if it is a renamed version of itself.
I am sending you this e-mail to suggest the creation of a new feature in Git:
when renamed, a file or folder should inherit his parent’s log and a “rename: …”
would be automatically created or have some kind of pointer to its “old” form to
make history analysis easier.

I volunteer to help in the new feature if you find it useful. I think it would
improve log history analysis and would enable developers to better organize old
code.

Thank you for your attention.

Best Regards,
Joao Pinto
