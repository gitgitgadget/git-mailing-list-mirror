From: layer <layer@known.net>
Subject: need help with git show :1:...
Date: Wed, 08 Apr 2009 10:41:26 -0700
Message-ID: <6838.1239212486@relay.known.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 19:51:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrbvp-0004UH-O3
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 19:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934609AbZDHRt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 13:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754904AbZDHRt2
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 13:49:28 -0400
Received: from relay.known.net ([67.121.255.169]:37571 "HELO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754825AbZDHRt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 13:49:28 -0400
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Apr 2009 13:49:27 EDT
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.17) id 000000034329; Wed, 8 Apr 2009 10:41:26 -0700
X-Mailer: MH-E 8.1; nmh 1.3; GNU Emacs 22.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116098>

I remember this working for me in the not too distant past.  
I'm using git version 1.6.1.3.  Perhaps it was an older version of git
when it worked for me.

quadra% ls -l src/c/sock.c
-rw-r--r-- 1 layer fi 57909 Mar  9 13:32 src/c/sock.c
quadra% git show :2:src/c/sock.c
fatal: ambiguous argument ':2:src/c/sock.c': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
quadra% git show :1:c/sock.c
fatal: ambiguous argument ':1:c/sock.c': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
quadra% git show :1:sock.c
fatal: ambiguous argument ':1:sock.c': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
quadra% git show :1:/src/c/sock.c
fatal: ambiguous argument ':1:/src/c/sock.c': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions




If I cd to "src/c" and do "git show :1:sock.c" the same thing happens.

Thanks.
