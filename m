Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 319A01FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 16:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbdA3Qww (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 11:52:52 -0500
Received: from mout.gmx.net ([212.227.17.22]:63687 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752528AbdA3Qwa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 11:52:30 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LuKHz-1cNXyF1jXz-011ml1; Mon, 30
 Jan 2017 17:52:20 +0100
Date:   Mon, 30 Jan 2017 17:52:16 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Bob Proulx <bob@proulx.com>
cc:     git@vger.kernel.org
Subject: Re: git-daemon shallow checkout fail
In-Reply-To: <20170129002932.GA19359@dismay.proulx.com>
Message-ID: <alpine.DEB.2.20.1701301719590.3469@virtualbox>
References: <20170129002932.GA19359@dismay.proulx.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uf/lbpDJorLUpJRiMgE+ein2dzcEooCNV5DZQkKM2s4XWxy6BkR
 vivjnf5Zjwh1ltUpTfUuQbH7F0npYcedArFDRSLubyYMXNJutOdER/1IMhU6Zm5dBRJRjd9
 sV/f5y7Gy2b+xigw3M05KJ7x+4onI8hL1mxyLb4NmuZGRjHTCsd7MAip2KpVkIXXHZy2hvB
 IS4TX24DqfmZ1Ag1O2mBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nn9lL7jmi+c=:G39C/h0z+NrcQ2Vup/BXhe
 fqoSMcKR/rCAXsQx7VViASSXjBLzG+ZOm16j5V0JN4ha7A+f4o3FmYiv9ePUBxjN+4ywD8B2g
 SCbOpLw7Bc2tu82HZHjzLmMGsGGWlnCrA240V8JCMxRcvWCfr0nKC2WU/0v7gh4Qe6Gi+Vicf
 UOHIEvAk2Um7jyujWYviPfUtpZSJ3TJr2f7cA40p0BoaRWPKbX1cKfWjAWymV0OCU0eF8eCp6
 p2WDB/KDbZMppVCH6DHvUYmUq29L2qmTP9AOTzDb8CXHBSHliWyjlG4cnZI/oJ8b1eZUnnBNw
 WgVlRnV6I4gma/1SPWNQ1Ow7tSm4v+ctLUZuMl4TanakCGQacxorHa3wE5YhcrEAFXx125A4K
 ++Kf+XQA4VDcmWhxhZ/sBaYeC8tNgdvfuVwfNywoVhknsx076EI3lu4ouQsfud91mbzwnZU+b
 dfnNKFg0/tCmlcXhq9hsuxSwEknU2xKvTN6dOgUqAckqo3XRPIDTs8LqI7AEtGFIk8zdNDx5a
 kIwSsMhNg39dQOgFxWNoFTuB1RPUcQ0LFaHJcIUvY1QKWy4h9GNIRvzpqBPs7FWy1B1iWhPPc
 wQqQE9AtZTq+iOxHD9AVHkSvLC5uck/8hAj7+lBkftNGHDRfNBx3/6KYwZgN5OS1sJRaOTKJZ
 aL7CKcXxc9fGR6WsFGO+fHaCs/yr3Cu3WOwBw/wL+5hZpJ8QbEJaT3GAQGsW7Gv6kvDFDikd5
 cVx7PNQQGJmOTMlQZykg7gMxvZTFaJLOpvdtkuxit7adSX2entk7xa/n2FbURH6tKlARkWnsw
 CmKOvD0Zo1dyf3HY9LhJg7gLhePv/nYykAsVlo9t//fnm2j+bg6VYPatPlHn9m0jW+6muJgTW
 Yi7KwrcqWUG131LxpTvNKZW8PcxTP3TESHKKAhDAEajBX4uGCr0tCtmG3+wEDEsiwpGfFqQu3
 lV413P+yZ03qYW5dwQoHag4+3XJAh8pUOpotMcLHYU9plXFkdzODVDMy+4nlvhylKHJHRHGjx
 IO1v9lWdnzz4+mvNIlmmudr/ii51bBvdbgIptLoFx54ytnJ16Tn9GvAoC3LNeCQLFQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bob,

On Sat, 28 Jan 2017, Bob Proulx wrote:

> And the server side says:
> 
>   [26071] Request upload-pack for '/test-project.git'
>   [26071] fatal: Unable to create temporary file '/srv/git/test-project.git/shallow_xKwnvZ': Permission denied
>   [26055] [26071] Disconnected (with error)

Assuming that you can rebuild your Git with debug symbols and without
optimization (simply remove the -O2 from CFLAGS in the Makefile, I never
had any luck with single-stepping in gdb when compiled with -O2), you
could attach gdb to the git-daemon and/or upload-pack process. Setting a
breakpoint on die_builtin in the failing process should give you a good
idea why things are failing, at least looking at the stacktrace.

A few more tidbits from a cursory look at the Git source code with `git
grep` and the likes:

- that error message comes from shallow.c's setup_temporary_shallow()
  function

- that function is only called from fetch-pack and receive-pack, neither
  of which should be called by upload-pack, so it is a puzzle

- adding a test case to t5570-git-daemon.sh that tests specifically your
  described scenario seems *not* to fail:

-- snip --
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 225a022e8a..0256c9aded 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -186,5 +186,17 @@ test_expect_success 'hostname cannot break out of directory' '
 		git clone --bare "$GIT_DAEMON_URL/escape.git" tmp.git
 '
 
+test_expect_success POSIXPERM 'shallow clone from read-only server' '
+	test_when_finished "rm -rf tmp.git" &&
+	repo="$GIT_DAEMON_DOCUMENT_ROOT_PATH/readonly.git" &&
+	git init --bare "$repo" &&
+	git push "$repo" HEAD &&
+	>"$repo"/git-daemon-export-ok &&
+	chmod a-w "$repo" &&
+	test_must_fail \
+		env GIT_OVERRIDE_VIRTUAL_HOST=.. \
+		git clone --depth 1 "$GIT_DAEMON_URL/readonly.git" tmp.git
+'
+
 stop_git_daemon
 test_done
-- snap --

- I even modified t/lib-git-daemon.sh to start the daemon as `nobody` and
  kill it as `root`, and I won't share that patch because it is as
  ugly, but *even then* the test succeeded.

So my suspicion is that the repository you try to serve may already be
shallow, or something else funky is going on that has not been included in
your report.

The most direct way to get to the bottom of this may be to do something
like this:

-- snip --
diff --git a/shallow.c b/shallow.c
index 11f7dde9d9..30f5c96d50 100644
--- a/shallow.c
+++ b/shallow.c
@@ -288,12 +288,18 @@ int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
 
 static struct tempfile temporary_shallow;
 
+static int debug_me;
+
 const char *setup_temporary_shallow(const struct sha1_array *extra)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int fd;
 
 	if (write_shallow_commits(&sb, 0, extra)) {
+error("About to create shallow_XXXXXX: pid = %d", getpid());
+while (!debug_me) {
+	sleep(1);
+}
 		fd = xmks_tempfile(&temporary_shallow, git_path("shallow_XXXXXX"));
 
 		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
-- snap --

Then let it run, wait for the error message "About to create
shallow_XXXXXX" and then attach with a gdb started as nobody via `attach
<pid>` to see the stack trace.

That should give you an idea where that code path is hit (unexpectedly).

Ciao,
Johannes
