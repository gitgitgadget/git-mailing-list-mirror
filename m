Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B1D91F597
	for <e@80x24.org>; Sun,  5 Aug 2018 13:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbeHEPH7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 11:07:59 -0400
Received: from codesynthesis.com ([142.44.161.217]:43682 "EHLO
        codesynthesis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeHEPH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 11:07:58 -0400
Received: from [10.5.0.1] (unknown [178.219.147.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by codesynthesis.com (Postfix) with ESMTPSA id C0C885E6F1;
        Sun,  5 Aug 2018 12:55:17 +0000 (UTC)
From:   Karen Arutyunov <karen@codesynthesis.com>
Subject: git worktree add verbosity
Organization: Code Synthesis
To:     git@vger.kernel.org
Message-ID: <02659385-334f-2b77-c9a8-ffea8e461b0b@codesynthesis.com>
Date:   Sun, 5 Aug 2018 15:55:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

We are using git for automation in our build2 project.

What's quite inconvenient is that the 'git worktree add' command prints 
some output by default and there is no way to suppress it, as it 
normally can be achieved with the --quiet option for the most of git 
commands.

Could you add support for the --quiet option for the worktree command?

Best regards,
Karen
