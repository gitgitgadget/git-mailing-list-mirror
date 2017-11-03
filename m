Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EFEB202A0
	for <e@80x24.org>; Fri,  3 Nov 2017 09:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbdKCJnF (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 05:43:05 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:48254 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbdKCJnE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 05:43:04 -0400
Received: by mail-yw0-f181.google.com with SMTP id q1so1910285ywh.5
        for <git@vger.kernel.org>; Fri, 03 Nov 2017 02:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=V+AA1eJjWZRGWTKfa9V4WKnH1gSC5NgtZBLXuQCk7rA=;
        b=KKI9MIifJV+Y8tkUTPXK55EvgIx3gHL+gAiDuJUsaPd/kLZbPLmaQVOL9BybNj0pZJ
         jpoHZ590HAOcy8FfTrYXoyw2fQQCGCw8Dh+sgAVQofC9WvWq7vVX/Wo5X7/GgxfYdTq2
         VBwSLDNhy71b1/xcojlcLx8ZVSwgIms1W+g6EhLLoI5oW2t2R4tPUSOzWd6kW/WN9SCs
         zNE4yuGXhwytD2g30tdtxETmNocJJ5WQbaN273cnrPbOnqGqxzSsPuFHPg59DtE6NGNL
         IjsHcWg/7VPF2efqHv27m4wMmNdQtQFUzxr55ASgQj+lgExKJlC1OIjoqoC9z7gijzXt
         /8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=V+AA1eJjWZRGWTKfa9V4WKnH1gSC5NgtZBLXuQCk7rA=;
        b=nWL1aTQeEAZJsLNFX241hf//34xiIsswRQAn1KvxYNsgQWyudYZCkB16l7OBJQZVv+
         tGFo7BGK6pE5foGfREEma7g4OBOrmoyLgIrAqV+OOcIOmIpcr2jZfJlo7HwOEF8W2l+p
         QLkLE46k5st6J59caM64LnG5pgnM2jyo0MbwaK2W/CyZj5aTpDcLQfCtTH+w5mMwinMO
         rpptNwj4NlVdgPtQ1zRBRrjQiYW1S+7oZvvHKFaFvN/1s3y+R5YfLPcia3sNOwW1W3s9
         tBXzI1okcgeJGW6eKDT7DE0WCoEbX2BZOYbllQ1QOu9HE/WmxpSGdeBRLDZYebPOnSv5
         gQZw==
X-Gm-Message-State: AMCzsaULb/aqO8vGz8z1lA4P4vtYSqBokXbA3e1geF31rSbsZqRKZRAQ
        W4F9HrYfM5GkquxN/ad+UuU7J3hroB2L7wmEnxPIRg==
X-Google-Smtp-Source: ABhQp+Rf95zZ7KzBUl2/7OLRby9Ph7tk4nTKygHwkR6Mz6uv/EvJNH0WLnKIBevwc6ka6kSSRL9Au6Q4ZCJ9V9OlYag=
X-Received: by 10.129.92.198 with SMTP id q189mr4287168ywb.417.1509702183638;
 Fri, 03 Nov 2017 02:43:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.44.21 with HTTP; Fri, 3 Nov 2017 02:43:03 -0700 (PDT)
From:   Vladimir Nikishkin <lockywolf@gmail.com>
Date:   Fri, 3 Nov 2017 17:43:03 +0800
Message-ID: <CA+A2iZZ5srHcAaaTv2kzdvWRLr3ffn61BB75Kuz0JoqfKCjwsg@mail.gmail.com>
Subject: Documentation for git-diff is very difficult to understand for a layman.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, honourable GIT developers.

I would like to kindly ask you to do something with the git-diff
manpage. (https://git-scm.com/docs/git-diff)

In fact, I wasn't able to understand it even after reading it a few times.

In my case, I was trying to understand, what the command actually
prints, but the man page doesn't really tell that.

1)I mean, there is a section:

"https://git-scm.com/docs/git-diff#_combined_diff_format", but at the
very end of the manpage, so presumably, only aimed at advanced users.
And the first thing it says is

"Any diff-generating command can take the -c or --cc option to produce
a combined diff when showing a merge. This is the default format when
showing merges with git-diff[1] ".

This line is confusing, because I am already actually running git-diff
(!). So am I really seeing a 'combined diff' or some other diff? Is
'git-diff' any different from 'git-diff -c' or 'git-diff -cc' ?

Could something be added to or rewritten in the manpage to clarify?

2)Also, in point 3 of the same section:

'index <hash>,<hash>..<hash>
mode <mode>,<mode>..<mode>
new file mode <mode>
deleted file mode <mode>,<mode>'

What do 'mode' and 'index' mean? Which values may this macros contain?
What do two dots '..' between two hashes mean? What are this hashes
of?
(Same question for <mode>.)

3)Same section, after point 4.

'Unlike the traditional unified diff format'. What is the 'traditional
unified diff'? Is it the diff produced by GNU diff, POSIX diff or
unidiff? Or, maybe there is some other diff in other parts of GIT?

4)There is also a section called 'other diff formats':
https://git-scm.com/docs/git-diff#_other_diff_formats

But it doesn't actually tell anything about other diff formats, it
just describes some other options to git-diff.

Maybe I am asking something trivial, but I believe, I am not the only
novice trying to read the documentation of git. (I found the man page
reference at the ProGIT book.)

5)Also, there is a contradiction in the documentation.

The first lines at the 'options'
(https://git-scm.com/docs/git-diff#_options) section say:

-p
-u
--patch

Generate patch (see section on generating patches). This is the default.

But at the 'combined diff' section:
(https://git-scm.com/docs/git-diff#_combined_diff_format)

The lines at the point 4 say:

"Chunk header format is modified to prevent people from accidentally
feeding it to patch -p1."

So what is in reality the behaviour of git-diff? Is it to create a
patch, or to prevent the creation of a patch?


I would be happy if some of the developers could (if not simplify the
man page), at least add some references at any manuals written in a
more newbie-friendly way.

Thank you in advance!


-- 
Yours sincerely, Vladimir Nikishkin
