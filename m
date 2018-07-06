Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CE8A1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 23:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933054AbeGFXrY (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 19:47:24 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38986 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932839AbeGFXrX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 19:47:23 -0400
Received: by mail-pf0-f193.google.com with SMTP id s21-v6so9578199pfm.6
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 16:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZpNRvYXBgboQJk2poEn0YN9FWzpGkgltWc/m2tOfEFo=;
        b=B/yoYGK995CtRYhnV/Wpp76VefpZrXOaEoYQWMHxFz05QCFDkrR17zdy6Z70/DqFCn
         z5ywhaMC+j1090wsyckn+JQXGz+n/IC1Yw2dpsu+WiB9330Va89MvcXDYwLrW2gSonJz
         +2MxDKap6iTBLqkrdYkhEwwJLMnhwvFsAP3dZzej6qwLyApnjeQdSsCqnHy15Ghc7SuO
         CGu+YCjaa7YmST6KgvQOzQpyHooSy379GN3mGfQOr/2UZy4D06gKEwb1glRQ9Gsl6G9i
         rwFJ3QxeqZVlVeWPOELgqDPnTtFSgNpF06rNCAWvPhA0Dc87a+XquoWz9mobCcTQ3n+9
         IpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZpNRvYXBgboQJk2poEn0YN9FWzpGkgltWc/m2tOfEFo=;
        b=io1OeVks8rUiXaeGxXMQlqa0xOe4l++/+XJZWoLsrou8/wbvnnl/K36+FSq7GRTEMM
         g7E89HOgzEbjv2wY52/6PKFbqyDHBfE52rStjTlWfCSNouLDAvRnHh85VV6UViZ7GEln
         Hl4/GoDYpYfKeNs/sB3PclR4SV2Z2VwUPfON8IPV2RH54xc8Emcs4Ql0ftWYQBQ1scz5
         fmbSvfJCJj5Zd/ldmblg/nihIvjHGYZhiBDHz2eXbiMXsvgT9RhjM3wFksZRjANoHYBH
         W8DLK5fH7PaFfcUd9CpwcQH3suAvEtpW+d659E0XmJsatgxsHlG4m8nmskjW+EDw6GnC
         qH0Q==
X-Gm-Message-State: APt69E26umHN14HI3fMeH4h5zKbXQUjdd1urZSNJj6A3YiDVQDNQcSzo
        WVqnn8Aqfmg8ZOsJfy1ad3A=
X-Google-Smtp-Source: AAOMgpcG06m3hO8Q4m5shA6ah+wGLT9JSoBui1f540cjCTd+2XD0E29xlMHSncjU7GvGR1XvIo02Pg==
X-Received: by 2002:a63:4d47:: with SMTP id n7-v6mr10998361pgl.270.1530920842548;
        Fri, 06 Jul 2018 16:47:22 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v15-v6sm19081668pfk.12.2018.07.06.16.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 16:47:22 -0700 (PDT)
Date:   Fri, 6 Jul 2018 16:47:15 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Frederick Eaton <frederik@ofb.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: de-alphabetizing the documentation
Message-ID: <20180706234715.GA81694@aiede.svl.corp.google.com>
References: <20180706213239.GA867@flurp.local>
 <20180706211828.GC6195@aiede.svl.corp.google.com>
 <20180706232147.GF6343@ofb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706232147.GF6343@ofb.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Frederick Eaton wrote:

>       Unfortunately my contribution will have to be limited for the
> moment to making this suggestion, as I am extraordinarily busy. I hope
> it will not be too burdensome to add this item to your TODO list and
> keep it there until a willing volunteer comes along.

No problem.  If you have time to contribute later, we can wait. :)

> For what it's worth, I made extensive changes to the Arch Wiki Git
> article back in 2015, following an initial attempt of mine to
> understand various tutorials. It was the most prominent wiki-based Git
> documentation I could find at the time. The article has of course seen
> numerous improvements since then.

For reference: https://wiki.archlinux.org/index.php/git

> I don't think that it's really important to find a "best" ordering for
> commands or glossary terms; it's more a matter of finding someone who
> is willing to take responsibility for choosing a reasonable ordering.
> Presumably the head maintainer of this project could delegate the task
> to a qualified volunteer, not a newbie like myself but not necessarily
> someone with expert knowledge either.

I'd have to say, when I compare the troubles a new user and a
long-timer would run into, I conclude that the long-timers would be
more likely to produce worse documentation.  It is very difficult to
remember how new users see things.  The ideal skill set in fact has
nothing to do with level of Git expertise: to produce a good result, a
good technical writer would ask the right questions to gather
information from the experts and then test their documentation on
newcomers until it works well.

Based on the work you've described already having done, it sounds like
you'd be an ideal person to get this going, if you find yourself with
time for it.

>                                       It's too bad that a policy of
> not listing things alphabetically wasn't adopted from the beginning of
> this project, but I guess that's life.

From this thread I've been convinced that for this kind of reference
document, alphabetical organization within each section is a good
organization, provided each section is small enough (as in "git help"
output).

I'm also a fan of non reference documentation that can use a narrative
ordering instead (like "git help core-tutorial", except with more
modern commands).

> Thanks Eric for the pointer to "git help". This does indeed provide a
> finer and better grouping than the man-page (but it also looks like
> another candidate for de-alphabetization...!).

Indeed, copying that organization over from "git help" to the git(1)
manpage may be a good step for any interested people overhearing this
conversation.

As a first step, how about making git(1) recommend "git help", like
this?  It already recommends giteveryday(7) but the more interactive
first command might be useful for some people.

Thoughts?  Improvements?

-- >8 --
Subject: git doc: recommend "git help" as a starting point

The list of subcommands described in git(1) can be overwhelming.
Encourage newcomers to run "git help" to get a shorter list of
commands as a starting point.

Based on a suggestion by Frederick Eaton.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index dba7f0c18e..0149ce9af0 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -23,9 +23,12 @@ unusually rich command set that provides both high-level operations
 and full access to internals.
 
 See linkgit:gittutorial[7] to get started, then see
-linkgit:giteveryday[7] for a useful minimum set of
-commands.  The link:user-manual.html[Git User's Manual] has a more
-in-depth introduction.
+linkgit:giteveryday[7] and run
+
+    git help
+
+for a useful minimum set of commands.  The link:user-manual.html[Git
+User's Manual] has a more in-depth introduction.
 
 After you mastered the basic concepts, you can come back to this
 page to learn what commands Git offers.  You can learn more about
-- 
2.18.0.203.gfac676dfb9

