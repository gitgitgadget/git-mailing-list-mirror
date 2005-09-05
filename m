From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/4] Support multiple ancestors in read-tree
Date: Mon, 5 Sep 2005 02:03:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509050151240.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Sep 05 08:00:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECA11-0003ms-JD
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 07:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbVIEF7Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 01:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVIEF7Z
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 01:59:25 -0400
Received: from iabervon.org ([66.92.72.58]:32530 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932218AbVIEF7Z (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 01:59:25 -0400
Received: (qmail 22853 invoked by uid 1000); 5 Sep 2005 02:03:17 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Sep 2005 02:03:17 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8084>

Various messages have already described this series. There's still a 
memory leak that should get resolved, but otherwise it should work. I'm 
not entirely sure that all directory-file conflict cases are handled 
properly, and some undefined cases behave differently. Also, I was a bit 
careless with preparing the patches.

	-Daniel
*This .sig left intentionally blank*
