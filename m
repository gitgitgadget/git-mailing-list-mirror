Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26930202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 18:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbdJSS1V (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 14:27:21 -0400
Received: from mout.web.de ([217.72.192.78]:53801 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752069AbdJSS1V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 14:27:21 -0400
Received: from [192.168.178.36] ([91.20.51.19]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LtWsC-1d6Vaq48iy-010sx7; Thu, 19
 Oct 2017 20:26:53 +0200
Subject: Re: [Alt. PATCH] ls-remote: deprecate -h as short for --heads
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Thomas Rikl <trikl@online.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
References: <63fe2a84-d991-9165-32c0-8087d8513ce6@online.de>
 <CAN0heSpPWWdWY4d1wCdRH8TjcmD3kAiSffL0-_9kJWkm5P2EkA@mail.gmail.com>
 <4d110305-0826-6fd1-91a5-c1ebd0b1e80b@web.de>
 <774f08bd-3172-0083-1544-e5f68f6798fa@web.de>
 <xmqqk1ztmkbn.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <26112a15-f02c-a910-c8bb-794ca84dc1e5@web.de>
Date:   Thu, 19 Oct 2017 20:26:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqk1ztmkbn.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:9W9nuJGSkMw18d8bgXRM81xsQQCBr/q3bgaqrgsaQtC4e+vfsLb
 YnuOd+ZWE4hivBg0FpzhTCMu5J2li8OzUK1OfgpoLkkOqP2zQ0r20L+3Lt3591IJ7iI6B0R
 c/C7fJz8mRuXyCcY9QSZfPo9VwZ16cM89k9wBE1bWv/BwHNadzm+T55bUo34iN2eQ/zHM8R
 N0um4n+mavZpX6ewJatkA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:os+NmhJwur0=:/6td1Ge8+d3QNsgNnyCab6
 HcTLGk4yS3KFS0SR7XKXPQ6ZTQcdlxufZRTUDInJv11zTKD4M8EGkkcOsETTFS53tH83zCF0P
 SrzwydwBSwSxU3tnQszI81x7HXMDze+DHNKzk8IgiX5mJqYrB5G4QDvuB6IytUWwuQP9A+lQ3
 Z0HyihAZhXYV1DTr0G0TUk1EUiFxRpjnMo3thyJvvPqgaXrik3Z5ZiZrvFnzESol14eQY7pxC
 QrlUa4p/NbYZfBHnN2AEf63KxeFvFG4nMsZhRlD/OmHN2Q3XxZ4gahK6H1tt0l0zoq/ADjwYp
 KwQbADRXL/mAWnZ5qGz9d9p+F1+fes67CDKVzYXBzmvyAOjCMFQQIgco1ht5/YsPvDZxEGZNL
 q3wcchbF9t0sVSwJkCMvyEe6MlbFNLYFpBia4Do5sbzGI2Nto4UlMx7DiIehcYa8tkGhkxedl
 qn5DRrVHk+iRrNcgWutDwDRRXimrTqdmGimGKy1Xpdu3H68oZ1I1TjUaswfLjs8ue4yomwSlr
 zjE36l7sfflwYWXfJDPYRHYaiGV3v1lxnZsmkOrJOCs7JZ9TIIPa82aA3+zkNBJyorcCvzKt2
 AWoHNJG/9z8A1Prc+lHDJcnwab+SiL0WkBBeK7KEe+i0LAZWb9fYTQtVvj6elmoCccp5sLIjv
 ZxANDZoETVWSxNGybH6IGicA4l3lgBm3NYnjGRCFvKl8F+VwUjNBBkktC3XjTnSyYNrieTt0D
 aOkPOH3etb+p2sTPOMoFrA5kBA9cSjhvZK559+9O332dsDgGyo95UWedFz8nbN+hJBhsn2BiD
 3vzg+L/uZ49JTkJCSxZDdDODdBFJtxd2pfL14DTORVV2Gj+pRE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.10.2017 um 01:22 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> Stop advertising -h as the short equivalent of --heads, because it's
>> used for showing a short help text for almost all other git commands.
>> Since the ba5f28bf79 (ls-remote: use parse-options api) it has only
>> been working when used together with other parameters anyway.
>>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>> That would be step on the way towards more consistent command line
>> switches, in the same vein as d69155119 (t0012: test "-h" with
>> builtins).
> 
> Sorry, but I am not sure whom this and the other approach are trying
> to help.
> 
> The rule we have currently seems to be that "git cmd -h" (no other
> arguments) consistently gives a short help, and if a subcommand
> supports an option "-h" specific to it that is not about giving a
> short help, the caller needs to be aware of it to invoke the option,
> by making sure that there is some other arguments on the command
> line if "-h" form of that subcommand specific option is used, by
> doing e.g. "git ls-remote -h origin" or "git ls-remote --head".
> 
> I can see that this "alternative" approach makes it less convenent
> for folks who have followed that rule by hiding "-h" (with the
> intention of deprecating and possibly removing it in the future) and
> encouraging (and later foring) "--head" to be used instead.
> 
> The other approach burdens new users by changing the rule to "some
> subcommands that have their own '-h' option cannot be asked for a
> brief usage with 'git cmd -h'".  But the thing is, these new users
> who do not know which subcommands do have their own '-h' and which
> ones do not are the ones that benefit most from the consistent "'git
> cmd -h' with no other argument gets short help" rule.

They would help by aligning documentation and code, at a price.  But
of course there is another way to do that -- I just didn't see it the
other day.  We don't have to take anything away:

-- >8 --
Subject: [PATCH] ls-remote: document behavior of lone parameter -h

Reported-by: Thomas Rikl <trikl@online.de>
Analyzed-by: Martin Ågren <martin.agren@gmail.com>
Analyzed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 Documentation/git-ls-remote.txt | 10 ++++++++++
 builtin/ls-remote.c             |  5 ++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 5f2628c8f8..82622e7fbc 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -29,6 +29,9 @@ OPTIONS
 	These options are _not_ mutually exclusive; when given
 	both, references stored in refs/heads and refs/tags are
 	displayed.
++
+*NOTE*: -h without any other parameters shows a short help text instead
+of any refs.
 
 --refs::
 	Do not show peeled tags or pseudorefs like HEAD	in the output.
@@ -89,6 +92,13 @@ EXAMPLES
 	f25a265a342aed6041ab0cc484224d9ca54b6f41	refs/tags/v0.99.1
 	c5db5456ae3b0873fc659c19fafdde22313cc441	refs/tags/v0.99.2
 	7ceca275d047c90c0c7d5afb13ab97efdf51bd6e	refs/tags/v0.99.3
+	$ git ls-remote -hh
+	From https://git.kernel.org/pub/scm/git/git.git/
+	4c2224e83951a685185bb8c1f83b28e22fee0e27	refs/heads/maint
+	5fe978a5381f1fbad26a80e682ddd2a401966740	refs/heads/master
+	76aedb4517c834be2dc89efb5f9d15908e324422	refs/heads/next
+	c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/pu
+	5d38b589ccc7a8355c62f1577865df5b8216c00d	refs/heads/todo
 
 GIT
 ---
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index c4be98ab9e..0438dfec05 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -56,7 +56,10 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			   N_("path of git-upload-pack on the remote host"),
 			   PARSE_OPT_HIDDEN },
 		OPT_BIT('t', "tags", &flags, N_("limit to tags"), REF_TAGS),
-		OPT_BIT('h', "heads", &flags, N_("limit to heads"), REF_HEADS),
+		OPT_BIT(0, "heads", &flags, N_("limit to heads"), REF_HEADS),
+		OPT_BIT('h', NULL, &flags,
+			N_("if only parameter: show this help text, otherwise limit to heads"),
+			REF_HEADS),
 		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
 		OPT_BOOL(0, "get-url", &get_url,
 			 N_("take url.<base>.insteadOf into account")),
-- 
2.14.2
