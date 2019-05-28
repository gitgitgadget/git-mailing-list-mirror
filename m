Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 304191F462
	for <e@80x24.org>; Tue, 28 May 2019 18:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfE1SPs (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 14:15:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44261 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbfE1SPr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 14:15:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id b8so7197083edm.11
        for <git@vger.kernel.org>; Tue, 28 May 2019 11:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rB8aRRQK5qzzwxot2y8hFgkw0/2ioQUveMmHOFBYrgA=;
        b=jhTy4x0S1sZUvtGTn1GB5knS7lI9d91kdpYUptkPiQR0Ge6YU9JxGZx+pjKSWb7XSA
         62FrmmtCDuZLiVS0tUwh5hfyoUCndvh9aS1jywtu927pyBhI6fZDC0Rz94EWGhpNwxyn
         NyEjTcVADu/vAMK6WqLYYICV6Ia/wSjDv1ohnQ2kCwv6Js5SvsCTfZGYfBC1GiDgrNXo
         jhEvPL0bUMyyowUD7rwGomeGJE3by+G7jeiwaGXQurFGZ7Zy0rkW1NbOObGcGLCb7iiD
         vSUOsIO4jfRgxm+0C+0Pwk4bHzLBShitbijbW2LV6/N9UjjY3JOf+uXhFaaE0qFJNDwa
         TNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rB8aRRQK5qzzwxot2y8hFgkw0/2ioQUveMmHOFBYrgA=;
        b=NpWSSn9KPDm+ASfg6dbrF4sg+r3asikEvT/+ej1vmPvlsSodHC/1lZ2JQF2kmzxANI
         6pErRsQFec/IMtugVal8UUoGVrFwj0TXiC+mHIyoA6zH93F7oQTHU86ytLtRcBaBKYKj
         6+TDnWKijU9vdCFxWLmTwyorw1Ogyj2HieRE7OMYQUXsj0z5xP6d7R24AwBYMAIh1hCh
         32yJfb6tgIef+hhtBdW4hZ6q2cNPzx3DDGRRM2VZ4aw0/Eem3PNeYNCDveJaydQ7P95N
         n5I2wYn+GtqYpNA1n7mH7lg4hRcN3t1hGjbmFUO7QYwwjv3r+QPl5lTNoQew34DMOy3w
         SRRg==
X-Gm-Message-State: APjAAAWabcMw7cK6yFJigRTDaXiQoI4SMPeC+y6OztLqtDIoQnV3ooGE
        w9XDTZ6g0G6trDudxaWzJxtFuU6Q6WY=
X-Google-Smtp-Source: APXvYqwsH9ZLiJbVrg7bC5A9dDjGH7eRMlEdnZQCs9shGdZbdIZW4BjOXvhL2cAZzZKhRnICTKIE4Q==
X-Received: by 2002:a17:906:619:: with SMTP id s25mr77607077ejb.274.1559067345742;
        Tue, 28 May 2019 11:15:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c20sm2357694ejr.69.2019.05.28.11.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 11:15:45 -0700 (PDT)
Date:   Tue, 28 May 2019 11:15:45 -0700 (PDT)
X-Google-Original-Date: Tue, 28 May 2019 18:15:43 GMT
Message-Id: <pull.183.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.183.git.gitgitgadget@gmail.com>
References: <pull.183.git.gitgitgadget@gmail.com>
From:   "Mike Mueller via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] p4: fix "Not a valid object name HEAD0" when unshelving
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git p4 unshelve was failing with "fatal: Not a valid object name HEAD0" and
"Command failed: git cat-file commit HEAD^0" on certain systems e.g. git
version 2.21.0.windows.1 + python 2.7.16

It seems that certain python pOpen implementations drop the ^ character when
invoked using a string instead of an array as first argument, which is what
is done by extractLogMessageFromGitCommit.

Solution is to use the array format of passing the command to fOpen, which
is preferred (see https://docs.python.org/2/library/subprocess.html) and is
used in other parts of this code anyway.

Mike Mueller (1):
  p4 unshelve: fix "Not a valid object name HEAD0" on Windows

 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: aeb582a98374c094361cba1bd756dc6307432c42
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-183%2Fmdymike%2Fmaint-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-183/mdymike/maint-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/183

Range-diff vs v1:

 1:  fc580e902b ! 1:  5e89d1aceb p4 unshelve: fix "Not a valid object name HEAD0"
     @@ -1,8 +1,8 @@
      Author: Mike Mueller <mike.mueller@moodys.com>
      
     -    p4 unshelve: fix "Not a valid object name HEAD0"
     +    p4 unshelve: fix "Not a valid object name HEAD0" on Windows
      
     -    git p4 unshelve was failing with these errors on Windows:
     +    git p4 unshelve was failing with these errors:
      
          fatal: Not a valid object name HEAD0
          Command failed: git cat-file commit HEAD^0
     @@ -10,21 +10,19 @@
          (git version 2.21.0.windows.1, python 2.7.16)
      
          The pOpen call used by git-p4 to invoke the git command can take either a
     -    string or an array as a first argument.  The array form is preferred
     -    however the extractLogMessageFromGitCommit method was using the string
     -    form, which makes the caller responsible for escaping the command text
     -    appropriately (see https://docs.python.org/2/library/subprocess.html)
     -
     -    Somewhat ironically, the carat character is the escape character in
     -    Windows and so should be escaped (HEAD^^0).  Without the extra carat, the
     -    OS was passing an escaped 0 to the git command instead, and the git
     -    command was rejecting the invalid object name "HEAD0"
     +    string or an array as a first argument. The array form is preferred
     +    because platform-specific escaping of special characters will be
     +    handled automatically.(https://docs.python.org/2/library/subprocess.html)
     +    The extractLogMessageFromGitCommit method was, however, using the string
     +    form and so the caret (^) character in the HEAD^0 argument was not being
     +    escaped on Windows.  The caret happens to be the escape character, which
     +    is why the git command was receiving HEAD0.
      
          The behaviour can be confirmed by typing ECHO HEAD^0 at the command-
          prompt, which emits HEAD0.
      
          The solution is simply to use the array format of passing the command to
     -    fOpen, which is preferred and used in other parts of this code anyway.
     +    fOpen, which is recommended and used in other parts of this code anyway.
      
          Signed-off-by: Mike Mueller <mike.mueller@moodys.com>
      

-- 
gitgitgadget
