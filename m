Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A8431FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 20:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbcHZU0h (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 16:26:37 -0400
Received: from mout.web.de ([212.227.17.12]:53963 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751014AbcHZUZw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 16:25:52 -0400
Received: from atze2.lan ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0McFPX-1bNlz93z1j-00JYP0; Fri, 26 Aug 2016 22:19:17
 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 1/2] git ls-files: text=auto eol=lf is supported in Git 2.10
Date:   Fri, 26 Aug 2016 22:18:45 +0200
Message-Id: <20160826201845.28341-1-tboegi@web.de>
X-Mailer: git-send-email 2.9.0.243.g5c589a7
In-Reply-To: <xmqqpoowlgpv.fsf@gitster.mtv.corp.google.com>
References: <xmqqpoowlgpv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:CIwUwsh/G2UorpZ1bpiVzJKkKfsM8Q+dEH4uhV5pyW9ZwfssVtb
 So3I7HyfJbNV8+0Pu4rC4JUhrjuq2RQC7bT5ZGLk980fBjzKrJnD1z4meO0vCeVDZcaUlWl
 dbOHUXUtRShCxPdXBo5iF6R+oROdpv3JV5iZR7jjZ4g2IQKMO3t30GPXxXgOI4RGBcZq5xW
 N9aWz2UDA6T4TcsoCmomg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n4fLULh92KI=:ItM631+XfwiclWyxyuFewe
 g2RUdHgrbuF0rHjAPV2Di4d6XNTGXD3yQB8IQXQ5SGRj2YVdUdnI6R47ij4BhwEcRVAFMB9Sk
 hr4aKGiZsvT+lfA84cQB9jIZQ66WR/PLmR9KKJxxx6ZtmPdWAqk3gVWGXrpYdBsPAkMHKYu4/
 dxPQcKldFphK4NHkpcXcYFgW8fS1NIw7IByLcsUKXNlRc6FiRnacNkZix+1jXPRM6QiNwt8bw
 pB3j7UA6eM/lQ85pPLtcpvarkPvnZBQXnBEBxBJYOOSYOjh3RKvFQVRi+g9VWlsObUFuZfLQQ
 vO/EDRf5eFOA2wZLbJzzmfJoUvddOUD6AKP+b+SQQMYFHhzrz/NtEgWk7vSrONvLIeSjDvRg+
 WSBMA/ekjcHtEzngHJ2HLmdfTPcQeIUbi+6HjvTI+Dg+5O/SWS50+gETEiyAQ0jHlfVMGNNu8
 N63C1BA+ev9le1guXMLsREhF0fCleAj0O19QuhqYE59qhIS3MGPWnu8aCgnGYhAi9uYosDqsS
 qmyY3SFX3uIpszxbsZGT5BVQ+in0vpgXSoVTZSwTLyN6f7vCcVsXIhGZWEGElDSgnhC6Wc0rT
 OmBD25Qf3q2Z9e9Vakr2UP5Xi7mhWBqXrGggoKEJNbEOnCYdfxuaa7k02BwZ8k0gWRa2+0Bf9
 YsoqQI4lYxBxTvzgzUtcUK0C+8bet1/8KbfyM7XDIaQkWuiHqniKKb7ELewXCUGwFDX7tIlsp
 THagrw1hrLxf3ZhA2cT7vANChAhDfVsf3/UqflVI3r8MrPpXXolitYBRWaR7jhsV1iKewXPrm
 blACsdK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

The man page for `git ls-files --eol` mentions the combination
of text attributes "text=auto eol=lf" or "text=auto eol=crlf" as not
supported yet, but may be in the future.
Now they are supported

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 Documentation/git-ls-files.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 078b556..0d933ac 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -159,8 +159,7 @@ not accessible in the working tree.
 +
 <eolattr> is the attribute that is used when checking out or committing,
 it is either "", "-text", "text", "text=auto", "text eol=lf", "text eol=crlf".
-Note: Currently Git does not support "text=auto eol=lf" or "text=auto eol=crlf",
-that may change in the future.
+Since Git 2.10 "text=auto eol=lf" and "text=auto eol=crlf" are supported.
 +
 Both the <eolinfo> in the index ("i/<eolinfo>")
 and in the working tree ("w/<eolinfo>") are shown for regular files,
-- 
2.9.0.243.g5c589a7

