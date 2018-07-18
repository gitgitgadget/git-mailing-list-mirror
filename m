Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDF2B1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 17:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731554AbeGRS2X (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 14:28:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33470 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731417AbeGRS2X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 14:28:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so5531580wrp.0
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 10:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=9nd2IsylmDIQWgK6CcqDEe0nClMBkANWniKSLWgod9w=;
        b=MWwN2WSByobA/DrZ766qnEjU1y8vmt9SYB87N9l49qjv0v4QM6xvcvq/zBI2G99Bo1
         qYUvxVFnQd3JKRZk7DPSMNGMcdf1JdxQBPNiDgRVCC9sgxp53X3o9AZe3u+EIXSRYWyJ
         0r9uB9cyiTDIFXL+83JntUsULWZ2aC2PHCpjtupK7hDPNAiIWQHVf5mHZDzHf1mllQ/X
         phyaTYZojlqHrXE54wUYq/Pyl0emclekffq6a7quyTZ755pNYZmQKKaxLfYVSlOqAi6A
         +TQukXhagoSNja1USyash62LVnSngPz13X43xZTJf+P8SAXeSU8r52vJ4uUUkcPTQGZ6
         1wdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=9nd2IsylmDIQWgK6CcqDEe0nClMBkANWniKSLWgod9w=;
        b=Ea3dbNiKq7uMO3ttzTHpIb0dnL4WuQECy8WYxDwmJg6QnrLUVFYRWw7gW5oKmj2Stq
         TzT2Idu4EDx1Q+RYqO8h3Dos3i9ZRHm4CTQ5ph44idDTirT3DWEBcRIaHfND+0RJ6y/Q
         sz6c3K8SEUlfJWrm+NuieM2AfTswR4BDqqQZu2yoFu03qH4SjM2QXScnrBnh9uWUXoiJ
         x3AxjwWK4IiPFlW0zMXVR3jbraa6z9OXCjCM/IVxRA0b0qLIZiA24ZoaWnP31OiVW3TE
         7K31N077aSfQc853KGbcIIHm2e5RsMl8hAWYrOhqlghF3a1pN+xEDoXzvxLlUCUNTW2u
         dXKA==
X-Gm-Message-State: AOUpUlEL6v9PksrHgqfWGgilkD6fWFKTYRenzgP6asJSriXZ0YKvjpzk
        XWvJ4FNU6IRkoRBJTBJF6aA=
X-Google-Smtp-Source: AAOMgpdZQq7WiEMcQ4tlPvr5OtWg09FVsgaEilM3VL0VBB6TYNpq/a1NlinHQgb+molesud5UNc/NQ==
X-Received: by 2002:adf:8162:: with SMTP id 89-v6mr4983883wrm.192.1531936163629;
        Wed, 18 Jul 2018 10:49:23 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c13-v6sm2907451wrt.24.2018.07.18.10.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 10:49:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: sed: command garbled: rGIT-PERL-HEADER
References: <CAH8yC8nef0iPVLqnkcJ2fh=N8jCM=tK1DXJJe+nx8cOL8K9D6A@mail.gmail.com>
Date:   Wed, 18 Jul 2018 10:49:22 -0700
In-Reply-To: <CAH8yC8nef0iPVLqnkcJ2fh=N8jCM=tK1DXJJe+nx8cOL8K9D6A@mail.gmail.com>
        (Jeffrey Walton's message of "Wed, 18 Jul 2018 07:53:38 -0400")
Message-ID: <xmqqtvowjuxp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeffrey Walton <noloader@gmail.com> writes:

> I'm trying to build Git 2.18 on Solaris 11.3 x86_64.
>
> $ gmake V=1
> rm -f git-add--interactive git-add--interactive+ && \
> sed -e '1{' \
>     -e '        s|#!.*perl|#!/usr/bin/perl|' \
>     -e '        rGIT-PERL-HEADER' \
>     -e '        G' \
>     -e '}' \
>     -e 's/@@GIT_VERSION@@/2.18.0/g' \
>     git-add--interactive.perl >git-add--interactive+ && \
> chmod +x git-add--interactive+ && \
> mv git-add--interactive+ git-add--interactive
> sed: command garbled:   rGIT-PERL-HEADER
> gmake: *** [git-add--interactive] Error 2
>
> And:
>
> $ perl --version
>
> This is perl 5, version 12, subversion 5 (v5.12.5) built for i86pc-solaris-64int
> (with 7 registered patches, see perl -V for more detail)
>
> Any ideas how to fix it?

The fix is prepared to become part of the next feature release (and
also some maintenance release before that happens).  Please try the
attached patch.

Thanks.


-- >8 --

From: Alejandro R. Sedeño <asedeno@mit.edu>
Date: Mon, 25 Jun 2018 15:13:25 -0400
Subject: [PATCH] Makefile: tweak sed invocation

With GNU sed, the r command doesn't care if a space separates it and
the filename it reads from.

With SunOS sed, the space is required.

Signed-off-by: Alejandro R. Sedeño <asedeno@mit.edu>
Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 2ba24035f5..50138e85eb 100644
--- a/Makefile
+++ b/Makefile
@@ -2086,7 +2086,7 @@ $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1{' \
 	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
-	    -e '	rGIT-PERL-HEADER' \
+	    -e '	r GIT-PERL-HEADER' \
 	    -e '	G' \
 	    -e '}' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-- 
2.18.0-129-ge3331758f1


