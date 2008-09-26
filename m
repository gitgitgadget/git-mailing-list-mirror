From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: git-stash.sh: don't default to refs/stash if invalid ref supplied
Date: Fri, 26 Sep 2008 10:19:41 -0500
Message-ID: <rM3bh5QWZGeYnjwx4dCYZ179UgQYlxany_gu84OcX6FVMMOkKmGKWg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 26 17:46:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjFWv-0000Tx-Ee
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 17:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbYIZPpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 11:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbYIZPpn
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 11:45:43 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57998 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbYIZPpm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 11:45:42 -0400
X-Greylist: delayed 1557 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Sep 2008 11:45:42 EDT
Received: by mail.nrlssc.navy.mil id m8QFJg16011887; Fri, 26 Sep 2008 10:19:42 -0500
X-OriginalArrivalTime: 26 Sep 2008 15:19:42.0652 (UTC) FILETIME=[4D01F7C0:01C91FEB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96872>



   commit da65e7c133cd316c9076fbb6b0aeee7bc42a6db8
   Author: Brandon Casey <casey@nrlssc.navy.mil>
   Date:   Tue Sep 23 18:57:09 2008 -0500

       git-stash.sh: don't default to refs/stash if invalid ref supplied
    
       <snip>
    
       e.g. 'git stash apply stash@{1}' would fall back to
            'git stash apply stash@{0}'


heh, you fixed my spelling "mistake" :), but it wasn't a mistake. Originally
I had:

    e.g. 'git stash apply stahs@{1}' would fall back to
         'git stash apply stash@{0}'

intending to show that a simple spelling mistake could cause the wrong thing
to be done. The example in the commit message could actually still happen if
there was only a single stash entry. I guess I should have used 'foobar@{1}'. :)

-brandon
