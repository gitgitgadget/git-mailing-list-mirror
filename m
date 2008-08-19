From: Lucas Carlson <lucas.carlson@me.com>
Subject: git merge bus error
Date: Tue, 19 Aug 2008 15:23:42 -0700
Message-ID: <EA1ADBE3-C9A8-49DE-B135-62A46F2FD666@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 01:25:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVaZS-0003oX-2u
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 01:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756006AbYHSXXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 19:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757365AbYHSXXq
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 19:23:46 -0400
Received: from asmtpout030.mac.com ([17.148.16.105]:42287 "EHLO
	asmtpout030.mac.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757350AbYHSXXp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 19:23:45 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Aug 2008 19:23:45 EDT
Received: from [10.0.1.200] ([76.27.235.229])
 by asmtp030.mac.com (Sun Java(tm) System Messaging Server 6.3-7.03 (built Aug
 7 2008; 32bit)) with ESMTPSA id <0K5V006M2CVJMK50@asmtp030.mac.com> for
 git@vger.kernel.org; Tue, 19 Aug 2008 15:23:44 -0700 (PDT)
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92935>

/usr/local/bin/git-merge: line 438: 19000 Bus error               git- 
merge-$strategy $common -- "$head_arg" "$@"

I have tried every merge strategy there is. It ends up leaving a .git/ 
index.lock file. I used git 1.5.6 and tried upgrading to 1.6.0. The  
only thing 1.6.0 did was hide this bus error message but I assume it  
still bus errors because there is a .git/index.lock file still.

Unfortunately the source code is proprietary so I can not let you try  
it on your own but let me know what I can run on my machine to help  
you guys track down this bus error.

-Lucas
http://rufy.com/
