From: David Miller <davem@davemloft.net>
Subject: format-patch on permission change gives empty patch
Date: Wed, 06 Oct 2010 17:37:14 -0700 (PDT)
Message-ID: <20101006.173714.245380201.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 02:36:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3eTj-0001ja-7a
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 02:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932961Ab0JGAgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 20:36:54 -0400
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:35129
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932892Ab0JGAgx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 20:36:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 0D79824C087
	for <git@vger.kernel.org>; Wed,  6 Oct 2010 17:37:15 -0700 (PDT)
X-Mailer: Mew version 6.3 on Emacs 23.1 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158358>


When I ask git to format-patch a commit that is just a file
permission change, it ends up generating an empty file, not
even the commit message is included.

davem@sunset:~/src/GIT/net-2.6$ git show
commit a5dbc62ed61bf4cc57e22b78e5794880f1c74b90
Author: Joe Perches <joe@perches.com>
Date:   Wed Oct 6 17:32:49 2010 -0700

    Documentation/networking/ixgbevf.txt: Change file permissions to 644
    
    Signed-off-by: Joe Perches <joe@perches.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>
You have new mail in /var/mail/davem
davem@sunset:~/src/GIT/net-2.6$ git format-patch HEAD^
0001-Documentation-networking-ixgbevf.txt-Change-file-per.patch
davem@sunset:~/src/GIT/net-2.6$ ls -l 0001-Documentation-networking-ixgbevf.txt-Change-file-per.patch 
-rw-r--r-- 1 davem davem 0 Oct  6 17:36 0001-Documentation-networking-ixgbevf.txt-Change-file-per.patch
davem@sunset:~/src/GIT/net-2.6$ git version
git version 1.7.3.1
