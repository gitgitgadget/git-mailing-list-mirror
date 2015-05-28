From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] glossary: add "remote", "submodule", "superproject"
Date: Wed, 27 May 2015 18:50:01 -0700
Message-ID: <1432777801-6073-1-git-send-email-sbeller@google.com>
References: <CAGZ79kauSsZK3_X+zTwL8TKuZiHNMGvMZfoCemW9-K7RWgrgCA@mail.gmail.com>
Cc: gitster@pobox.com, philipoakley@iee.org, hvoigt@hvoigt.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 03:50:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxmxX-00037S-TN
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 03:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbbE1BuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 21:50:08 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36384 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbbE1BuG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 21:50:06 -0400
Received: by iepj10 with SMTP id j10so27581395iep.3
        for <git@vger.kernel.org>; Wed, 27 May 2015 18:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0qOtM3G58gdPKThjzP5HjzH5K3Xw9WOy6a/UFo/8vOM=;
        b=b1vAvZTOVwgDYcIqx3gbGDYgB2rEK/WPZ49Fyeq0Nh9NnNaeRriCRSB+l2zAJ9khEB
         seu4AP50gICLjKvbKp4pS/E69EGJ+5F9oVj95+rQssIwgUCWgVsnStBVEx9BsEi4bkl0
         0OQkGp3KlAwDW77ocfYziYP/lhT797BQNwG5GhzJg4qZ9xhHGgZ56Tq3ieTKWuItziqc
         0rfGQmtiUdPuReed2cndnaCI2HhoieJnCsJwXY4WmCk+KCBfvxAnRYgOpK4zwUG+yqgz
         zhHSpXNLeyhy8mgTH8QB6sDOybbWrNO+sKYfcbWEOQqCrHEF91wN5OPtN8x+Vd8y/E4l
         VcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0qOtM3G58gdPKThjzP5HjzH5K3Xw9WOy6a/UFo/8vOM=;
        b=GhW+BaaR4Vh6hU9ZHiE25hZP9zTbeAOxFNIrbxlT8wa24pbpF2bn97SRrw2XQD+Ts1
         VQFS0dXl1Xs3alp06P9OZT+tzpyP9eDBOA28QDCEFakrt1fp93E6+nXIbMl6qr14xcea
         ykWp2q6CGWbe2814P8/lnGQmu3FjiIMtGBcy5kZOdiV4xEVGgWPReKzPagNSaCgoZQg6
         qWj67173bkeAkYUR61/hnmP7968av7dieDBopKMyp3kn5E5Y4pDMuMUe8iajS+N2XSpC
         K4q48zkUZ0dRV7UOcJ/AqGxgb2j66xDkEYw6pbmzIF3ph0IU8I+zOUP467zLYvVn6xte
         SWQQ==
X-Gm-Message-State: ALoCoQmAZTcBmHW7/YP+OIIKraoUJiDkXHPzHQdIhqkP3KviHA2fXJ1zq4YJgllXtfTWV9X7tDxj
X-Received: by 10.107.133.154 with SMTP id p26mr378248ioi.7.1432777805200;
        Wed, 27 May 2015 18:50:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:e1d5:6fe9:c696:4b29])
        by mx.google.com with ESMTPSA id g12sm631832ioe.28.2015.05.27.18.50.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 May 2015 18:50:04 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <CAGZ79kauSsZK3_X+zTwL8TKuZiHNMGvMZfoCemW9-K7RWgrgCA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270122>

Noticed-by: Philip Oakley <philipoakley@iee.org>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/glossary-content.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index bf383c2..23ab692 100644
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
@@ -515,6 +520,18 @@ The most notable example is `HEAD`.
 	is created by giving the `--depth` option to linkgit:git-clone[1], and
 	its history can be later deepened with linkgit:git-fetch[1].
 
+[[def_submodule]]submodule::
+	A <<def_repository,repository>> that holds the history of a
+	separate project inside another repository (the latter of
+	which is called <<def_superproject, superproject>>). The
+	containing superproject knows about the names of (but does
+	not hold copies of) commit objects of the contained submodules.
+
+[[def_superproject]]superproject::
+	A <<def_repository,repository>> that references other repositories
+	inside itself as <<def_submodule,submodules>>. The superproject
+	tracks only the remote and the name of the submodule.
+
 [[def_symref]]symref::
 	Symbolic reference: instead of containing the <<def_SHA1,SHA-1>>
 	id itself, it is of the format 'ref: refs/some/thing' and when
-- 
2.4.1.345.gab207b6.dirty
