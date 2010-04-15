From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] git-gui: document textconv config option
Date: Thu, 15 Apr 2010 21:41:23 +0200
Message-ID: <20100415194123.GB5848@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Apr 15 21:41:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Uwj-0004hw-45
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 21:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755959Ab0DOTls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 15:41:48 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:46808 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755860Ab0DOTls (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 15:41:48 -0400
Received: by ey-out-2122.google.com with SMTP id d26so177939eyd.19
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 12:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:mime-version:content-type:content-disposition
         :user-agent;
        bh=bTsy5qoz7zj0IO+DOjrypja+M1pGk1xMNaeaen+nJRs=;
        b=pjXrWB7s2lJHATAuBSDu2OEEM2r6AKBat3z/KFjp876z2PmgZTJgoO1R9aBED9kHYb
         SsrTet3tatAA/WM1LQX7A1Gar0vloluzUnJaSyT+uIFqegCH+joWD6mb2BPBOjaW1bJ7
         UlA8ZARfBqXOxwQCXicHZee+MB1oASJGEkjOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        b=d5IeMd3+daiXoGAnMy5FfOuibOYwgQAQbSnsdWDbw0xdkaYPh6bk5LCEOfHfbAt/bD
         Q5bdpP0E26Ghg7p1f+EfbnU2JgmUwjSb+2pcc9/2pe+EViC7xpJd1+zCTJP9g9Q0YxFt
         eEJMTyexShjgfOBrk2brFqdfQIkLy/7xtohrQ=
Received: by 10.213.44.67 with SMTP id z3mr296358ebe.57.1271360506386;
        Thu, 15 Apr 2010 12:41:46 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id 15sm1232838ewy.0.2010.04.15.12.41.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 12:41:45 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1O2UwF-0001aC-Ta; Thu, 15 Apr 2010 21:41:23 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145016>

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

This patch applies to git.git.

 Documentation/config.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index aa5411e..5d7d345 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1049,6 +1049,12 @@ gui.matchtrackingbranch::
 	default to tracking remote branches with matching names or
 	not. Default: "false".
 
+gui.textconv::
+	If this option is enabled, and a textconv filter is defined (see
+	linkgit:gitattributes[5]), linkgit:git-gui[1] shows the converted diff.
+	Staging individual hunks is not possible for such diffs, however.
+	Default: "true".
+
 gui.newbranchtemplate::
 	Is used as suggested name when creating new branches using the
 	linkgit:git-gui[1].
-- 
1.7.1.rc0.27.g3b0c
