Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3164C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 17:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343597AbiHRRbW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 13:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbiHRRbV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 13:31:21 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E97B603E
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 10:31:21 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B5B341BF003;
        Thu, 18 Aug 2022 13:31:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mBq4X3MgQpYaMImBXX44pe2lBv0iRGuezbCCbQ
        t5v0w=; b=O7f/kA+khtEh21hRtEgTYnBAXOTLzXz31CM5N067bW/6bRx4vUMjcP
        JLzlAquQBmb+JPm0DdO9iOLBpJSDW1p5uaa/pddiZyL2/BsSgvIT/NZvQrwav6Sa
        A4bXCoeP4wydBp7rDwf8DJ40Vj3WBBU4KMTtU3j2lPb1QBvS9fbIE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ACB7C1BF002;
        Thu, 18 Aug 2022 13:31:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 445981BEFFD;
        Thu, 18 Aug 2022 13:31:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sergio via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sergei Krivonos <sergeikrivonos@gmail.com>
Subject: Re: [PATCH 2/2] Add Eclipse project settings files to .gitignore
References: <pull.1307.git.git.1660831231.gitgitgadget@gmail.com>
        <106a0563cfc29b75dbdbd54ce55140762e133539.1660831231.git.gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 10:31:16 -0700
In-Reply-To: <106a0563cfc29b75dbdbd54ce55140762e133539.1660831231.git.gitgitgadget@gmail.com>
        (Sergio via GitGitGadget's message of "Thu, 18 Aug 2022 14:00:31
        +0000")
Message-ID: <xmqqr11dpifv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90D7125C-1F1B-11ED-BB73-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sergio via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sergio <sergeikrivonos@gmail.com>
>
> Signed-off-by: Sergio <sergeikrivonos@gmail.com>
> ---
>  .gitignore | 2 ++
>  1 file changed, 2 insertions(+)

Your interest in the git project is appreciated, but we try to keep
our .gitignore to the common build artifacts.  Things that are
created for those who share a certaion personal preference, like
editor backup files, are best listed in .git/info/exclude (or
$HOME/.gitignore).  I am an Emacs user but *~ is not in .gitignore
in the project, for example.

Thanks.


