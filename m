Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB645C433DF
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 10:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A61FB2082E
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 10:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgG3K4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 06:56:47 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:11166 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgG3K4r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 06:56:47 -0400
Received: from host-92-20-155-42.as13285.net ([92.20.155.42] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1k16Ev-0007cU-Ar; Thu, 30 Jul 2020 11:56:45 +0100
Subject: Re: [PATCH] git-help.txt: fix mentions of option --guides
To:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
References: <20200729133948.538-1-rybak.a.v@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <be61897d-5f06-7cc5-10bb-1168e26e408b@iee.email>
Date:   Thu, 30 Jul 2020 11:56:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729133948.538-1-rybak.a.v@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/07/2020 14:39, Andrei Rybak wrote:
> Fix typos introduced in commit a133737b80 ("doc: include --guide option
> description for "git help"", 2013-04-02).
>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>  Documentation/git-help.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
> index f71db0daa2..69c0c5c34e 100644
> --- a/Documentation/git-help.txt
> +++ b/Documentation/git-help.txt
> @@ -8,7 +8,7 @@ git-help - Display help information about Git
>  SYNOPSIS
>  --------
>  [verse]
> -'git help' [-a|--all [--[no-]verbose]] [-g|--guide]
> +'git help' [-a|--all [--[no-]verbose]] [-g|--guides]
>  	   [-i|--info|-m|--man|-w|--web] [COMMAND|GUIDE]
>  
>  DESCRIPTION
> @@ -21,7 +21,7 @@ on the standard output.
>  If the option `--all` or `-a` is given, all available commands are
>  printed on the standard output.
>  
> -If the option `--guide` or `-g` is given, a list of the useful
> +If the option `--guides` or `-g` is given, a list of the useful
>  Git guides is also printed on the standard output.
>  
>  If a command, or a guide, is given, a manual page for that command or
Looks like the error was all mine, all the way back to my a133737b80
(doc: include --guide option description for "git help", 2013-04-02)

The majority of that change referred to individual 'guide'(singular),
however the option to list them is in the plural. I didn't find any
other errorss (other than the referenced commit's subject;-) , but a
note as in this commit message about the singular/plural confusion may
be worth having if there is a re-roll.

Acked-by: Philip Oakley <philipoakley@iee.email>


