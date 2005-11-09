From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Problems with binary patches (pull) and spaces in filenames (gitk)
Date: Wed, 9 Nov 2005 22:37:30 +0100
Message-ID: <20051109213730.GA23052@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Nov 09 22:46:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZxjq-0003OJ-9W
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 22:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030780AbVKIVoK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 16:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030781AbVKIVoK
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 16:44:10 -0500
Received: from ebar091.ebar.dtu.dk ([192.38.93.106]:13232 "HELO
	ebar091.ebar.dtu.dk") by vger.kernel.org with SMTP id S1030780AbVKIVoI
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 16:44:08 -0500
Received: (qmail 23122 invoked by uid 5842); 9 Nov 2005 21:37:30 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11416>

Hello,

I've got a nice project, where I am tracking both binary files and
filenames with spaces.  So, I've noticed two small cosmetic bugs:

1) When pulling an updated binary files, I guess it still tries to 
   print this update summary by making and processing patches, and so
   gives this error:

       Updating from ab1c4033ba98c043e13da3446e7f244ac7f79942 to
       c164231f6b59fd80171e95f31d762a80d884c708.
       Fast forward
       fatal: patch with only garbage at line 3249

2) When there are spaces in filenames, gitk only shows the first part of
   the name in the filelist at the buttom right.


Regards,

Peter
