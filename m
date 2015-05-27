From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] glossary: add "remote" and "submodule"
Date: Wed, 27 May 2015 14:13:29 -0700
Message-ID: <1432761209-4120-1-git-send-email-sbeller@google.com>
Cc: philipoakley@iee.org, git@vger.kernel.org, hvoigt@hvoigt.net,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 27 23:13:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxidx-0005ji-QE
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 23:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbbE0VNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 17:13:37 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36412 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbbE0VNg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 17:13:36 -0400
Received: by igbpi8 with SMTP id pi8so96026338igb.1
        for <git@vger.kernel.org>; Wed, 27 May 2015 14:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=3yJIfAW+0oGXAxAHB4shLEB2StbIIzKI0mWojRtxrwY=;
        b=IX+pDkqYCb/+rfl4/WdpHolaX2XuYKDElmNnJtas68m2DW6++x6Hul2J4MwSgGqtvq
         EUSL6paFwTMLQNJGR2WHc1MaPAlmo8AWkaIugxAwgwFOWXWAjh1WyTZfPn9t/jinE57h
         gjh6jJTJATObALQySvxEqE/RJCQQLFZxeHxoI5MVkmRp+x871cCgnYVZKpHyJm87JyPo
         5uQ+T+xDuod9OunxhBDdylYBhw8kM0XCSlD0GGYhCa3ppNUNZb/ntsKlYDZfPPChYDLm
         5pGy+kCmKGJazTDZ7JFdEgrVecVPMweT+Q1iyexVrSga4o2/02UZgQAsPl90GFZGH7kJ
         p5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3yJIfAW+0oGXAxAHB4shLEB2StbIIzKI0mWojRtxrwY=;
        b=NfMMjK+gpROEZcR4ky04RGUwpaj0BLhfKn45a/VTjMTSeIKbIK4kK80piLo6vfnQg3
         eQomWBYLaV3IvyoKWEKzBOcbuXnk0kzJBZujfyM5fQl0z+KlYXzFjLTJdE+TiMcuGr97
         EdnMZotqeJWHIQlK2zHZyhhSu8fqhuR5qAthJspIGnG7Nj22hqP3yVrHif+dWXST6SwA
         iZ4HmEeTcCvtefn9w0amw5KjZZ9pt6FO7k3E37QzZAgC7wzmQf2dYkEKIa8/hMsvsi66
         uNScgnd6KuQfElWAyiCaIvOYpdL9qkuh3apJs6LVzpYBPFYuV7n+YiJvBKNeJie+ZSjw
         Zrjw==
X-Gm-Message-State: ALoCoQlm57VQXFvn6TB23d831NTqUxAwBzEglx6jnXi/yz+Vh1g2Vn4jnoUqQZ0+BD+TLVmwC17s
X-Received: by 10.107.7.84 with SMTP id 81mr44108844ioh.28.1432761215442;
        Wed, 27 May 2015 14:13:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:e1d5:6fe9:c696:4b29])
        by mx.google.com with ESMTPSA id i4sm11691138igm.2.2015.05.27.14.13.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 May 2015 14:13:34 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270098>

Noticed-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/glossary-content.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index bf383c2..e303135 100644
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
@@ -515,6 +520,11 @@ The most notable example is `HEAD`.
 	is created by giving the `--depth` option to linkgit:git-clone[1], and
 	its history can be later deepened with linkgit:git-fetch[1].
 
+[[def_submodule]]submodule::
+	A <<def_repository,repository>> inside another repository. The two
+	repositories have different history, though the outer repository
+	knows the commit of the inner repository.
+
 [[def_symref]]symref::
 	Symbolic reference: instead of containing the <<def_SHA1,SHA-1>>
 	id itself, it is of the format 'ref: refs/some/thing' and when
-- 
2.4.1.345.gab207b6.dirty
