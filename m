From: Ray Lehtiniemi <rayl@mail.com>
Subject: problem viewing git.git with gitk on cygwin
Date: Mon, 16 Jul 2007 13:30:36 -0600
Message-ID: <200707161330.36907.rayl@mail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 21:52:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAWbz-0006hL-5h
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 21:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbXGPTwA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 15:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753187AbXGPTwA
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 15:52:00 -0400
Received: from static-68-179-52-57.ptr.terago.ca ([68.179.52.57]:44316 "EHLO
	mail.headplay.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbXGPTv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 15:51:59 -0400
X-Greylist: delayed 1231 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Jul 2007 15:51:59 EDT
Received: from linux.local ([192.168.1.201])
	by mail.headplay.com with ESMTP; Mon, 16 Jul 2007 13:31:08 -0600
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52708>



hi all

i'm seeing a problem with gitk on cygwin.  if i try and view the history of 
git itself, it seems to stop at version 22dcbb.  interestingly, the next 
commit 3ef378 has an embedded CTRL-Z character in the commit message.

possible DOS EOF handling bug? or is there a repo setting i need to be 
tweaking?

using git version 1.5.2.2, installed using the cygwin package setup tool.

thanks
ray
