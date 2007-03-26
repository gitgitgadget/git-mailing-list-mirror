From: Daniel Barkalow <barkalow@iabervon.org>
Subject: tar commit header names
Date: Mon, 26 Mar 2007 12:39:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0703261230420.6485@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 18:39:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVsER-00065j-Ol
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 18:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbXCZQjd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 12:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752955AbXCZQjd
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 12:39:33 -0400
Received: from iabervon.org ([66.92.72.58]:3099 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752951AbXCZQjc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 12:39:32 -0400
Received: (qmail 13417 invoked by uid 1000); 26 Mar 2007 12:39:31 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Mar 2007 12:39:31 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43157>

I'm entirely ignorant of pax header stuff, but would it be possible to 
have the pax header specify which project this commit is from (which has 
to come from a git-archive option, clearly). Also, could 
git-get-tar-commit-id have an option to look for more pax headers beyond 
the first? (I'm building tar files by appending multiple archives for 
different projects from git-archive, and I suddenly find the embedded 
commit id is helpful, and surprisingly inaccessible in this context.)

	-Daniel
*This .sig left intentionally blank*
