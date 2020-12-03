Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9CBC433C1
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 13:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3173220798
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 13:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387691AbgLCN7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 08:59:38 -0500
Received: from mail.javad.com ([54.86.164.124]:55930 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgLCN7i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 08:59:38 -0500
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Dec 2020 08:59:37 EST
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 2E5073E8F6;
        Thu,  3 Dec 2020 13:51:07 +0000 (UTC)
Received: from osv by osv with local (Exim 4.92)
        (envelope-from <sorganov@gmail.com>)
        id 1kkp0j-0003v2-Lm; Thu, 03 Dec 2020 16:51:05 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] glossary: improve "branch" definition
References: <87blfnhm8w.fsf@osv.gnss.ru>
        <xmqq7dqbn1nl.fsf@gitster.c.googlers.com> <87im9vekzf.fsf@osv.gnss.ru>
        <xmqqr1ojlkng.fsf@gitster.c.googlers.com> <877dq05swb.fsf@osv.gnss.ru>
        <xmqq5z5jlsw3.fsf@gitster.c.googlers.com>
Date:   Thu, 03 Dec 2020 16:51:05 +0300
In-Reply-To: <xmqq5z5jlsw3.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 02 Dec 2020 14:55:56 -0800")
Message-ID: <87ft4nhuba.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> So, what do we finally do? Just remove "active", or replace it with
>> "separate"?
>> ...
>> It's fine with me either way. Will you just fix it yourself, or should I
>> re-roll if "separate" is not accepted?
>
> Let's see ... gitster goes and looks for what he suggested ...
>
>     So, I dunno.  I'd say just settling on the simplest "is a line of
>     development" would be the easiest path for now.
>
> I've queued the following.

Nice, thanks!

-- Sergey

>
> Thanks for pinging a stalled thread.
>
> --- >8 ------ >8 ------ >8 ------ >8 ------ >8 ------ >8 ------ >8 ---
> From: Sergey Organov <sorganov@gmail.com>
> Date: Mon, 23 Nov 2020 23:05:51 +0300
> Subject: [PATCH] glossary: improve "branch" definition
>
> The old phrasing is at least questionable, if not wrong, as there are
> a lot of branches out there that didn't see active development for
> years, yet they are still branches, ready to become active again any
> time.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
> Notes (amlog):
>     Message-Id: <87blfnhm8w.fsf@osv.gnss.ru>
>
>  Documentation/glossary-content.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index 090c888335..67c7a50b96 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -18,7 +18,7 @@
>  	Untyped <<def_object,object>>, e.g. the contents of a file.
>  
>  [[def_branch]]branch::
> -	A "branch" is an active line of development.  The most recent
> +	A "branch" is a line of development.  The most recent
>  	<<def_commit,commit>> on a branch is referred to as the tip of
>  	that branch.  The tip of the branch is referenced by a branch
>  	<<def_head,head>>, which moves forward as additional development
