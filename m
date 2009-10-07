From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 3/3] completion: add dirstat and friends to diff options
Date: Wed,  7 Oct 2009 01:48:51 -0700
Message-ID: <1254905331-29516-3-git-send-email-bebarino@gmail.com>
References: <1254905331-29516-1-git-send-email-bebarino@gmail.com>
 <1254905331-29516-2-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 07 10:56:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvSKH-0004jY-Dg
	for gcvg-git-2@lo.gmane.org; Wed, 07 Oct 2009 10:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934114AbZJGIr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2009 04:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934010AbZJGIr2
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 04:47:28 -0400
Received: from mail-qy0-f173.google.com ([209.85.221.173]:41960 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934033AbZJGIr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 04:47:27 -0400
Received: by qyk3 with SMTP id 3so4151253qyk.4
        for <git@vger.kernel.org>; Wed, 07 Oct 2009 01:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=iW0cDhTVBz9/nhv7auQUUJRVj06eJVt6e0IeEK0j+ho=;
        b=DVdR3C1LrG8TX2g3irbxFuigyhlSmW9woqgAMH0JdT1VA+7O9jjWDp4ratEkFhKw60
         A2uK4T/hzC+4PNJqow8pDBFalpYpWl1zGO+sEX9Y67e+7vdKq9+dVSusYK3wrRNI4AEW
         49EOWGyR2Gfs8ZHKl3OJ+3r9zsqlGEBgtRUb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=V6E+vOQTi+ug6HE1a0roG55cf6WiG9SxyOoloezsFpDuxfBkdfs7V8U1rQtnlLcRJi
         KW758fC9qvxGeGnPrwAKN2BOxno07G9wVMcilzaeQS6/oHusJxLBKPAoFwI4cvcTapvE
         JM80+JUMTUvlK4XI4ugFFxWJcfHZKg899c9nk=
Received: by 10.224.60.9 with SMTP id n9mr2303618qah.31.1254905211173;
        Wed, 07 Oct 2009 01:46:51 -0700 (PDT)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 22sm369316qyk.10.2009.10.07.01.46.48
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Oct 2009 01:46:50 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Wed, 07 Oct 2009 01:48:59 -0700
X-Mailer: git-send-email 1.6.5.rc2.17.gdbc1b
In-Reply-To: <1254905331-29516-2-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129640>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

I sent this a while back, no response. If no response again I'll drop.

 contrib/completion/git-completion.bash |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2ab8c5e..a5fe1df 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -927,6 +927,8 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--inter-hunk-context=
 			--patience
 			--raw
+			--dirstat --dirstat= --dirstat-by-file
+			--dirstat-by-file= --cumulative
 "
 
 _git_diff ()
-- 
1.6.5.rc2.17.gdbc1b
