Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BFD1207EC
	for <e@80x24.org>; Sun,  9 Oct 2016 13:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751488AbcJINYq (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 09:24:46 -0400
Received: from mout.web.de ([217.72.192.78]:49338 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751152AbcJINYq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 09:24:46 -0400
Received: from [192.168.178.36] ([79.213.121.94]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M3SxQ-1b2V0l0EV6-00qwnn; Sun, 09 Oct 2016 15:24:27
 +0200
Subject: Re: %C(auto) not working as expected
To:     Tom Hale <tom@hale.ee>, git <git@vger.kernel.org>
References: <cb81631e-9623-9020-f955-ec215b493a50@hale.ee>
 <f35965e9-2901-b9b5-92e5-9bc7fe673637@web.de>
 <65d8def3-df62-6c45-7d8f-79b6a8769bf5@hale.ee>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Message-ID: <25c17e16-2456-7da3-ae22-2dc812a3aa0d@web.de>
Date:   Sun, 9 Oct 2016 15:24:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <65d8def3-df62-6c45-7d8f-79b6a8769bf5@hale.ee>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:slNZaSMgmHwBU9L6wUouIXuEpGupQxEP8FtnccSwFH0hmUDnNX7
 DjGI0NBjXKSAeY6nmeRWExye315ie9U9ovuOscFssRr3BQbrobKnuFAuqTKlJiWZ/gurZ9i
 ScGnJOmi8E2n3AC93VjIQytc/SI1WquMBTIMcNqWFuYp7UYU9YwSefZDWNlC6bltOT8Y4BP
 tcT/tl+6vdrIyZ1plTakA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+UuU4d0bN/8=:ZLtQGl8TOCRdbHNtpvbSV1
 sQEex5aFg4dUo16k9SytUnJvGN+Rd/7Qz/ckYQytYOlM6hEgZtglfXWbciCKnUIihDftbMK6W
 GRRjffSbClyRUVn+/+N0uhGpFU4WVbRuQhDojAiRFnKZKq13jsVV0MS+gfuvK0wLToZFYpNcr
 B4JgkwdiLlgJOgQG6dgK7xImUAgPIDYhccilYK+qnkyqV74f40pJL66SzuMgt9Sex2hOs7s/o
 g9YfTD/RW6TXKMw/5a1GSWYInHKF3vbGPJ9kiDklksdVDzLCVBothl9OChWIm7bHHbJmYoXX/
 /skvSOuqlT+pL5SL16jv9WbtE9BEn9KF821IF0UVrXzPDlvuQ8s3z3/9KE5MuBD2UdJstSeE9
 lrBoQMw4IN6kosTPB5EKR0GwzZX5YeJMdL/Sd5uNgz3En5X2O16iDZyKH5JlkWXoTUUcuTajB
 tKyhO+hvYIBx70+QuG+YZpcG4kv+jK4phy5Hk+sYrINPpaIAY548nlOSdEmjNpSmcMKAKwHt0
 QAwt3Yqgy5zSbt8t7yog+lLN/a/+oeacSdWK+TeILuJJ5BUZiXmh8ZPOqrwuSrY2FDUEsMnXV
 43ksTV+XJE6GxWhDBDH35PyVEYjc1LEeJcsvHK0H7fwNZ3ic1IP179TyrS4wD//1otiLVm/kt
 sMWxofAwBB9LawFiZFhXJUepjuR4cxmoyNDiPaj/MwMjaoTa7SluPMEFUV5LkTk/fgsmH08t6
 N1m3gmxHW6grS+8RkxQOlTBRwo5aYchR4FdkTsNcQsekjGR2e/5zaKiiXeRbyAWM62bVloLMg
 uRzB2n9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.10.2016 um 12:04 schrieb Tom Hale:
> On 2016-10-09 13:47, René Scharfe wrote:
> 
>> %Cgreen emits color codes unconditionally.  %C(auto,green) would respect
>> the config settings.
> 
> Thanks, I've never seen the (,) syntax documented before!

Both the prefix "auto," for terminal-detection and "%C(auto)" for
choosing colors automatically are mentioned in the manpage for git log
(from Documentation/pretty-formats.txt):

- '%C(...)': color specification, as described in color.branch.* config option;
  adding `auto,` at the beginning will emit color only when colors are
  enabled for log output (by `color.diff`, `color.ui`, or `--color`, and
  respecting the `auto` settings of the former if we are going to a
  terminal). `auto` alone (i.e. `%C(auto)`) will turn on auto coloring
  on the next placeholders until the color is switched again.

> What's strange is that this works:
>   %C(auto,green bold)
> but
>   %C(auto,green,bold)
> does not.

Looking at the code that's not surprising; colors and attributes are
interpreted as a space-separated list.  The prefix "auto," is handled
specially.  For a user it may look strange, admittedly.

Supporting "auto " as well would be easy.  Supporting it in such a way
that it can be mixed freely with colors and attributes as in
%C(bold auto green) would be a bit harder.  Could this lead to confusion
between the auto for terminal-detection and the one for automatic color
selection?

The documentation cited above says the color specification was explained
together with the color.branch.* config option, but that part only says
(from Documentation/config.txt):

color.branch.<slot>::
        Use customized color for branch coloration. `<slot>` is one of
        `current` (the current branch), `local` (a local branch),
        `remote` (a remote-tracking branch in refs/remotes/),
        `upstream` (upstream tracking branch), `plain` (other
        refs).

It really is described earlier in the same file, in the Values section
(a fitting place, I think).  Here's just the first sentence:

color::
       The value for a variable that takes a color is a list of
       colors (at most two, one for foreground and one for background)
       and attributes (as many as you want), separated by spaces.

Patch below.  Does it help a little?

> Also:
> Given it's very rare to want only part of a string to emit colour codes,
> if something like "bold" carries through until a "no-bold", why doesn't
> "auto" do the same thing?

No state is kept for "auto,".  Attributes and colors are switched
separately by terminals, that's why e.g. bold stays in effect through
a color change -- unless you specify an attribute change as well.

Offering a way to enable terminal-detection for all color codes of a
format would be useful, but using the existing "auto," prefix for that
would be a behaviour change that could surprise users.

René


-- >8 --
Subject: [PATCH] pretty: fix document reference for color specification

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 Documentation/pretty-formats.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index a942d57..89e3bc6 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -166,7 +166,8 @@ endif::git-rev-list[]
 - '%Cgreen': switch color to green
 - '%Cblue': switch color to blue
 - '%Creset': reset color
-- '%C(...)': color specification, as described in color.branch.* config option;
+- '%C(...)': color specification, as described under Values, color in the
+  "CONFIGURATION FILE" section of linkgit:git-config[1];
   adding `auto,` at the beginning will emit color only when colors are
   enabled for log output (by `color.diff`, `color.ui`, or `--color`, and
   respecting the `auto` settings of the former if we are going to a
-- 
2.10.1

