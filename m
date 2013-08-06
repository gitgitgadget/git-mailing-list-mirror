From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 01/16] git-log.txt: place each -L option variation on its own line
Date: Tue,  6 Aug 2013 09:59:34 -0400
Message-ID: <1375797589-65308-2-git-send-email-sunshine@sunshineco.com>
References: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 06 16:00:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6hoa-0003Su-2N
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 16:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918Ab3HFOA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 10:00:29 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:46384 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754308Ab3HFOA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 10:00:27 -0400
Received: by mail-oa0-f47.google.com with SMTP id g12so740718oah.20
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 07:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ejet3Hqd99xp6reZkclldaSJpS+mlJThQjg86a23/2w=;
        b=eOh63gKfNudSytv0oIozrB/S9DEZQ4TdnK43Vk2CMMx8HRwaFAG80iDnBmZe4+0qX1
         tbP7oJjrcSTzW8DylT3LuotXohj0KDunTdSMn+ogcgXyDbWtIX/xOxwbICogp8hL1E12
         Lr/TifGlrJnuI2/rFPC2RM+/Ylht4pXaOf+7UF1i92ZKc8rKOdZME94LAnJiMM79f78M
         0ylM8Bs8/60vrAdgH3HssTuw3fHmzuXLZxQHmVEYajm4NuqxF7CH8YFmjdYmDbAAk4+Y
         K9WF/Q5bH5jNtGHMQxokaxGkmqDqMBUTNQO5YGRY9IndarEhUhXydJOpuKFp0hkH3Umh
         PX5w==
X-Received: by 10.60.155.200 with SMTP id vy8mr1079000oeb.72.1375797625952;
        Tue, 06 Aug 2013 07:00:25 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id z2sm1380175obi.3.2013.08.06.07.00.23
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Aug 2013 07:00:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.409.gbd48715
In-Reply-To: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231742>

Standard practice in Git documentation is for each variation of an
option (such as: -p / --porcelain) to be placed on its own line in the
OPTIONS table. The -L option does not follow suit. It cuddles "-L
<start>,<end>:<file>" and "-L :<regex>:<file>", separated by a comma.
This is inconsistent and potentially confusing since the comma
separating them is typeset the same as the comma in "<start>,<end>". Fix
this by placing each variation on its own line.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-log.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index ac2694d..fe04e06 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -62,7 +62,8 @@ produced by --stat etc.
 	Note that only message is considered, if also a diff is shown
 	its size is not included.
 
--L <start>,<end>:<file>, -L :<regex>:<file>::
+-L <start>,<end>:<file>::
+-L :<regex>:<file>::
 
 	Trace the evolution of the line range given by "<start>,<end>"
 	(or the funcname regex <regex>) within the <file>.  You may
-- 
1.8.4.rc1.409.gbd48715
