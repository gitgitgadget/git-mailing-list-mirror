Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4845020970
	for <e@80x24.org>; Tue, 11 Apr 2017 22:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbdDKWrR (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 18:47:17 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35006 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbdDKWrR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 18:47:17 -0400
Received: by mail-pg0-f65.google.com with SMTP id g2so1911897pge.2
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 15:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O7ttO+pZzeT8+xj5m88ZFI/v7ebEnK+WkLOm5foRDUs=;
        b=vPmft5ypNR5ugx/2llHDSqXtLQvQC6EPRbakuUAdMwKPP53eYmdQ8bPJlCZC3rsF0E
         rSDBbOc/WRxOMc6ArL00stUx8LijEU3P/JdZ6om/wx7RnFHc2Zco2/9e2z+R4ZkBqOtS
         MgUyN37PI7LRqLukmYtnN0FvfPugxpR7rjGZ/h/TzmJKiF8yaSlHhHgplklOStbtsI4g
         8O2etqamHRsg3yj3xBfJN1OcaN3PDcLacJgetxk3W4NeLSACuAlWWD23PTzOr7nbghCX
         KarIl3VZIlldBiElm0ylRjWSi4Ooe1AFoRz5yLXCMoCK9ETJvBtTNyURGiyVC7JsFp6P
         gCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O7ttO+pZzeT8+xj5m88ZFI/v7ebEnK+WkLOm5foRDUs=;
        b=iLaTt5T8juxrVm58vA7/WLoYAsGoOiymIIRqagRZxR6+37qGjb9HL2UTCd6Kb2NzSZ
         ksMIK/OX/K5qNGA+AAPvRGNXTX4b/HtAtiTawQ4riCcy6nhODk5QxSK2/U/SQAC2RB7T
         kJI5gWENoKA5vygfpAtKacRjqQb2g4WoLyA6qPnW3oTrGDH7m2hjpSqf43qxWG99jTHG
         Ktm6GK5Jlkw/qzMSJqkshq0kc6Ys/qO+4BcRYkEN245K+8lFlifjaGKc4BQUhUGwM3ah
         4sAU1GjvkkJuniipGzNbNC5VbWYu1pp9Cn2Qzv+mwzB4CHyOJN1MzdB8ybpSwaO47I7k
         BmqA==
X-Gm-Message-State: AFeK/H0vPHexzGOontJhnpxJUP0TkNy020MKC5ARYmSrThIg+Xjpt19pWCKxhlrGlHU1LA==
X-Received: by 10.84.208.102 with SMTP id f35mr80197151plh.19.1491950836307;
        Tue, 11 Apr 2017 15:47:16 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:c434:5e79:6b7e:ed6b])
        by smtp.gmail.com with ESMTPSA id y29sm16073708pfj.90.2017.04.11.15.47.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 15:47:15 -0700 (PDT)
Date:   Tue, 11 Apr 2017 15:47:13 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2017, #01; Tue, 11)
Message-ID: <20170411224713.GS8741@aiede.mtv.corp.google.com>
References: <xmqqh91vqquf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh91vqquf.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> * jk/no-looking-at-dotgit-outside-repo-final (2016-10-26) 1 commit
>   (merged to 'next' on 2017-02-27 at 7373a1b73d)
>  + setup_git_env: avoid blind fall-back to ".git"
>
>  This is the endgame of the topic to avoid blindly falling back to
>  ".git" when the setup sequence said we are _not_ in Git repository.
>  A corner case that happens to work right now may be broken by a
>  call to die("BUG").

There's one caller we missed, in "git apply" when you apply a binary
patch outside any repository.

The patch below fixes it but doesn't have tests.  I'll try to send
out a patch with tests later today.

It's probably also worth making the die("BUG") compile-time
configurable so distros have an easy way out if any similar bugs are
lurking undiscovered.

Thanks,
Jonathan

-- >8 --
Subject: has_sha1_file: don't bother if we are not in a repository

Most callers to this function already require that they are in a
git repository, but there is an exception: "git apply" uses
has_sha1_file to avoid work if the result of applying a binary
patch is already present in the repository. When run outside any
repository, this produces an error:

 fatal: BUG: setup_git_env called without repository

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/sha1_file.c b/sha1_file.c
index 71063890ff..bf1ff2ef77 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3481,6 +3481,8 @@ int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
 {
 	struct pack_entry e;
 
+	if (!startup_info->have_repository)
+		return 0;
 	if (find_pack_entry(sha1, &e))
 		return 1;
 	if (has_loose_object(sha1))
