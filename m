Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EBBC433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 19:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDF4B20792
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 19:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xIae3i28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgFKTmA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 15:42:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63899 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgFKTl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 15:41:59 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC77775288;
        Thu, 11 Jun 2020 15:41:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zS3WJ+9YF8oyv+71iJ8nnjtLSuw=; b=xIae3i
        28HSPcJpVNw16kVHQDUl3+cKNIsj7kG+9bcU6BurAsxkbK51LfbhyxmMS2IYQeCW
        3t0z6ZKuXGRYNQyoMa7MzbSk/601nIM1h6ZQgPip6hCNV/UoCXaB88YkJVytCh/J
        xWvtAf30zTMqq0SiOtItUpc/Fx+HgNqJTzAAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Vy1bv1mkwG+qNjDP2nTnTg8oGsYgbvYK
        jEwgmkXEKRYEIV3i7MsougoLPFwkm3qz1ohBpz8xCgZESWcMyKAVDixVGdHuA2ZY
        8uJ9ttiDmjuh0v3ZVp86y9x6qUQFgl0eCvUqBki1nXyQO7lv6LPZVBAb1RYyNT8u
        WSd4p66o0Tw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3DA175287;
        Thu, 11 Jun 2020 15:41:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3159975286;
        Thu, 11 Jun 2020 15:41:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] GIT-VERSION-GEN: update for the post 2.27 cycle
References: <4946cf3650b95191455630f85f59e5f93156d0ac.1591883410.git.liu.denton@gmail.com>
Date:   Thu, 11 Jun 2020 12:41:56 -0700
In-Reply-To: <4946cf3650b95191455630f85f59e5f93156d0ac.1591883410.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 11 Jun 2020 09:50:20 -0400")
Message-ID: <xmqq8sgtjsor.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C27E318-AC1B-11EA-BAE1-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  GIT-VERSION-GEN | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index 06a5333ee6..7b0cfeb92e 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  
>  GVF=GIT-VERSION-FILE
> -DEF_VER=v2.27.0
> +DEF_VER=v2.27.GIT

I have been thinking about stopping this transition from ".0" to
".GIT" and left it at ".0" deliberately.

 - The target to create a tarball ("make dist") places the "version"
   file that overrides whatever value is set here, so those who
   build from a tarball will not care what the value described here
   is.

 - Those who build from a repository would use "git describe".

 - In addition, I do not create tarballs and upload to public places
   for a random version with .GIT suffix---I only do so for -rcX and
   the releases.  If anybody else is doing so with "make dist",
   there would be the "version" file included in the tarball,
   recording what is obtained from "git describe HEAD".

So there is no strong reason to care what this value is, and that
was why I was experimenting with the idea of leaving it at ".0",
in the hope of hearing from people who do want to see ".GIT" why
they want it.

Unfortunately, your patch does not say why, either, so it hasn't
quite helped yet ;-)



