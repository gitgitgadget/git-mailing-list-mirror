Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 609CF1F4DD
	for <e@80x24.org>; Fri,  1 Sep 2017 23:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbdIAXTh (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Sep 2017 19:19:37 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36555 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbdIAXTg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2017 19:19:36 -0400
Received: by mail-pg0-f66.google.com with SMTP id 83so924143pgb.3
        for <git@vger.kernel.org>; Fri, 01 Sep 2017 16:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=euIl5d4H28EJespOd2mwyE2IGK/U5fZXqVuwKfOqeZ4=;
        b=RPMgm5AuQejy3NcstOSuo1ULpd5bzQIlItHt/eu42pxe9mpKJ6MRdoNdDsDcABJ4tG
         uD7eIqex8Q2dXjYW6Ez2mUchUFSyZpmzimX+invijAd2DSz5PP2q/6zoO3WdMYN9Ikgw
         5D5FunPdIWNsk+JHEOlTuiNfwrkfBYqOKFUp8wSOzuKaVLWbyOkGZYuKQ5fgrj0KYgqg
         lA5WMMqY7MTaOP07QPNeMR+fhQ0oWXlxUlQ6dbCclEcS58NVSrXgdqU8+G4D/eWqxizj
         n9jEuPwqO8eDqToRX5pgVyXHO/z0wxQspWzM4sa8yDE2WuqvBF0GH2e8rFllpyd7aCrI
         LKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=euIl5d4H28EJespOd2mwyE2IGK/U5fZXqVuwKfOqeZ4=;
        b=J7L2+XDCYr0q9gmWdkfp6Tt80HyhPCAg4HPu7Mn2oJ/d4DQK8iG9SUptjr38kUoRVZ
         RoeM3Vzf93onewU5rN9Cit49MrrakyLdazuUe3NpPsvmlfQUxC65o592g/EJJdKZI+U1
         42ER2F8/kv1RePL4U0u7FOlHXd82dCjYJm3NHUFcAXntWKrZUEhzz8Wi32KD4pZa8VZ7
         HqriJgXNZhpfGTjsMRo9IFLae22OKyrb1+e1TZgM3/6l5cpLT9yLLqMcdmM3oysNajtR
         w0nV+EoYEdqHbxjc80IspQAGFKUnudOWT2hyY9XBeTjtaFGgCZkuUaR5mvT7C7lonciX
         sW0Q==
X-Gm-Message-State: AHPjjUhaDJyjUtNgWBucXf00gYWoenRg9TVP0vZJmh5vxJHfMNuP4coa
        5yGLEHKifX5hWW5CnOA=
X-Google-Smtp-Source: ADKCNb40Tf6+mkjvoJF/zNywzSsq6zAbvLBGl4kG9KeYGyHZB6tgZQzc6u+qWe9+kXqaZ5SrEBsGEQ==
X-Received: by 10.98.202.91 with SMTP id n88mr3996774pfg.73.1504307975755;
        Fri, 01 Sep 2017 16:19:35 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c8a:d1f4:a5bc:2c5f])
        by smtp.gmail.com with ESMTPSA id o18sm1645581pgd.15.2017.09.01.16.19.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 01 Sep 2017 16:19:35 -0700 (PDT)
Date:   Fri, 1 Sep 2017 16:19:33 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] doc/for-each-ref: explicitly specify option names
Message-ID: <20170901231933.GC143138@aiede.mtv.corp.google.com>
References: <20170901144931.26114-1-me@ikke.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170901144931.26114-1-me@ikke.info>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt wrote:

> For count, sort and format, only the argument names were listed under
> OPTIONS, not the option names.
>
> Add the option names to make it clear the options exist

nit: missing full-stop (.) at end of sentence.

> Signed-off-by: Kevin Daudt <me@ikke.info>
> ---
>  Documentation/git-for-each-ref.txt | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Makes sense.

> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index bb370c9c7..0c2032855 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -25,19 +25,25 @@ host language allowing their direct evaluation in that language.
>  
>  OPTIONS
>  -------
> +<pattern>...::
> +	If one or more patterns are given, only refs are shown that
> +	match against at least one pattern, either using fnmatch(3) or
> +	literally, in the latter case matching completely or from the
> +	beginning up to a slash.
> +
> -<count>::
> +--count <count>::

nit: the usage string (and "git help cli") recommends --count=<count>
with equal-sign, so it probably makes sense to match that (and likewise
for the other options).

Looking closer reveals more problems with the manpage:

* the synopsis mixes the style using = and the style using space,
  without a clear reason for doing so

* the synopsis implies that I can run
  "git for-each-ref --merged --contains HEAD".  But that produces

	fatal: malformed object name --contains

  An exact grammar would be harder to read than what is here, but
  perhaps it's worth a word or two on that subject in the description
  section.

  The description of --contains in git-branch.txt has the same problem.
  It's tempting to treat the <commit> argument to --contains as
  non-optional in the synopsis, since it's always harmless for a user
  to specify it.  The OPTIONS section can still explain what happens
  when <commit> isn't specified.

* by the way, the synopsis and options sections use <object> where
  they mean <commit>.

How about something like this patch, for squashing in?  It focuses on
just the ordering and option name issues described in the commit
message --- it doesn't make any of the more aggressive changes
described above.

Thanks,
Jonathan

diff --git i/Documentation/git-for-each-ref.txt w/Documentation/git-for-each-ref.txt
index 0c20328555..66b4e0a405 100644
--- i/Documentation/git-for-each-ref.txt
+++ w/Documentation/git-for-each-ref.txt
@@ -10,8 +10,9 @@ SYNOPSIS
 [verse]
 'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [(--sort=<key>)...] [--format=<format>] [<pattern>...]
-		   [--points-at <object>] [(--merged | --no-merged) [<object>]]
-		   [--contains [<object>]] [--no-contains [<object>]]
+		   [--points-at=<object>]
+		   (--merged[=<object>] | --no-merged[=<object>])
+		   [--contains[=<object>]] [--no-contains[=<object>]]
 
 DESCRIPTION
 -----------
@@ -31,19 +32,19 @@ OPTIONS
 	literally, in the latter case matching completely or from the
 	beginning up to a slash.
 
---count <count>::
+--count=<count>::
 	By default the command shows all refs that match
 	`<pattern>`.  This option makes it stop after showing
 	that many refs.
 
---sort <key>::
+--sort=<key>::
 	A field name to sort on.  Prefix `-` to sort in
 	descending order of the value.  When unspecified,
 	`refname` is used.  You may use the --sort=<key> option
 	multiple times, in which case the last key becomes the primary
 	key.
 
---format <format>::
+--format=<format>::
 	A string that interpolates `%(fieldname)` from a ref being shown
 	and the object it points at.  If `fieldname`
 	is prefixed with an asterisk (`*`) and the ref points
@@ -65,24 +66,24 @@ OPTIONS
 	the specified host language.  This is meant to produce
 	a scriptlet that can directly be `eval`ed.
 
---points-at <object>::
+--points-at=<object>::
 	Only list refs which points at the given object.
 
---merged [<object>]::
+--merged[=<object>]::
 	Only list refs whose tips are reachable from the
 	specified commit (HEAD if not specified),
 	incompatible with `--no-merged`.
 
---no-merged [<object>]::
+--no-merged[=<object>]::
 	Only list refs whose tips are not reachable from the
 	specified commit (HEAD if not specified),
 	incompatible with `--merged`.
 
---contains [<object>]::
+--contains[=<object>]::
 	Only list refs which contain the specified commit (HEAD if not
 	specified).
 
---no-contains [<object>]::
+--no-contains[=<object>]::
 	Only list refs which don't contain the specified commit (HEAD
 	if not specified).
 
