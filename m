Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BB01202A4
	for <e@80x24.org>; Mon, 11 Sep 2017 10:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750986AbdIKKbr (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 06:31:47 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:46303 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbdIKKbq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 06:31:46 -0400
Received: by mail-wm0-f54.google.com with SMTP id i189so36065442wmf.1
        for <git@vger.kernel.org>; Mon, 11 Sep 2017 03:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=jT2d8L/oqzLZSoFFT4Zi63jUFjf8IfUZZvTzCudKjlc=;
        b=iNAMoMNewenwtxdH2wY3UqUv3RnmlYQtQFTDtyBtUNEOZyw2BB1Cukbo2O7pikb3t8
         SBdflq7VVKJXE9EvfkmnOTE4HR4EEuorJCsGp/leRqeEguy1HMHhHx14EiqrdjwRX99p
         yavhONBJqUud1qMFcZbG9X2n/HfXQbWUdyV/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jT2d8L/oqzLZSoFFT4Zi63jUFjf8IfUZZvTzCudKjlc=;
        b=YqjeC1IR0E0i3JwIx/kbArIU3E9vuSe9PYhF4qHEjocEoAsFaEKbz9LYiZX+a5nqoY
         3sgWh4HQkHsIP9qdg1ipVGMpUyoMVfsY0PBXsO+X+U93+PKD5NoCvN48GCwkglDa5KcO
         H5UpeOjF1tyLvELoBwUip0qgXvoQ2IpAvA2LN9leigfBChqkR60C2kNei5ELx5YtN6+c
         ta9EBBko7lhiaZ5mHC4t6C8z4gvpjU0zSeEwgP+g4gsQm4mtbOSRDGCC6GWBhdg5MyzD
         xQblJomNeKlzrB6op77QKIap0sGniS96IQlxksZSnGObCeGZ77DGT2zVzP5L2/liGKBq
         M9og==
X-Gm-Message-State: AHPjjUh9D08C/YOLPbspJlQHDrX7xchBxjmJJSXhgby9ZkUpbRFeJFB4
        7JGdDP0VO24BjJvH
X-Google-Smtp-Source: AOwi7QB4wyaWaG6VRzmplKFdR1P27XJgFF5XF8rgP5s3/RcugrUQ9+2mW4yTEibmsZNsV08AQvRJEA==
X-Received: by 10.28.104.67 with SMTP id d64mr7584653wmc.15.1505125905079;
        Mon, 11 Sep 2017 03:31:45 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id u1sm4545379wrd.95.2017.09.11.03.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Sep 2017 03:31:44 -0700 (PDT)
Date:   Mon, 11 Sep 2017 11:31:42 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Michael J Gruber <git@grubix.eu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Unexpected pass for t6120-describe.sh on cygwin
Message-ID: <20170911103142.GH10378@dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c3db153-2a56-f27d-af71-e4b61f1252a1@ramsayjones.plus.com>
 <2ef4b3b3-fa2f-ef06-203e-521b8cd6ecaa@ramsayjones.plus.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 09, 2017 at 02:13:32PM +0100, Ramsay Jones wrote:
> I ran the test-suite on the 'pu' branch last night (simply because
> that was what I had built at the time!), which resulted in a PASS,
> but t6120 was showing a 'TODO passed' for #52.

Confirmed, I also see this unexpected pass.

> This is a test introduced by Michael's 'mg/name-rev-tests-with-short-stack'
> branch, which uses 'ulimit -s' to try and force a stack overflow.
> Unfortunately, 'ulimit -s' seems to have no effect on cygwin. I created
> a test program (see below) to eat up the stack and tried running it
> with various ulimit values (128, 12, 8), but it always seg-faulted
> at the same stack-frame. (after using approx 2MB stack space).

Yes, Cygwin does not implement the ulimit API from the Single Unix
Specification, per https://cygwin.com/cygwin-api/std-notimpl.html.  I
suspect the Bash builtin still exists because (a) nobody has bothered to
remove it, (b) including it avoids breaking scripts that assume it
exists but don't particularly rely on its output being sensical, or
(c) both.

> So, it looks like all ULIMIT_STACK_SIZE tests need to be disabled
> on cygwin. I also wonder about the ULIMIT_FILE_DESCRIPTORS tests,
> but haven't looked into it.
> 
> Given that 'ulimit' is a bash built-in, this may also be a problem
> on MinGW and Git-For-Windows, but I can't test on those platforms.

I'll leave this to the relevant folks to test; I don't have a useful
test environment for those either.  That said, I'll note the comment in
t6120 says the ULIMIT_STACK_SIZE prerequisite excludes running the test
on Windows, so I assume it's not a problem there.

On Sun, Sep 10, 2017 at 05:58:49PM +0100, Ramsay Jones wrote:
> On 10/09/17 13:27, Michael J Gruber wrote:
> > So, I guess, short of testing the effect of "ulimit -s" with another
> > expensive test, it's best to simply set these prerequisites based on
> > "uname -s".
> 
> Yes, I was going to suggest adding !CYGWIN to the test(s) (or perhaps
> to the 'test_lazy_prereq' expression(s)).

Given the issue is Cygwin not implementing ulimit at all, but Cygwin
Bash pretending everything's fine, I think handling this as a special
case for Cygwin seems like the correct approach.  Something like the
below, based on the existing code in test-lib.sh for the PIPE prereq?

-- >8 --
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 83f5d3dd2..376cd91ae 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1166,14 +1166,32 @@ test_lazy_prereq UNZIP '
 	test $? -ne 127
 '
 
+# On Cygwin, ulimit has no effect because the underlying API hasn't been
+# implemented.  Just fail if trying to do something with ulimit.
 run_with_limited_cmdline () {
-	(ulimit -s 128 && "$@")
+	case $(uname -s) in
+	CYGWIN*)
+		false
+		;;
+	*)
+		(ulimit -s 128 && "$@")
+		;;
+	esac
 }
 
 test_lazy_prereq CMDLINE_LIMIT 'run_with_limited_cmdline true'
 
+# On Cygwin, ulimit has no effect because the underlying API hasn't been
+# implemented.  Just fail if trying to do something with ulimit.
 run_with_limited_stack () {
-	(ulimit -s 128 && "$@")
+	case $(uname -s) in
+	CYGWIN*)
+		false
+		;;
+	*)
+		(ulimit -s 128 && "$@")
+		;;
+	esac
 }
 
 test_lazy_prereq ULIMIT_STACK_SIZE 'run_with_limited_stack true'
