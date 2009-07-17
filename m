From: Peter Simons <simons@cryp.to>
Subject: [PATCH] post-update.sample referenced obsolete binary "git-update-server-info"
Date: Fri, 17 Jul 2009 17:36:34 +0200
Organization: private
Message-ID: <874otb724d.fsf@write-only.cryp.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 17 17:36:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRpUZ-0001ha-09
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 17:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934702AbZGQPgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 11:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934700AbZGQPgu
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 11:36:50 -0400
Received: from main.gmane.org ([80.91.229.2]:55595 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934687AbZGQPgt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 11:36:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MRpUM-00061n-1B
	for git@vger.kernel.org; Fri, 17 Jul 2009 15:36:46 +0000
Received: from brln-4d0cdd83.pool.mediaways.net ([77.12.221.131])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 15:36:46 +0000
Received: from simons by brln-4d0cdd83.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 15:36:46 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: brln-4d0cdd83.pool.mediaways.net
Cancel-Lock: sha1:/9/39zPCI6GTL9DogniJic75N8g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123467>


	Modified 
diff --git a/templates/hooks--post-update.sample b/templates/hooks--post-update.sample
index 5323b56..ec17ec1 100755
--- a/templates/hooks--post-update.sample
+++ b/templates/hooks--post-update.sample
@@ -5,4 +5,4 @@
 #
 # To enable this hook, rename this file to "post-update".
 
-exec git-update-server-info
+exec git update-server-info
