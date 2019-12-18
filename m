Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41C4C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 22:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C502920717
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 22:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfLRWpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 17:45:05 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:25022 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfLRWpF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 17:45:05 -0500
Received: from [92.30.123.115] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ihi3z-0006Xp-58; Wed, 18 Dec 2019 22:45:03 +0000
Subject: Re: [PATCH 1/1] config: allow user to know scope of config options
To:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Matthew Rogers <mattr94@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.478.git.1576631464.gitgitgadget@gmail.com>
 <ec699bb3e64c74e6e87a20bbb5efac12a13cb077.1576631464.git.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <9a91caa0-72c3-3a38-3eb7-55a43537762e@iee.email>
Date:   Wed, 18 Dec 2019 22:45:04 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <ec699bb3e64c74e6e87a20bbb5efac12a13cb077.1576631464.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matthew,

On 18/12/2019 01:11, Matthew Rogers via GitGitGadget wrote:
> From: Matthew Rogers <mattr94@gmail.com>
>
> Add new option --show-scope which allows a user to know what the scope
> of listed config options are (local/global/system/etc.).
>
> Signed-off-by: Matthew Rogers <mattr94@gmail.com>
> ---
>  builtin/config.c  | 60 ++++++++++++++++++++++++++++++++++++++++-------
>  t/t1300-config.sh | 51 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 103 insertions(+), 8 deletions(-)

Doesn't this also need a man page update as well for adding the option
to the synopsis.

The commit message doesn't fully highlight that the config list will
often be all the users config values, so each value will be
disambiguated/identified as to it's origin.

Philip
