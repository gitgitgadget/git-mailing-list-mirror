Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7D1C4338F
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 12:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DAE660EBD
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 12:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbhGaMbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 08:31:36 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:53098 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232692AbhGaMbg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 08:31:36 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1m9o9G-000198-Bo; Sat, 31 Jul 2021 13:31:27 +0100
Subject: Re: Ambigious messages (sparse checkout)
To:     Eugen Konkov <kes-kes@yandex.ru>,
        Git Mailing List <git@vger.kernel.org>
References: <644619140.20210731114616@yandex.ru>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <5b0e38b0-7060-239e-5adf-b751a67f6646@iee.email>
Date:   Sat, 31 Jul 2021 13:31:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <644619140.20210731114616@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Others may have mistaken this for spam - I nearly did.

On 31/07/2021 09:46, Eugen Konkov wrote:
> $ git checkout 51c7d41b82b5b
> error: Your local changes to the following files would be overwritten by checkout:
>        lib/Mojo/IOLoop/Stream.pm
> Please commit your changes or stash them before you switch branches.
> Aborting
> $ git checkout lib/Mojo/IOLoop/Stream.pm
> error: pathspec 'lib/Mojo/IOLoop/Stream.pm' did not match any file(s) known to git
>
> $ git add lib/Mojo/IOLoop/Stream.pm
> The following pathspecs didn't match any eligible path, but they do match index
> entries outside the current sparse checkout:

I strongly suspect it's a sparse checkout issue, given this message.

Others may be able to help better than I.

> lib/Mojo/IOLoop/Stream.pm
> hint: Disable or modify the sparsity rules if you intend to update such entries.
> hint: Disable this message with "git config advice.updateSparsePath false"
>
> $ git --version
> git version 2.32.0
>
> Here I do not understand how to checkout to different commit
> or how to commit the subject file
>
> It would be nice to show hint about how to exlude this file from unindex
>
>
> --
> Best regards,
> Eugen Konkov
>
--
Philip
