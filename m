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
	by dcvr.yhbt.net (Postfix) with ESMTP id 72A301F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 14:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfKOOnC (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 09:43:02 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:55074 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbfKOOnC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 09:43:02 -0500
Received: by mail-wm1-f46.google.com with SMTP id z26so9882224wmi.4
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 06:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ulXd4IThug2U96xg6JWSWBuRUK5z8mgnfvbgtowERFM=;
        b=nNvduCKAd8DdXXEWfgqRcWX5MxcDaAdEDwlyFYl8Vo2weonfc13PxtaWOzyyd8Kp4b
         jWOOotv/8rypVspfRWmX3dQH8N1X0V2cJIcxh2PnbXwV67GbqUpgxzsUZWla1xCNS/XD
         i/DV2dgIo+9QJnSukDNTNPAgAyVTXggeuFy5C9FcT4IAfyLnoRs2TMH+hA+AHdC/YZ+B
         WKC2k5abjPSv4mA0K48d9MvVbP1kjntEry+XkP14I4J/JWqwE7vnd2+Hxs7Fpw4Th/M/
         yjwLxcbHoMOti7x5YUj1IQq4iIBHRMVbo6aP3gixVA8uIcYIdBTG3KfhlOsZ3TDInCm4
         7kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ulXd4IThug2U96xg6JWSWBuRUK5z8mgnfvbgtowERFM=;
        b=S8vmpWpcwM8RklnTqDWS5Wf8r6Kc4iX6r7ExktOolHzsQJ+C9017zABsQXNOiUpBFn
         ndgO26/23xiu5fql3W6xsmMR+6s1QOpJUINTek/fAY4r535tFo9BYzzdh5JKnQIsmMMp
         DsL5eutYl+sHP3HKnpjPSUBVUN/kBJhdytZDT5vhHMxHMAoE+Z/+EHAopefGaCXio4I9
         9fRY+doC/X5ddZJQ2g085nuXZR0nFcH7NvYU0RqfUd/wHyMsacDHZwWFR78RQR35EDmf
         v4VdBiqsCX/cTua8GGicU5hY4/DQWUazUcKB2Lf2DWKPKOpe5IYgGxksePwmA64gW12q
         uT+Q==
X-Gm-Message-State: APjAAAXlb9+2XxVHdYmBmVW4Fus75R+BRQr8VPtjZmV694U9ouaSeOnb
        0lD4leE0baeiSEFTF495JIwm+feQ
X-Google-Smtp-Source: APXvYqwW44/9HJr8Xm3T00m2mrtZKfU0HxrWRDTTRtJ6eCSrTtl5J/0+drGDAHq7hYmkX2JJl+ZdyQ==
X-Received: by 2002:a1c:6146:: with SMTP id v67mr15279387wmb.102.1573828980048;
        Fri, 15 Nov 2019 06:43:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j66sm9055086wma.19.2019.11.15.06.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 06:42:59 -0800 (PST)
Message-Id: <0bca930ff82623bbef172b4cb6c36ef8e5c46098.1573828978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.465.v2.git.1573828978.gitgitgadget@gmail.com>
References: <pull.465.git.1573679665.gitgitgadget@gmail.com>
        <pull.465.v2.git.1573828978.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 14:42:56 +0000
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

