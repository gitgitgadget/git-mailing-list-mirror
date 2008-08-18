From: Robert Schiele <rschiele@gmail.com>
Subject: [PATCH] adapt git-cvsserver manpage to dash-free syntax
Date: Mon, 18 Aug 2008 16:17:04 +0200
Message-ID: <20080818141704.GC11842@schiele.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 16:18:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV5Yk-0004fn-IE
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 16:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbYHRORK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 10:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752857AbYHRORK
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 10:17:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:44302 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbYHRORI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 10:17:08 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1655762fgg.17
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 07:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent
         :from:reply-to;
        bh=m1+yWtwQiIj+xGzvut2aQT2ljGOQurSoHOmGHz4SVDQ=;
        b=lM/N4CRvja3G3jprGRLtHBew3YTp0B/yDTE5465y6rlhwdV0FQLhnE8/XIDchKvlof
         vQsnF1zafrf2Ks7v9rAs512pAhKWBMVHIetC+70mYL810zPZikIbjjiX/yF2jvrRBEH1
         PcDfghjKBjLNz2tfWXu3ToYLVSWg+g7iphun8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent:from:reply-to;
        b=fLIw5HeBFU1lFqDu4zFKXc0m3JPoS/fIkO8to3HsfzGHsv9pL5CmVgh+P6CyJzltiA
         RLiW/nS3wadVUxx+B9qr7jXd1xCztPUyIyz0wenI1YWKiGE2f4XOCRi8TtiUgNDQrC1Z
         WIUX+0LOHLdCby6s9bM1knyKBFICNX1+UEDXE=
Received: by 10.86.68.2 with SMTP id q2mr3195592fga.43.1219069026519;
        Mon, 18 Aug 2008 07:17:06 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [91.18.110.73])
        by mx.google.com with ESMTPS id 3sm11294727fge.3.2008.08.18.07.17.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Aug 2008 07:17:05 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 054501604F; Mon, 18 Aug 2008 16:17:04 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92708>

Signed-off-by: Robert Schiele <rschiele@gmail.com>
---
 Documentation/git-cvsserver.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index c2d3c90..785779e 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 SSH:
 
 [verse]
-export CVS_SERVER=git-cvsserver
+export CVS_SERVER="git cvsserver"
 'cvs' -d :ext:user@server/path/repo.git co <HEAD_name>
 
 pserver (/etc/inetd.conf):
@@ -109,7 +109,7 @@ Note: Newer CVS versions (>= 1.12.11) also support specifying
 CVS_SERVER directly in CVSROOT like
 
 ------
-cvs -d ":ext;CVS_SERVER=git-cvsserver:user@server/path/repo.git" co <HEAD_name>
+cvs -d ":ext;CVS_SERVER=git cvsserver:user@server/path/repo.git" co <HEAD_name>
 ------
 This has the advantage that it will be saved in your 'CVS/Root' files and
 you don't need to worry about always setting the correct environment
@@ -158,7 +158,7 @@ allowing access over SSH.
 --
 ------
      export CVSROOT=:ext:user@server:/var/git/project.git
-     export CVS_SERVER=git-cvsserver
+     export CVS_SERVER="git cvsserver"
 ------
 --
 4. For SSH clients that will make commits, make sure their server-side
@@ -283,7 +283,7 @@ To get a checkout with the Eclipse CVS client:
 Protocol notes: If you are using anonymous access via pserver, just select that.
 Those using SSH access should choose the 'ext' protocol, and configure 'ext'
 access on the Preferences->Team->CVS->ExtConnection pane. Set CVS_SERVER to
-'git-cvsserver'. Note that password support is not good when using 'ext',
+"'git cvsserver'". Note that password support is not good when using 'ext',
 you will definitely want to have SSH keys setup.
 
 Alternatively, you can just use the non-standard extssh protocol that Eclipse
-- 
1.5.4.5
