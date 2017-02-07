Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B6C51FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 20:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754963AbdBGU4S (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 15:56:18 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35204 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754509AbdBGU4R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 15:56:17 -0500
Received: by mail-wm0-f45.google.com with SMTP id v186so28064702wmd.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 12:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:content-language:thread-index;
        bh=DChNe1Vt2itx018CMoABCj26Su5X5bhxwcy1AiV6rEQ=;
        b=kOE/+H4dk+UubK7AxdjKtE3kt++DWV3Ho3ttR9JtMdDcXiF/xLr/uNatbEZ1THTQTz
         lMCKkaNXh2+C0IT/ZZcnb/pMN2aaBWs17gCbLT08IujDEr7u9ZWTM9zdA5xwfYxdqK6A
         hYE7E5FQ7GYUwloxdTcCps1a8/tGclxKern3uAUuP9sSHcvUgzOwvY+5LkeoUbOgh5c9
         UkLg+ry3T12SWyxuaPnSpKIfn1ERj2OtjtoDKGu8+yGocUgmtqML0+RXARTWlJ+2diIX
         l6EtyidvTMciaG3R5LEcrzSmE3V5moP6nzJYfxtIHRRhHUvtswlV47Ikg2FW6KQAZEk0
         yGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:content-language:thread-index;
        bh=DChNe1Vt2itx018CMoABCj26Su5X5bhxwcy1AiV6rEQ=;
        b=jHtqncuquHuv5w7az8ZTeQnZmpePsgPT/cXPsSbHxtBCwSDMwcFvfZq5EDGz2K5gCI
         kJzhyXFyuaISmFKMKVfYMz0PnKgO46kJGeXdXlskCZl4d0/hlKdXTh5ywWPuxZ5yqqaO
         v58JVgGDXg/V5SFVLzk4DEb1nbx13TQWuCbRf4YcJl5deKKihu45XXQufI56VrlA+35j
         YoNHsIOSkkwDnGazF4eINWp4yWhZXO37jh3bj1OOm+6JGQhPTpRgBoEgurvm5aq+rcTA
         tk9rsL1VQiXgyBXKjo5VnFp6vDs17s0+jz5evqLEErPWrWiezgGolCIsbnvip9rZOZpq
         xCbg==
X-Gm-Message-State: AMke39mnbx/yGFLiWr823ZxmoiGDg5JXtKgh9N324W2eV+4ggEiujFYK3Njm4FZDXH/qPQ==
X-Received: by 10.28.131.132 with SMTP id f126mr15916639wmd.61.1486500468230;
        Tue, 07 Feb 2017 12:47:48 -0800 (PST)
Received: from aceralessio ([151.31.246.241])
        by smtp.gmail.com with ESMTPSA id 10sm429086wmi.23.2017.02.07.12.47.47
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Feb 2017 12:47:47 -0800 (PST)
From:   "Alessio Rocchi" <alexrocchi@gmail.com>
To:     <git@vger.kernel.org>
Subject: git push - 401 unauthorized
Date:   Tue, 7 Feb 2017 21:47:45 +0100
Message-ID: <017901d28183$6fb72c60$4f258520$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-language: it
Thread-Index: AdKBg0sGMLqgXY3zQHeVMvsWxK/NPQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I try to push my commit on a private repository (which has been working
since about five years).
This is the output of git push:

me@superstar:/var/www/scorte$ git push --verbose
Pushing to http://isisenscorte:mypassword@mymachine/scorte_git
Getting pack list
Fetching remote heads...
  refs/
  refs/tags/
  refs/heads/
updating 'refs/heads/master'
  from d9fd2e49cb0c32a6d8fddcff2954f04b4104d176
  to   23d8edfb7fa70bce44c21a7f93064c08a7288e23
    sending 6 objects
MOVE 33fcba80fdec82f43f995e5c693255da075358be failed, aborting (52/0)
MOVE 60e1a097d50fe62319413ed20129580cf175d1ca failed, aborting (52/0)
MOVE cfea41ef02f9aef5cecfbf7eac5a9e55975113f4 failed, aborting (52/0)
MOVE 3d87ab6ff7652f2b30e48612b70c8335d4625699 failed, aborting (52/0)
MOVE 4adb1b39e0446e0bfc3182258ff1cd7077871f7f failed, aborting (52/0)
Updating remote server info
fatal: git-http-push failed

Looking at apache logs, I've got this output

192.168.240.127 - myusername [07/Feb/2017:19:57:01 +0100] "PROPFIND
/scorte_git/objects/23/ HTTP/1.1" 207 6003 "-" "git/1.7.0.4"
192.168.240.127 - myusername [07/Feb/2017:19:57:01 +0100] "PROPFIND
/scorte_git/objects/60/ HTTP/1.1" 207 7651 "-" "git/1.7.0.4"
192.168.240.127 - myusername [07/Feb/2017:19:57:02 +0100] "PROPFIND
/scorte_git/objects/4a/ HTTP/1.1" 207 3640 "-" "git/1.7.0.4"
192.168.240.127 - myusername [07/Feb/2017:19:57:02 +0100] "PROPFIND
/scorte_git/objects/3d/ HTTP/1.1" 207 13742 "-" "git/1.7.0.4"
192.168.240.127 - myusername [07/Feb/2017:19:57:02 +0100] "PROPFIND
/scorte_git/objects/cf/ HTTP/1.1" 207 13799 "-" "git/1.7.0.4"
192.168.240.127 - myusername [07/Feb/2017:19:57:02 +0100] "PROPFIND
/scorte_git/objects/33/ HTTP/1.1" 207 13783 "-" "git/1.7.0.4"
192.168.240.127 - - [07/Feb/2017:19:57:02 +0100] "PUT
/scorte_git/objects/3d/87ab6ff7652f2b30e48612b70c8335d4625699_8d42f74642dae7
7465d1fbfafbd720f67a1919f4 HTTP/1.1" 401 810 "-" "git/1.7.0.4"
192.168.240.127 - - [07/Feb/2017:19:57:02 +0100] "PUT
/scorte_git/objects/cf/ea41ef02f9aef5cecfbf7eac5a9e55975113f4_8d42f74642dae7
7465d1fbfafbd720f67a1919f4 HTTP/1.1" 401 810 "-" "git/1.7.0.4"
192.168.240.127 - myusername [07/Feb/2017:19:57:02 +0100] "PUT
/scorte_git/objects/33/fcba80fdec82f43f995e5c693255da075358be_8d42f74642dae7
7465d1fbfafbd720f67a1919f4 HTTP/1.1" 201 809 "-" "git/1.7.0.4"
192.168.240.127 - - [07/Feb/2017:19:57:02 +0100] "PUT
/scorte_git/objects/4a/db1b39e0446e0bfc3182258ff1cd7077871f7f_8d42f74642dae7
7465d1fbfafbd720f67a1919f4 HTTP/1.1" 401 810 "-" "git/1.7.0.4"
192.168.240.127 - - [07/Feb/2017:19:57:02 +0100] "PUT
/scorte_git/objects/60/e1a097d50fe62319413ed20129580cf175d1ca_8d42f74642dae7
7465d1fbfafbd720f67a1919f4 HTTP/1.1" 401 810 "-" "git/1.7.0.4"

It looks like I'm getting 401 errors on every line where username is
missing.

Permissions on the unauthorized object folders are 777 everywhere. My git
version is 1.7.0.4 on both client and server. Do you have any clue of this
strange behaviour?

Thank you in advance, Alex

