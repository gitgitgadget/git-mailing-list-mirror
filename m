Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84C9C1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 20:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbeDFU0Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 16:26:24 -0400
Received: from dmz-mailsec-scanner-2.mit.edu ([18.9.25.13]:52960 "EHLO
        dmz-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751886AbeDFU0X (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Apr 2018 16:26:23 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Apr 2018 16:26:23 EDT
X-AuditID: 1209190d-b57ff70000003e45-e9-5ac7d6c2a953
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by dmz-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id C5.1A.15941.2C6D7CA5; Fri,  6 Apr 2018 16:21:22 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH-1.MIT.EDU [18.9.28.11])
        by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id w36KLLeB023242;
        Fri, 6 Apr 2018 16:21:22 -0400
Received: from localhost (MASS-TOOLPIKE.MIT.EDU [18.9.64.17])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id w36KLJiP015640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 6 Apr 2018 16:21:20 -0400
Date:   Fri, 6 Apr 2018 16:21:19 -0400 (EDT)
From:   Anders Kaseorg <andersk@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: =?UTF-8?Q?=5BPATCH=5D_Documentation=2Fgit-bisect=2Etxt=3A_git_bisec?=
 =?UTF-8?Q?t_term_=E2=86=92_git_bisect_terms?=
Message-ID: <alpine.DEB.2.21.999.1804061619450.49386@mass-toolpike.mit.edu>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsUixCmqrXvo2vEogz9L1C26rnQzWTT0XmF2
        YPK4eEnZ4/MmuQCmKC6blNSczLLUIn27BK6MP/8esRe8Y6t41vGLvYHxLmsXIyeHhICJxLuD
        E5hAbCGBxUwSz85qdjFyAdkbGCWm31nIDuHsZJL4u+EjWAeLgJbEkqubWUBsNgE1iQ9Hv4LF
        RYDsiW2HwOLMAuISm5a/AZsqLFAn8bXrNZjNK+At8eLidnYQW1TAQOLIxhYWiLigxMmZT6B6
        tSQe/rrFMoGRdxaS1CwkqQWMTKsYZVNyq3RzEzNzilOTdYuTE/PyUot0jfRyM0v0UlNKNzGC
        g0iSdwfjv7tehxgFOBiVeHgLuo9HCbEmlhVX5h5ilORgUhLlPWgPFOJLyk+pzEgszogvKs1J
        LT7EKMHBrCTCy7wNKMebklhZlVqUD5OS5mBREuddtH9vlJBAemJJanZqakFqEUxWhoNDSYLX
        CBgtQoJFqempFWmZOSUIaSYOTpDhPEDD7UBqeIsLEnOLM9Mh8qcYFaXEeW1AEgIgiYzSPLhe
        SJQ7CL5iFAd6RZj3yVWgKh5ggoDrfgU0mAlo8ITEIyCDSxIRUlINjKKLj74Q6TjUqT65szBY
        NGie/rTfBz+qO6bMmXeXaX6S17pDa5/WfvFsPbs61mPCgv1/eiPX3vox9Wbwn73nWJb82Hvw
        0sfyOeW7MzdXTOk5uOzvnsmSviuubfs36fcCl08OV56tfvfnUE3ucu/mlFMq9z+5vTlzk/l+
        fVJ+/ZUTAqzTLlzd6qlgqMRSnJFoqMVcVJwIAL/sqPrNAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 Documentation/git-bisect.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 4a1417bdcd..4b45d837a7 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -165,8 +165,8 @@ To get a reminder of the currently used terms, use
 git bisect terms
 ------------------------------------------------
 
-You can get just the old (respectively new) term with `git bisect term
---term-old` or `git bisect term --term-good`.
+You can get just the old (respectively new) term with `git bisect terms
+--term-old` or `git bisect terms --term-good`.
 
 If you would like to use your own terms instead of "bad"/"good" or
 "new"/"old", you can choose any names you like (except existing bisect
-- 
2.17.0

