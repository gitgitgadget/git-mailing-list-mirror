From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK)] gitk: Add a menu option to start Git Gui.
Date: Thu, 13 Nov 2008 23:12:42 +0300
Organization: HOME
Message-ID: <200811132312.42150.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 21:16:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0ibg-0005LK-Un
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 21:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbYKMUOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 15:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbYKMUOp
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 15:14:45 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:34133 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbYKMUOo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 15:14:44 -0500
Received: by fg-out-1718.google.com with SMTP id 19so869797fgg.17
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 12:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=KDYWOUTvJ0kPAuMpvqZMc49cFXm2E+3ntD+kXlIsuWA=;
        b=ohh0KfqoM2t3cj+CtFAeyTeZV0ia5zJSBNwNgbBl51JtginRR7MU5L29yVBPDER48c
         oSxhH5WeVABvvCTDREdxSaTzwCzEQHAJtsq/UOQq8HvjrvpNAqcD5Ou4HnNFdtv7Rc09
         4E9sbDVrmmlA9+50zn4G0tr2DlC2jbTNejA4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=YSTs+PKMjz5a4xFO9QGlN4gVpboZuyT3vuhEz8NE6C9u7TUeKgtKzA1j7BT3IlblAx
         ZCAm6lqsGQUKUCMM8gjTUBcD9a/fIcaX/RJJ3lJjJ09Eed19IjzyNORdfTx+7Tmeo6H4
         Ox8Vq4m995Vk22mpXN+gEKx4rSq+sBKnPsSd8=
Received: by 10.180.252.8 with SMTP id z8mr31561bkh.158.1226607282488;
        Thu, 13 Nov 2008 12:14:42 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id p17sm5304358fka.14.2008.11.13.12.14.40
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 12:14:41 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.26.6-79.fc9.i686; KDE/4.1.2; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100908>

Git Gui already has menu commands to start gitk,
and this makes the relation symmetric. Since gitk and
git-gui complement each other, I think that it is
beneficial to integrate them where it makes sense.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 46896a2..e4562d7 100755
--- a/gitk
+++ b/gitk
@@ -1906,6 +1906,9 @@ proc makewindow {} {
 	    {mc "Reload" command reloadcommits -accelerator Meta1-F5}
 	    {mc "Reread references" command rereadrefs}
 	    {mc "List references" command showrefs -accelerator F2}
+	    {xx "" separator}
+	    {mc "Start Git Gui" command {exec git gui &}}
+	    {xx "" separator}
 	    {mc "Quit" command doquit -accelerator Meta1-Q}
 	}}
 	{mc "Edit" cascade {
-- 
1.6.0.3.15.gb8d36
