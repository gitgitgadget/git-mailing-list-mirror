Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42BA32095E
	for <e@80x24.org>; Sat, 25 Mar 2017 13:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbdCYNGA (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 09:06:00 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33815 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdCYNGA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 09:06:00 -0400
Received: by mail-pg0-f52.google.com with SMTP id 21so7954408pgg.1
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 06:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Fw8NlCjLUVZXLFcE2Dmo0mQHoSpzu2dg7J1QERtJ7gE=;
        b=fl2T1p7CpwOU0H5p3+Z6kT6HhZCFWWIe8LUeu9ledFxym1IM+eD3SwVbZIKB1YJtES
         HLLqvGdtrC5Cb/p3eqXGTiWPDxJ4LDUm0zH5Y/A0TXpsKkLZlWXrvyGfZhFhkhAOkFys
         BB24DRX/LkqVQ8CHQxLHIjbTyvsC14fpps2QE9o/EmDthOfQPLcezWTFvsRtx2TZSFx5
         qjNHpfHqJmnfTPHMjatWsTZDgqNdTBZCcN0qmHEFcuOLxxAKd/l86YCZDLoSj4CB5qV9
         c6ozOJDYp+7s2O7C62pCmI6LmUu6xBPIWkQsLdFS385cGdd3/+W086bbTCVaNXMgEHTt
         1JCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Fw8NlCjLUVZXLFcE2Dmo0mQHoSpzu2dg7J1QERtJ7gE=;
        b=gztxbSuo7aNROf2/2LcICIiy3eSj+IBlppkJfPyPYz/kvQXrakHwUXaMVgO7CDZyj+
         AkEKpkNKFaaw5Jl1A6Auy3cGpBKhXL5bLSwUHgdbvW1i2r7iwD8Fwt0dFlfw31dfmjze
         dyMKaRr5YSevPsVA6nHOZk37CpP1rTUdpRsimuI3eRoEDvlBhpkCbREW7lZnPNDhtqjN
         apYwviZiUk9yJQjXz3JuVynVDvIBTy8Z3CIiCizy96bURhtndnd78dCNobgnmcmsp9D3
         bXFcJajFGTmDUaI2XFN52UE/DBzWQ9xhK85U2XiA8I7UG7qFunmEhDXWaokaK8SgRQsg
         pkyQ==
X-Gm-Message-State: AFeK/H2WXumu/9P9vTWteNJ5BJ1Qz3yITOs3oaB3dvtAQznUvfa5nj+7bMT0n9zT0CZ7sQ==
X-Received: by 10.99.126.76 with SMTP id o12mr14413547pgn.1.1490447158545;
        Sat, 25 Mar 2017 06:05:58 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id c19sm10644322pfd.85.2017.03.25.06.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 06:05:57 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 25 Mar 2017 20:05:50 +0700
Date:   Sat, 25 Mar 2017 20:05:50 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: t1503 broken ?
Message-ID: <20170325130549.GA20618@ash>
References: <fad6ea92-0a44-de30-48e8-09e7c567cd4d@web.de>
 <CACsJy8B1DWL9uHPZoQEO+ytkt1M+qV-x0F5CWFLFSG1utxO9EQ@mail.gmail.com>
 <CACsJy8CZdZuxpwbfB+TgHdH9YneeUxUhkF7XuLhWw6Lp9ZLPDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8CZdZuxpwbfB+TgHdH9YneeUxUhkF7XuLhWw6Lp9ZLPDQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2017 at 07:26:14PM +0700, Duy Nguyen wrote:
> On Sat, Mar 25, 2017 at 6:46 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Sat, Mar 25, 2017 at 5:46 PM, Torsten Bögershausen <tboegi@web.de> wrote:
> >> ./t1305-config-include.sh
> >> seems to be broken:
> >> not ok 19 - conditional include, $HOME expansion
> >> not ok 21 - conditional include, relative path
> >
> > let me guess, your "git" directory is in a symlink path?
> 
> Yes I could reproduce it when I put my "git" in a symlink. There's a
> note in document about "Symlinks in `$GIT_DIR` are not resolved before
> matching" but failing tests is not acceptable. I'll fix it.

The fix may be something like this. The problem is $GIT_DIR has symlinks
resolved, but we don't do the same for other paths in this code. As a
result, matching paths fails.

I'm a bit concerned about the change in expand_user_path() because I'm
not quite sure if it's a completely safe change. But at least could
you try the patch and see if it passe the tests on your machine too?

-- 8< --
diff --git a/config.c b/config.c
index 1a4d855..fc4eae9 100644
--- a/config.c
+++ b/config.c
@@ -191,7 +191,7 @@ static int prepare_include_condition_pattern(struct strbuf *pat)
 			return error(_("relative config include "
 				       "conditionals must come from files"));
 
-		strbuf_add_absolute_path(&path, cf->path);
+		strbuf_realpath(&path, cf->path, 1);
 		slash = find_last_dir_sep(path.buf);
 		if (!slash)
 			die("BUG: how is this possible?");
@@ -213,7 +213,7 @@ static int include_by_gitdir(const char *cond, size_t cond_len, int icase)
 	struct strbuf pattern = STRBUF_INIT;
 	int ret = 0, prefix;
 
-	strbuf_add_absolute_path(&text, get_git_dir());
+	strbuf_realpath(&text, get_git_dir(), 1);
 	strbuf_add(&pattern, cond, cond_len);
 	prefix = prepare_include_condition_pattern(&pattern);
 
diff --git a/path.c b/path.c
index 2224843..18eaac3 100644
--- a/path.c
+++ b/path.c
@@ -654,7 +654,7 @@ char *expand_user_path(const char *path)
 			const char *home = getenv("HOME");
 			if (!home)
 				goto return_null;
-			strbuf_addstr(&user_path, home);
+			strbuf_addstr(&user_path, real_path(home));
 #ifdef GIT_WINDOWS_NATIVE
 			convert_slashes(user_path.buf);
 #endif
-- 8< --
-- 
Duy
