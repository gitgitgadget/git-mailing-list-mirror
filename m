Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A859C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 08:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiLPImh convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 16 Dec 2022 03:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiLPImc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 03:42:32 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6759537FBA
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 00:42:31 -0800 (PST)
Received: from Mazikeen ([15.181.16.145])
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 2BG8gPp8057673
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 16 Dec 2022 03:42:27 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Nemmaier, Christoph'" <christoph.nemmaier@cpp.canon>,
        <git@vger.kernel.org>
References: <AM8P195MB0820A54FEA04231D440F74D780E69@AM8P195MB0820.EURP195.PROD.OUTLOOK.COM>
In-Reply-To: <AM8P195MB0820A54FEA04231D440F74D780E69@AM8P195MB0820.EURP195.PROD.OUTLOOK.COM>
Subject: RE: PROBLEM: "git pull -v" fails with exit code denoting a submodule syntax error
Date:   Fri, 16 Dec 2022 03:42:19 -0500
Organization: Nexbridge Inc.
Message-ID: <000b01d9112a$541c4de0$fc54e9a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKA00gnj0PRGFmvn6C71jr6pUa0V60grVug
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 16, 2022 3:28 AM, Nemmaier, Christoph wrote:
>I expected "git pull -v" to simply work and exit correctly without telling me the
>syntax of "git submodule".
>
>What happened instead? (Actual behavior)
>
>This:
>> From gitlab.ops.oce.net:nemmaiec/cpposa
>> = [up to date]      develop/1.0 -> origin/develop/1.0
>> Already up to date.
>> usage: git submodule [--quiet] [--cached]
>>    or: git submodule [--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--
>reference <repository>] [--] <repository> [<path>]
>>    or: git submodule [--quiet] status [--cached] [--recursive] [--] [<path>...]
>>    or: git submodule [--quiet] init [--] [<path>...]
>>    or: git submodule [--quiet] deinit [-f|--force] (--all| [--] <path>...)
>>    or: git submodule [--quiet] update [--init [--filter=<filter-spec>]] [--remote] [-
>N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-
>shallow] [--reference <repository>] [--recursive] [--[no-]single-branch] [--]
>[<path>...]
>>    or: git submodule [--quiet] set-branch (--default|--branch <branch>) [--]
><path>
>>    or: git submodule [--quiet] set-url [--] <path> <newurl>
>>    or: git submodule [--quiet] summary [--cached|--files] [--summary-limit <n>]
>[commit] [--] [<path>...]
>>    or: git submodule [--quiet] foreach [--recursive] <command>
>>    or: git submodule [--quiet] sync [--recursive] [--] [<path>...]
>>    or: git submodule [--quiet] absorbgitdirs [--] [<path>...]
>
>What's different between what you expected and what actually happened?
>
>The text I quoted above, and an exit with error code.
>
>Anything else you want to add:
>
>The '-v' parameter is used by TortoiseGit and GitExtensions, which now both croak
>on pulling.

Hi Christoph,

I have gone back to git 2.36.0 and cannot find support for the -v submodule command parameter. At what version did this last work for you? Do you have a git alias in effect that might be adding -v?
--Randall

