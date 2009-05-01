From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/4] user-manual: add global config section
Date: Fri,  1 May 2009 11:44:21 +0300
Message-ID: <1241167462-5984-4-git-send-email-felipe.contreras@gmail.com>
References: <1241167462-5984-1-git-send-email-felipe.contreras@gmail.com>
 <1241167462-5984-2-git-send-email-felipe.contreras@gmail.com>
 <1241167462-5984-3-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 01 10:45:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzoMh-0003LM-RU
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 10:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbZEAIov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 04:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752167AbZEAIot
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 04:44:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:4287 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbZEAIok (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 04:44:40 -0400
Received: by fg-out-1718.google.com with SMTP id 16so714400fgg.17
        for <git@vger.kernel.org>; Fri, 01 May 2009 01:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ZOoxsttzkh+vqIlYN3GCNCYciC+LxZ+9eJYD7eaErWw=;
        b=acHBQR9zxewRJ1tvO4vvtcAogwpL7CYGPbPQmax45Mez5C5bK3KVXQtebG2xmdfssr
         MLcjDfwO/PKojmjuVErbviJvnKyAtNhhuaMewezJdOXeLoHOH2gJmiNNthwC2u2bgIGM
         vLw3mIZBUP2TKasOPQL3Ka15yy5BosUY7B+og=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=L+66qQuPeZuBpRQwHu8K95CQk8rvi5ONqKF6QVHz1r2Q8G/lk+kVrv7AY/qLTqdWBG
         MdOxH5AboPm0sGHQTyVfN0mmmU0cxRRv2es5MeEnKO2iWrCshbNwM4wHakP56CetAQJU
         I49ovV5AO3DJIbpYIQYyK63sFmNWdSt39vIrc=
Received: by 10.86.63.5 with SMTP id l5mr2694883fga.63.1241167479579;
        Fri, 01 May 2009 01:44:39 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id e20sm413782fga.10.2009.05.01.01.44.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 May 2009 01:44:38 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc3.13.g195b.dirty
In-Reply-To: <1241167462-5984-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118064>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/user-manual.txt |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 9978027..d466199 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -40,6 +40,33 @@ without any explanation.
 Finally, see <<todo>> for ways that you can help make this manual more
 complete.
 
+[[getting-started]]
+Getting started
+=============
+
+Git's configuration is distributed among different locations--this manual will
+only to deal with 'global' (for the user) and 'repository' variables, where
+'repository' variables take precedence over 'global' ones.
+
+You would probably want to start setting up something useful:
+------------------------------------------------
+$ git config --global color.ui auto
+------------------------------------------------
+
+This will make prettier the output of certain commands such as `git diff`, but
+that's not important; what is important here is that `color.ui` has been
+stored in the 'global' configuration.
+
+View and manually modify the configuration by opening `~/.gitconfig`:
+------------------------------------------------
+[color]
+        ui = auto
+------------------------------------------------
+
+Other locations are `/etc/gitconfig` (system), and `.git/config` (repository).
+
+More git configurations will be covered in the rest of the manual, if you want
+to learn more look at linkgit:git-config[1] for details.
 
 [[repositories-and-branches]]
 Repositories and Branches
-- 
1.6.3.rc3.13.g195b.dirty
