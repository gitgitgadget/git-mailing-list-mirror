From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 1/5] Documentation: fix a typo
Date: Mon, 16 May 2016 11:05:35 -0700
Message-ID: <20160516180539.4114-2-sbeller@google.com>
References: <20160516180539.4114-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon May 16 20:06:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Mtu-0005Uw-QR
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 20:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440AbcEPSFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 14:05:48 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35476 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346AbcEPSFo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 14:05:44 -0400
Received: by mail-pf0-f173.google.com with SMTP id 77so69662923pfv.2
        for <git@vger.kernel.org>; Mon, 16 May 2016 11:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8d5VUuKSD5N0e+3pgHRTF1Atfv32tNMU6vKdgA4ywQY=;
        b=bB1bMpNa12DDr0CtLQoAhyU0VcjWn6jlg4nteRvxmNHy2RhTYuJTGDfvNtZmEXLXCW
         Ejeo9IQw/DVOO5h5xEIurOmE/dn+jXupw71fWq0puoNSAmWgS4tUpgL/LQa1tZtLpL91
         bDRr0YgNuArnskICB09hqIY3n8U+owsHD2sigdkq0yiU4RGXOyGW7dAMMfMreGoOD6nF
         PrJhWbwNDLv6gcxSJpI2KDu7JcbiAE/IdFACpQJ6zpmsBgfFHSxh85tDIln1q9W0xHtx
         AMMGjIdbLr+b8Hm/bsZj26rysXve4pYwkBTEpYslQZB2o68wYbfWljN8qCQl/hMggi1z
         uofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8d5VUuKSD5N0e+3pgHRTF1Atfv32tNMU6vKdgA4ywQY=;
        b=dmpUU34W0hazG6ybh5ajwnk6/jy9qORcFpXWPe5xARP/cWCV/Ch0k0aPxlmvooKSs/
         vuQgmByi570nd2zPLzeGKzACZKrMBHidRTAy9b9+JPCQ6D9lwM8hOjt/91p0vFBPmdEv
         LL6hGMbtbsSRmR9FQYWc1ljUIxKdj0FjrHfBMN28Cw+hAiDpSyRgyv5O1MoyeospjKLG
         1yDDexouL/Rc+iKwLNOb3tYnYbK70ZEYtXZjvREvebWJCDBQ7zP+WqpVCNxJj+bS5kuQ
         4pb8PQHltO1dG96gjYuhbVG4Z6DtFViCMwd6QSq+VtUt4/mUDHqHYtZth3Vr3vqTDtOx
         ln4g==
X-Gm-Message-State: AOPr4FViNW7FjhI7pOJ32NjDRRmZtquab1UiOAeQOJFYl/G1KRUxR9trF6KljeW4R9qyDWVH
X-Received: by 10.98.2.14 with SMTP id 14mr47730180pfc.148.1463421943731;
        Mon, 16 May 2016 11:05:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d9b2:8bac:9e16:6023])
        by smtp.gmail.com with ESMTPSA id o63sm48837503pfj.30.2016.05.16.11.05.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 16 May 2016 11:05:43 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.401.gb49ffe6.dirty
In-Reply-To: <20160516180539.4114-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294768>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/gitattributes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index e3b1de8..af2c682 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -86,7 +86,7 @@ is either not set or empty, $HOME/.config/git/attributes is used instead.
 Attributes for all users on a system should be placed in the
 `$(prefix)/etc/gitattributes` file.
 
-Sometimes you would need to override an setting of an attribute
+Sometimes you would need to override a setting of an attribute
 for a path to `Unspecified` state.  This can be done by listing
 the name of the attribute prefixed with an exclamation point `!`.
 
-- 
2.8.2.401.gb49ffe6.dirty
