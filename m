From: Junio C Hamano <junkio@cox.net>
Subject: [2/4] What's not in 1.5.2 (will cook in next)
Date: Wed, 16 May 2007 15:47:14 -0700
Message-ID: <11793556372693-git-send-email-junkio@cox.net>
References: <11793556363795-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 00:47:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoSHF-0005bn-70
	for gcvg-git@gmane.org; Thu, 17 May 2007 00:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168AbXEPWrW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 18:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757467AbXEPWrW
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 18:47:22 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:63591 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756168AbXEPWrS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 18:47:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070516224718.XAUZ19731.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Wed, 16 May 2007 18:47:18 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id zynG1W00a1kojtg0000200; Wed, 16 May 2007 18:47:17 -0400
X-Mailer: git-send-email 1.5.2.rc3.50.gfdcb7
In-Reply-To: <11793556363795-git-send-email-junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47468>

These have been cooking in 'pu'; will be in 'next' after 1.5.2
happens.

*  db/remote (Tue May 15 22:50:19 2007 -0400) 5 commits
 . Update local tracking refs when pushing
 . Add handlers for fetch-side configuration of remotes.
 . Move refspec parser from connect.c and cache.h to remote.{c,h}
 . Move remote parsing into a library file out of builtin-push.
 + git-update-ref: add --no-deref option for overwriting/detaching
   ref

This was rebased on to Sven's change to lock_any_ref_for_update();

*  dh/repack (Sun May 13 12:47:09 2007 -0700) 9 commits
 . git-repack --max-pack-size: add option parsing to enable feature
 . git-repack --max-pack-size: split packs as asked by
   write_{object,one}()
 . git-repack --max-pack-size: write_{object,one}() respect pack
   limit
 . git-repack --max-pack-size: new file statics and code
   restructuring
 . Alter sha1close() 3rd argument to request flush only
 + Custom compression levels for objects and packs
 + deprecate the new loose object header format
 + make "repack -f" imply "pack-objects --no-reuse-object"
 + allow for undeltified objects not to be reused

This follows the "custom compression levels" series from the
same author.
