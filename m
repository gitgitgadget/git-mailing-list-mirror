From: layer <layer@known.net>
Subject: "git status <file>" in the middle of a merge
Date: Wed, 08 Apr 2009 16:40:26 -0700
Message-ID: <10804.1239234026@relay.known.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 09 01:42:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrhPA-0006PZ-LL
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 01:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756864AbZDHXk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 19:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757015AbZDHXk2
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 19:40:28 -0400
Received: from relay.known.net ([67.121.255.169]:48930 "HELO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757149AbZDHXk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 19:40:27 -0400
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.17) id 000000034397; Wed, 8 Apr 2009 16:40:26 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116132>

$ git status ChangeLog
fatal: cannot do a partial commit during a merge.
$ 

Huh?  I'm not committing.  I'm asking for status.

Doing "git status" will tell me it's `unmerged'.
