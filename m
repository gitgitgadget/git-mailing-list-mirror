Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE7881FF34
	for <e@80x24.org>; Thu, 11 May 2017 07:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754536AbdEKHUN (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 03:20:13 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:34094 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753303AbdEKHUM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 03:20:12 -0400
Received: by mail-it0-f54.google.com with SMTP id a10so119128itg.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 00:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/zYM5+7McdKhfGdlS/8wdy/p/xiAHjnuGNmIgTDV21E=;
        b=TFK8UcVFMOGeKPZE+kakXM8/jEQUTsM1AFSbdeP/BxCpJMmaw5hEnMtxqiWVSASkaj
         ISI3m8wZoI4ZN8FG77ibdIVQvdsY30xmiCSfA42O8b2b0q6iczlOhc+x1/rwqGDrm1+T
         P0di3gWilhNL5vYOCMF3xLV/OyRZW9PRA6cWG3AYRnCHg4pbK9kfnAyzI4SBMrbpNOJA
         xZ0w+sLYTv+7bebCIcGnpwcoKi2aI6jwgi2I+uWAj31FqSuzJb7DnPRooKn1qcloVAHh
         Z3aSAu3GXDuVutP+hbB++oiO6Uw2ohZpInQqcq35ChNTrZyT/rrOiB38aeLWjcljc6AM
         AQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/zYM5+7McdKhfGdlS/8wdy/p/xiAHjnuGNmIgTDV21E=;
        b=my3J3Y747GaAMHqlK+LYYRaUSlM8lTyQiz+i5+FetqN0TWKchBQKy8fUW2xAIdAeU0
         rHcM9TZcDiLcOz/Y7bNyfq1pBYg+/AG3SwsvWtrSVLmkZszvpgWaZagCVbMhH+ZaeK/O
         UwUhXsKDWNpGfyapcifMjFjf1e/uxGP1hfIAQY1sEcDyOBr/VXZlHecYWTMb1ge6qC9m
         LzB8TM7h3s3St50svfi+S9YuQulyrIAPGaUX5SVTXVNpFL2J75cJ+DV+xpgKB8K6jaRJ
         8kCVFP3D8RfQflrQ3xj7M1THcRGxDLG3cuDzHuQqXqINbfZQgyEasJnvTFgUaXmg8cYr
         9mQA==
X-Gm-Message-State: AODbwcDGPgY86J/RiE96RbQPd2mvJNfoEZve6HfnU2GGUqa14wjD+j5Y
        Lz66+Hu+LkleTpudnl55Fj6izDYHOg==
X-Received: by 10.36.53.2 with SMTP id k2mr1559097ita.71.1494487211354; Thu,
 11 May 2017 00:20:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 11 May 2017 00:19:50 -0700 (PDT)
In-Reply-To: <20170511062924.6euaynsbyocjcw3q@sigill.intra.peff.net>
References: <C1ACB28C-F1B4-42A1-8135-797DEFD9F03C@gmail.com>
 <b80c68fa-fe1e-3cf8-3c7e-527a4d941108@gmail.com> <CACBZZX7CgeW1OK+g9Mbir62MMaCx4sHFZngUuWz_H241Sb355g@mail.gmail.com>
 <20170511062616.f7rg6f5cgrqeh7gf@sigill.intra.peff.net> <20170511062924.6euaynsbyocjcw3q@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 11 May 2017 09:19:50 +0200
Message-ID: <CACBZZX4ob04fG9ZZtvbdcqrYOKijoZohVdUCNyeayHZtdtNyxQ@mail.gmail.com>
Subject: Re: Possible bug in includeIf / conditional includes
To:     Jeff King <peff@peff.net>
Cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        Raphael Stolt <raphael.stolt@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 8:29 AM, Jeff King <peff@peff.net> wrote:
> On Thu, May 11, 2017 at 02:26:16AM -0400, Jeff King wrote:
>
>> > So whether this is a bug in the code or not it seems to definitely be
>> > a doc bug, whatever it does with relative files should be in the docs.
>>
>> The includeIf variables should behave exactly as the documentation you
>> quoted above. The conditional impacts whether we respect the keys in
>> that section, but not the meaning of the keys.
>>
>> I thought that was clear, but as somebody who was involved in the
>> development of both the original and the conditional includes, my
>> opinion probably doesn't count. I wouldn't mind a patch to make that
>> more explicit in the documentation.
>
> I figured I'd just do this while we're thinking about it, since it
> should be trivial. But it's actually there already:
>
>   You can include a config file from another conditionally by setting a
>   `includeIf.<condition>.path` variable to the name of the file to be
>   included. The variable's value is treated the same way as
>   `include.path`.
>
> I'm open to suggestions to make that more obvious, though.

Yes I started writing up a patch to make this better but once I
started doing that it wasn't really any better.

FWIW the reasons I didn't find this while quickly skimming the thing:

1. It says "The included file is expanded immediately, as if its
contents had been found at the location of the include directive.". At
first I thought this referred to glob expansion, not
s/expanded/interpolated/, the example section uses "expand" in the
context of pathnames, which caused the confusion.

Maybe this would make that less confusing by saying the same thing
without using the same phrasing to mean completely different things:

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d51..49855353c7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -167,8 +167,8 @@ Example

        [include]
                path = /path/to/foo.inc ; include by absolute path
-               path = foo ; expand "foo" relative to the current file
-               path = ~/foo ; expand "foo" in your `$HOME` directory
+               path = foo ; find & include "foo" relative to the current file
+               path = ~/foo ; find & include "foo" in your `$HOME` directory

        ; include if $GIT_DIR is /path/to/foo/.git
        [includeIf "gitdir:/path/to/foo/.git"]

2. There is no example of such expansion for IncludeIf, prose should
always be backed up by examples for the lazy reader when possible:

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d51..fc4b87cd7e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -173,6 +173,8 @@ Example
        ; include if $GIT_DIR is /path/to/foo/.git
        [includeIf "gitdir:/path/to/foo/.git"]
                path = /path/to/foo.inc
+               path = foo ; find & include "foo" relative to the current file
+               path = ~/foo ; find & include "foo" in your `$HOME` directory

        ; include for all repositories inside /path/to/group
        [includeIf "gitdir:/path/to/group/"]

3. When I read reference docs I almost never start at the beginning &
read it all the way through, in this case I thought I could help
someone out by maybe answering a question on the ML quickly, so I went
to the examples section, found no example (fixed above), then searched
for "relative" or "path" in my pager and the only results were for the
"Includes" section that has a paragraph that's only talking about
"include.path".

Of course we say "same rules apply" below, but I managed not to spot
that. Maybe this:

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d51..b35d9a7b80 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -95,8 +95,11 @@ Conditional includes

 You can include a config file from another conditionally by setting a
 `includeIf.<condition>.path` variable to the name of the file to be
-included. The variable's value is treated the same way as
-`include.path`. `includeIf.<condition>.path` can be given multiple times.
+included.
+
+If variable's value is a relative path it's treated the same way as
+`include.path`. `includeIf.<condition>.path` can also be given
+multiple times.

 The condition starts with a keyword followed by a colon and some data
 whose format and meaning depends on the keyword. Supported keywords

Would make it easier to find. Here we say the same thing but include
both "path" & "relative".
