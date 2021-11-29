Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B59AC433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 20:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbhK2UiC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 15:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbhK2UgB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 15:36:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BC0C08EB53;
        Mon, 29 Nov 2021 09:10:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37427615D7;
        Mon, 29 Nov 2021 17:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F149C53FC7;
        Mon, 29 Nov 2021 17:10:06 +0000 (UTC)
Date:   Mon, 29 Nov 2021 12:10:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        workflows@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, git@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH v1 1/1] docs: add the new commit-msg tags
 'Reported:' and 'Reviewed:'
Message-ID: <20211129121004.64cf125f@gandalf.local.home>
In-Reply-To: <87mtlnjhj6.fsf@intel.com>
References: <cover.1637566224.git.linux@leemhuis.info>
        <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
        <20211123185237.M476855@dcvr>
        <12cefa81-495b-3083-5f19-b319c704ebf7@leemhuis.info>
        <20211126171141.GA21826@dcvr>
        <42ff6b8d-0b7c-12e0-4648-a9232b0f577c@leemhuis.info>
        <20211127195231.GA4636@dcvr>
        <xmqqtufx5p19.fsf@gitster.g>
        <87mtlnjhj6.fsf@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 29 Nov 2021 14:03:09 +0200
Jani Nikula <jani.nikula@intel.com> wrote:

> >From the RFC nitpicking department, msg-id is allowed to contain CFWS  
> (comments and folding white space) outside the angle brackets, which
> means you could have RFC compliant Message-ID header field:
> 
> Message-ID: 
>   <message-id@example.com>

My scripts have already been hit by this. (I've been lazy and not fixed it,
but instead, just edit the file that it is parsing manually, to be on one
line :-p)

-- Steve
