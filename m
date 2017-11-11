Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEE1F1F43C
	for <e@80x24.org>; Sat, 11 Nov 2017 14:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbdKKOKU (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 09:10:20 -0500
Received: from mout.web.de ([212.227.15.3]:63535 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751257AbdKKOKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 09:10:16 -0500
Received: from [192.168.178.36] ([91.20.58.47]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MEqOg-1eSR0J08L4-00G0LB; Sat, 11
 Nov 2017 15:10:13 +0100
Subject: Re: Invalid memory access in `git apply`
To:     mqudsi@neosmart.net, git@vger.kernel.org
References: <0101015f9c91871f-2f750aec-6877-4e29-9c15-c8399670dd48-000000@us-west-2.amazonses.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Message-ID: <fdc7b058-e891-6d74-adad-f7e9a853e420@web.de>
Date:   Sat, 11 Nov 2017 15:10:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <0101015f9c91871f-2f750aec-6877-4e29-9c15-c8399670dd48-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:WvWglI69eyxo8UbmvA7gYDCpzZ98ubLPg8YzHeyfLSEsYfIqrYd
 5oDLGAE4TlgEJWKNW9fHQU5jD4tkB52ox2GPfIZrn20JhwxmOfVfLIoRbTUYKYUzjSDlxVF
 xcowoOeGYPAPVWsQxjjSthiE2QhlKqigaQaVgwyGw2Pm9kyuzLquhh4daT+vbCMF4cx6WCF
 q1IBevx5cjkkgNgrZ10WQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dcJIzTNqrfA=:6FYVg/YLqmMW8y1ID5RRUG
 v+4pPF7kfA6j1TAyMBZtasBGyiBHqSw9TnHEJiF84l1eAvgvcEON6l42D+dEBXt19Rj9ABE+i
 bhWU4XMp3Q03J1QYcgANCygdTW+6ZkHZh1nOE2BZLJFAsVZh5b0ucqdFnuvxbFIFYX9rYn6oY
 BFAgbyKAN0YC2r5DaN1FclbsnRf17zuYi5lzy/UBow9Ydnzev9BsGlkH2yucGFMB+63IBm+M9
 7JC/PLKznggnPGbfidS4wmz+HzMyUtsKx94LVsfJLqXewFy2FphCgHUMnjCLqe7DVnwdgoFPk
 cNplrebmmEJ09P79EO9Jre/kuemIwEooRjGFwkZJVcBOV+dhIxz/7Amvyyjy4mb/MR1lkhxdP
 wXpy/K7wL9fVg3OzkccC/V8BYUlMEi3PUyYo/PJ6JuLB90Cl4CXdK+pO1kLOtpxu7Wkc96pjM
 f6Q9XOWYQ2JWY9xSC1Q/kVlmq1xvI/1bm6sVkvrHfNRRuTCk5yscN/YDfQ+ruzHMSjEb7IBkg
 +L+b049QDrwxneurmKf6KIF0fry6rYrD3sB/odFeczDScoVRxhBkNo9zq2vgMKeBox7GOEcVF
 IH0U+vgTfxPx2jfwj7gKVMEFodFHaI8EDlhFgeqQYyzQLchiTyBoq/ZO1R0GkhUEvnez2xeWa
 pWayrUHQleAmDVAlR4qUstRZt7Xw10eoRtNdYJvn/2vsiMeD5HCcf9oiZP1vwSKG+wf7cSdOv
 s+PaSYPQad3RI5KA70LRrZU9kmOLln/glbrjXxYZkhAemYk5YanaQzDJWf4CRe0XSrluwQt7b
 RdikhRbfAZXhKPkNbvYrJj328CJsHayX4ZbXpCbmvVAZiDXpOM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.11.2017 um 17:58 schrieb mqudsi@neosmart.net:
> **Resending as it seems that the attachments caused the last email to wind up
> in a black hole**
> 
> There seems to be bug in the `git apply` that leads to out-of-bounds memory
> access when --ignore-space-change is combined with --inaccurate-eof and
> applying a patch.
> 
> On occasion, this can lead to error output like the following:
> 
> 	 mqudsi@ZBook ~> git apply --ignore-space-change --ignore-whitespace
> 	 --allow-overlap --inaccurate-eof without_whitespace.diff
> 	 *** Error in `git': malloc(): memory corruption: 0x0000000002543530 ***
> 	 ======= Backtrace: =========
> 	 /lib/x86_64-linux-gnu/libc.so.6(+0x777e5)[0x7fdda79c77e5]
> 	 /lib/x86_64-linux-gnu/libc.so.6(+0x8213e)[0x7fdda79d213e]
> 	 /lib/x86_64-linux-gnu/libc.so.6(__libc_malloc+0x54)[0x7fdda79d4184]
> 	 /lib/x86_64-linux-gnu/libc.so.6(_IO_file_doallocate+0x55)[0x7fdda79bd1d5]
> 	 /lib/x86_64-linux-gnu/libc.so.6(_IO_doallocbuf+0x34)[0x7fdda79cb594]
> 	 /lib/x86_64-linux-gnu/libc.so.6(_IO_file_overflow+0x1c8)[0x7fdda79ca8f8]
> 	 /lib/x86_64-linux-gnu/libc.so.6(_IO_file_xsputn+0xad)[0x7fdda79c928d]
> 	 /lib/x86_64-linux-gnu/libc.so.6(fputs+0x98)[0x7fdda79be0c8]
> 	 git[0x5386cd]
> 	 git[0x538714]
> 	 git[0x538940]
> 	 git[0x40e220]
> 	 git[0x410a10]
> 	 git[0x41256e]
> 	 git[0x412df7]
> 	 git[0x415935]
> 	 git[0x406436]
> 	 git[0x40555c]
> 
> The original file being patched (clipboard.vim) and the patch file that I had
> attempted to apply (without_whitespace.diff) are attached, along with the
> full, unabridged output of the memory map as a result of the out-of-bounds
> access (memory_map.txt).
> 
> The memory map output was generated under git 2.7.4; repeated attempts to
> reproduce the memory map dump with both 2.7.4 and 2.15 produce the following
> output:
> 
> 	 mqudsi@ZBook ~/.c/nvim> git apply --ignore-space-change  --inaccurate-eof
> 	 --whitespace=fix without_whitespace.diff
> 	 fatal: BUG: caller miscounted postlen: asked 248, orig = 251, used = 249
> 
> Mahmoud Al-Qudsi
> NeoSmart Technologies
> 
> --Attachments--
> 
> * clipboard.vim: http://termbin.com/u25t
> * without_whitespace.diff: http://termbin.com/bu9y
> * memory_map.txt: http://termbin.com/cboz

Thank you for reporting the issue!

There seem to be at least two bugs in git apply and two problems on your
end.  You don't seem need the option --inaccurate-eof and it's causing
trouble for you; I suggest to leave it out.

And the second hunk of your diff doesn't apply because the "<TAB>endif"
context line doesn't match the "endif" line in clipboard.vim which has
no leading whitespace.  --ignore-space-change ignores changes in the
number of whitespace characters, but that number cannot be 0 on only one
side.

If you adjust the diff by removing the tab from that context line or add
one or more spaces in clipboard.vim before the last "endif" then it will
apply without --inaccurate-eof.


One of the bugs is that fuzzy_matchlines() does out-of-bounds reads in
some cases.  You should only notice it with a tool like Valgrind, ASan
or perhaps a hardened malloc(3).  I'll send a separate patch for that.

The second bug is that --inaccurate-eof triggers a sanity check when
used together with --ignore-space-change.  Here's a simpler reproduction
recipe:

  git init repo
  cd repo

  echo 1 >a
  git add a
  git commit -m initial

  echo 2 >a
  git diff >a.diff
	
  git reset --hard
  git apply --ignore-space-change --inaccurate-eof a.diff

Which yields this error message:

  fatal: BUG: caller miscounted postlen: asked 1, orig = 1, used = 2

Perhaps the first thing we'd need would be a couple of tests showing
the expected behavior of git apply --inaccurate-eof with and without
trailing newlines..

René
