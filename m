From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: git-filter-branch may leave tree in a nasty state
Date: Sun, 2 Mar 2008 20:31:10 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803022029540.27717@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 20:31:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVtuX-0007kL-EO
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 20:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116AbYCBTbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 14:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753316AbYCBTbM
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 14:31:12 -0500
Received: from sovereign.computergmbh.de ([85.214.69.204]:42329 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbYCBTbM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 14:31:12 -0500
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id E79FA1803163B; Sun,  2 Mar 2008 20:31:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id DE3F91C057151
	for <git@vger.kernel.org>; Sun,  2 Mar 2008 20:31:10 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75831>

Hi,



$ git-filter-branch --env-filter 'export GIT_AUTHOR_NAME="";' b4caa441..HEAD
Rewrite cf1d02ac074041f7e570ff206d87fb47ef2b2c34 (1/1)fatal: empty ident  
<user@corp.com> not allowed

Ref 'refs/heads/master' was deleted
fatal: Not a valid object name HEAD

$ git log
fatal: bad default revision 'HEAD'
