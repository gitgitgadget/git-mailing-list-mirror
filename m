Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E6D01F597
	for <e@80x24.org>; Thu,  2 Aug 2018 18:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbeHBUjD (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 16:39:03 -0400
Received: from mout.web.de ([212.227.15.14]:47987 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729733AbeHBUjD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 16:39:03 -0400
Received: from [192.168.178.36] ([79.237.249.67]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LgK3g-1gHM7w3rvg-00njgA; Thu, 02
 Aug 2018 20:46:32 +0200
Subject: Re: [PATCH] push: comment on a funny unbalanced option help
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
 <87k1p9u860.fsf@evledraar.gmail.com>
 <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
 <87h8kdu3ay.fsf@evledraar.gmail.com>
 <30a6105c-4cb7-b52f-0b0a-c4504b90a5b1@web.de>
 <xmqqftzw4weq.fsf@gitster-ct.c.googlers.com>
 <20180802165457.GC15984@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ad2d8f99-07a3-0191-88a2-c43081657988@web.de>
Date:   Thu, 2 Aug 2018 20:46:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802165457.GC15984@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WR7hXbWii36wNQSJgw0+t58N8R6tDQLFGZvJVmqncH4YmQ6CPEr
 51nH535F0PNbKMMmwxOoBi6cx5Q7+OhcsXKy3QFnxNsE5vEaf4i9I+LcIt46nRhlxVBdop3
 S4jiOz83m8ZAkfFvENSxWYjt6p7eJKJGETABNpjp92QLXOwIPmBHJXo49DF7/Pm9WpWE4mj
 HVdYGjkzAsWZPH1oLLxIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tZdgC4d/pzk=:721PBsCTqHderVHFmiGnI+
 HSsEOGcP6HVmJ54chSS19eE0xlT9qmT19kAe7BRy9pqZNg/qK+nHyvGqJ+j0oaOR9h5XCNjs6
 JJCuUKl4Vnwp/9oSK6XAiUcxBPRu061jDu7oWJenppI/WgBSNIf6HAP5yIUda3wghDfyWwSm6
 cqWJ8RObWVQe1mqkHe0h8JHYoJo6CQxZ8PMaINvZKuK0uXgZ/HVaiCW9LthC//EWPwULmoGHT
 470puc2/H8sxbe6oiuyfHvjqykXQYTVJZaK+0qDiISwK+XiTtv+IhnuqLxc0iiiJacHhLO+RC
 +I+Jc8FhXAhrQCRFR4JP06Y16ZHhG9IP5IeK/Q0PygYbqnwLjsQuif6zRCKqHjA1pljk3c4LI
 eGAxa88mH5J7CF4vVTXOzgt/uWbI+8AtJoUQLHV69WzOfWZfg/S+XJ07JCdnliuPCuFUlsQsw
 mpkhY694o+7NZxwJ5LgHdQjttibZ52UpBHO3eY4UeAES/UfnmJa9Un92CJrTNoX9MUlgraUqC
 QYqGMm3X+gone7nOJV+2qHghLpZsCf4ssQeRZnOzIne8WIF8PmIFd9xfxPuKXct8AQw0leoNi
 xCoFuFYw+qm7nlCxsNWqSMdwzQaqxsGprOKuYu25YM5ndiowGW5uIwzJUkU+pLiWIBimzL4CC
 Pg8HREXe8+pDWi72jf2yp/GKT9HyphgozJU/WGhCe+nbSYhGa1CtEgEBQLSJk4XHMZK9eeo/j
 kncbHgiiKR8a0k2JDXAUczR570gAZNHQioqkpBTSCyFnPVFpellY2QrDxRpZe98cAE/FsuN0F
 hVlPlyH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.08.2018 um 18:54 schrieb Jeff King:
> PS I actually would have made the rule simply "does it begin with a
>     '<'", which seems simpler still. If people accidentally write "<foo",
>     forgetting to close their brackets, that is a bug under both the
>     old and new behavior (just with slightly different outcomes).

Good point.  We could also extend it further and check if it contains
any special character, which would allow us to convert the remaining
user of the flag as well:

	{OPTION_CALLBACK, 0, "chmod", &set_executable_bit, N_("(+/-)x"),
		N_("override the executable bit of the listed files"),
		PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
		chmod_callback},

Special characters are (, ), <, >, [, ], and |.

The idea is that we shouldn't automatically treat a string as a
simple replacement specifier if it looks like it has some structure
to it.

Side note: "(+/-)x" is marked for translation above.  Any translation
that is not identical would be wrong, though, because the command only
accepts a literal "+x" or "-x" in any locale.  So the N_ wrapper is
bogus, right?

Checked the output with that extended check by generating all help
pages with:

	for cmd in $(git --list-cmds=parseopt)
	do git-$cmd -h
	done

... and found a few differences:

git add:
-    --chmod <(+/-)x>      override the executable bit of the listed files
+    --chmod (+/-)x        override the executable bit of the listed files

Good change.  We also should change the slash to a pipe.

git checkout-index:
-    --stage <1-3|all>     copy out the files from named stage
+    --stage 1-3|all       copy out the files from named stage

Good change, but perhaps mention number two explicitly?

git difftool:
-    -t, --tool <<tool>>   use the specified diff tool
+    -t, --tool <tool>     use the specified diff tool
-    -x, --extcmd <<command>>
+    -x, --extcmd <command>

Aha, double angle brackets in the wild!  Good change.  We could
also remove the explicit pairs from the option definitions.

git pack-objects:
-    --index-version <version[,offset]>
+    --index-version version[,offset]

Not good before, worse after. Should be to "<version>[,<offset>]".

git pull:
-    -r, --rebase[=<false|true|merges|preserve|interactive>]
+    -r, --rebase[=false|true|merges|preserve|interactive]

Good change, but wouldn't we want to add a pair of parentheses around
the list of alternatives?

git push:
-    --force-with-lease[=<refname>:<expect>]
+    --force-with-lease[=refname>:<expect]

Bad change, needs explicit angular brackets (Junio's patch).

-    --recurse-submodules[=<check|on-demand|no>]
+    --recurse-submodules[=check|on-demand|no]
-    --signed[=<yes|no|if-asked>]
+    --signed[=yes|no|if-asked]

git send-pack:
-    --signed[=<yes|no|if-asked>]
+    --signed[=yes|no|if-asked]

Good changes all three, but need parentheses..

-    --force-with-lease[=<refname>:<expect>]
+    --force-with-lease[=refname>:<expect]

Bad change, needs explicit angular brackets (same as in Junio's patch).

git shortlog:
-    -w[<w[,i1[,i2]]>]     Linewrap output
+    -w[w[,i1[,i2]]]       Linewrap output

Not good before, worse after.  Should be "[<w>[,<i1>[,<i2>]]]".

git update-index:
-    --cacheinfo <mode>,<object>,<path>
-                          add the specified entry to the index
+    --cacheinfo           add the specified entry to the index

Eh, what?  Ah, that option is defined with PARSE_OPT_NOARG, and we only
show argument help because PARSE_OPT_LITERAL_ARGHELP is also given, so
we need to keep that flag for this special option.

René
