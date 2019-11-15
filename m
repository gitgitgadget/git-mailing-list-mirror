Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A22901F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 14:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfKOOjV (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 09:39:21 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:44597 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfKOOjV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 09:39:21 -0500
Received: by mail-wr1-f51.google.com with SMTP id f2so11234766wrs.11
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 06:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ulXd4IThug2U96xg6JWSWBuRUK5z8mgnfvbgtowERFM=;
        b=rZgka7bmkVJgOSrIRj65vbbpelQc8s5gZ40fdrpXJrnzdq2xebDoDObWeJ9Q/OtuIg
         4wIojsuzyPefwgeq/wY8Sr5tsIOSZ5u170tN1H42uEEj0xXXuAISts3vMvCktyFG79yG
         y4X0j2RAS4K2q0IF1yi5IFn4Ws1dRCGjQxLcyVF898u5anoR7MTOZo820FB/2tDMQFgb
         7Feg4z8KY79V7WX9+b6/bnHAlnPbl6nhF58ADGr3epwIz5J0AGcwTvQihLBwmeosPDy9
         +5+AI5rtr0sCNW1Trs2OFfpA0mnSAzqwKugI4fB2Oq22TxXFB1DZ5RX6YVV82PNDpTz7
         hnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ulXd4IThug2U96xg6JWSWBuRUK5z8mgnfvbgtowERFM=;
        b=S8JYmdm6Obon5TDGHFyMXuAdTOoRF8ZAkrcXJ6negu3Lf9BJwV91/MNM/yoTQzLVvl
         ojPqu4GymN8/Eby3a/liXdyuWg/KNi2g7Dw2tFx4LGzQNcuUiVjroOo2Yn1Nt8ZuQebZ
         4g+//0n31R4dVBJ7VRQOYi27Efp2HMmgYqn+r9XVyMlWci3M8kNA0u+VOTaArXSBSTb2
         nUpCsm+vYHO4ZUDQV3XSfO/KZ9ecLML1hqIFymUY2wx4SrSismd7FMqR0G8jHKzFJpXL
         g8VbjqZd22eJE3tTCaqeNOU9Qr7G73u25o+lX9B1CbJnSgaoXvPNIJyJHJ+Tazxt34a3
         Hg+Q==
X-Gm-Message-State: APjAAAVvmZumndKz/fMoKG1uq0dCpLGcDSGw4NcJhO0YDsdmwgfgoJqa
        wkAgj4cCP70XkJdk3ZlEyEonDrYu
X-Google-Smtp-Source: APXvYqyMUuzKQLAPvYMzKwdqnWOTi/qj6dlu9nOilltjIsmEifjOeM1vbTqZ3R2mMAaR2gA83GN5Ow==
X-Received: by 2002:adf:d1a3:: with SMTP id w3mr16899909wrc.9.1573828758657;
        Fri, 15 Nov 2019 06:39:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c24sm14221631wrb.27.2019.11.15.06.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 06:39:18 -0800 (PST)
Message-Id: <0bca930ff82623bbef172b4cb6c36ef8e5c46098.1573828756.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v2.git.1573828756.gitgitgadget@gmail.com>
References: <pull.463.git.1573679258.gitgitgadget@gmail.com>
        <pull.463.v2.git.1573828756.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 14:39:14 +0000
Subject: [PATCH v2 1/3] Cast byte strings to unicode strings in python3
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Keene <bkeene@partswatch.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <bkeene@partswatch.com>

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 60c73b6a37..6e8b3a26cd 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -36,12 +36,22 @@
     unicode = str
     bytes = bytes
     basestring = (str,bytes)
+    isunicode = True
+    def ustring(text):
+        """Returns the byte string as a unicode string"""
+        if text == '' or text == b'':
+            return ''
+        return unicode(text, "utf-8")
 else:
     # 'unicode' exists, must be Python 2
     str = str
     unicode = unicode
     bytes = str
     basestring = basestring
+    isunicode = False
+    def ustring(text):
+        """Returns the byte string unchanged"""
+        return text
 
 try:
     from subprocess import CalledProcessError
@@ -196,6 +206,8 @@ def read_pipe_full(c):
     expand = isinstance(c,basestring)
     p = subprocess.Popen(c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=expand)
     (out, err) = p.communicate()
+    out = ustring(out)
+    err = ustring(err)
     return (p.returncode, out, err)
 
 def read_pipe(c, ignore_error=False):
@@ -263,6 +275,7 @@ def p4_has_move_command():
     cmd = p4_build_cmd(["move", "-k", "@from", "@to"])
     p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
     (out, err) = p.communicate()
+    err = ustring(err)
     # return code will be 1 in either case
     if err.find("Invalid option") >= 0:
         return False
@@ -646,10 +659,18 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
             if skip_info:
                 if 'code' in entry and entry['code'] == 'info':
                     continue
+                if b'code' in entry and entry[b'code'] == b'info':
+                    continue
             if cb is not None:
                 cb(entry)
             else:
-                result.append(entry)
+                if isunicode:
+                    out = {}
+                    for key, value in entry.items():
+                        out[ustring(key)] = ustring(value)
+                    result.append(out)
+                else:
+                    result.append(entry)
     except EOFError:
         pass
     exitCode = p4.wait()
@@ -792,7 +813,7 @@ def gitConfig(key, typeSpecifier=None):
         cmd += [ key ]
         s = read_pipe(cmd, ignore_error=True)
         _gitConfig[key] = s.strip()
-    return _gitConfig[key]
+    return ustring(_gitConfig[key])
 
 def gitConfigBool(key):
     """Return a bool, using git config --bool.  It is True only if the
@@ -860,6 +881,7 @@ def branch_exists(branch):
     cmd = [ "git", "rev-parse", "--symbolic", "--verify", branch ]
     p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
     out, _ = p.communicate()
+    out = ustring(out)
     if p.returncode:
         return False
     # expect exactly one line of output: the branch name
-- 
gitgitgadget

