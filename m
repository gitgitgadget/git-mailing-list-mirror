From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] glossary: add "remote", "submodule", "superproject"
Date: Fri, 29 May 2015 11:23:56 -0700
Message-ID: <1432923836-9939-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, philipoakley@iee.org, hvoigt@hvoigt.net,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 29 20:24:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyOx4-00068E-Mi
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 20:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756343AbbE2SYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 14:24:09 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:34456 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756060AbbE2SYH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 14:24:07 -0400
Received: by ieczm2 with SMTP id zm2so69300318iec.1
        for <git@vger.kernel.org>; Fri, 29 May 2015 11:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=sfGwHgtdSvSF7zhrKm22nidquTp+Hui+GNrljn8RqJU=;
        b=fc7wy68beYOB8jG5MNPWYqQkVgM5ULlpiXyltVmb+XI7l+EsKC3oxZYWfN/qxvwTGc
         XMn64ZYOAtB+Ds1zGrmS3U6EvRS3iWMnws4jROXBh4Gg5DyIvDbFMxk0ufCnOqV8k9Nd
         NNZGhjoxB+ieTdy7dchTkjDMToLCGz9zLaAEvbN2/YoiELvIomwFj8t3l1XlO/fYUykv
         nAAy8mQA+NtFntryMAM0K+l7X0XKCYjYD2U6qm6dbOhNRhixj9qXib0vLHX3lnHZvOiu
         /jn1+HybNl5KFoyJWkrPu0xONTJ6m7ajv3RsU30a45RHiEtrjs3RM2X6JpUyXrrZuqq6
         Oz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sfGwHgtdSvSF7zhrKm22nidquTp+Hui+GNrljn8RqJU=;
        b=BgM92jdd5F4wGS7a2Oa85yWwyZTRfvwChq671h1rnzAcCsRArP0WPsLHw5WxukYn8p
         Cb/g4UWxz5Y4l5yBuxKmjF8kxHKgi8xrPx6XM7ZYFDvzakqQ3VGgus3DBIYJDIFI90AK
         wxjC4yT1AMkHRanCkmJ61YuZu+VMLHeAhLYyVKwHCUppamfKvCQ5VXp16oWcOZhooSF6
         BSsurtuMXH7G+zMD267wqkc1z2MZNHKV+MPFUPuIKwPXc/Zi/PWYhLV/tvYzHYNXvNKD
         8+llUrqCRNqh1aHeKqxc1o8Axs36hV7DBzUYv9UrRHJSyxhCCLnWyhQUtXn3BBEp4xPo
         RXhA==
X-Gm-Message-State: ALoCoQmmaNcu4TVZXvV2JhnPKC4jPdsqlxfFk//6DmeFy6ZudrDeCngV6vdvHb2fGMGKQPyrB682
X-Received: by 10.107.19.104 with SMTP id b101mr12122438ioj.39.1432923847121;
        Fri, 29 May 2015 11:24:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:64ea:281d:9680:ac67])
        by mx.google.com with ESMTPSA id s5sm2057368igh.6.2015.05.29.11.24.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 29 May 2015 11:24:06 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270264>

Noticed-by: Philip Oakley <philipoakley@iee.org>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Moved information regarding the superproject from submodule to superproject,
and slightly reworded the superproject description.

 Documentation/glossary-content.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index bf383c2..ab18f4b 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -469,6 +469,11 @@ The most notable example is `HEAD`.
 	<<def_push,push>> to describe the mapping between remote
 	<<def_ref,ref>> and local ref.
 
+[[def_remote]]remote repository::
+	A <<def_repository,repository>> which is used to track the same
+	project but resides somewhere else. To communicate with remotes,
+	see <<def_fetch,fetch>> or <<def_push,push>>.
+
 [[def_remote_tracking_branch]]remote-tracking branch::
 	A <<def_ref,ref>> that is used to follow changes from another
 	<<def_repository,repository>>. It typically looks like
@@ -515,6 +520,17 @@ The most notable example is `HEAD`.
 	is created by giving the `--depth` option to linkgit:git-clone[1], and
 	its history can be later deepened with linkgit:git-fetch[1].
 
+[[def_submodule]]submodule::
+	A <<def_repository,repository>> that holds the history of a
+	separate project inside another repository (the latter of
+	which is called <<def_superproject, superproject>>).
+
+[[def_superproject]]superproject::
+	A <<def_repository,repository>> that references repositories
+	of other projects in its working tree as <<def_submodule,submodules>>.
+	The superproject knows about the names of (but does not hold
+	copies of) commit objects of the contained submodules.
+
 [[def_symref]]symref::
 	Symbolic reference: instead of containing the <<def_SHA1,SHA-1>>
 	id itself, it is of the format 'ref: refs/some/thing' and when
-- 
2.4.1.345.gab207b6.dirty
