From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/2] Fix local-pull on packed repository
Date: Tue, 16 Aug 2005 00:09:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508160004460.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Aug 16 06:07:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4siV-0003Un-AU
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 06:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbVHPEFy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 00:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbVHPEFy
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 00:05:54 -0400
Received: from iabervon.org ([66.92.72.58]:19978 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932592AbVHPEFx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 00:05:53 -0400
Received: (qmail 24304 invoked by uid 1000); 16 Aug 2005 00:09:13 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Aug 2005 00:09:13 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds essentially the same logic to local-pull that http-pull has, 
with the exception that it reads the index out of the source directory, 
rather than copying it. This, in turn, requires the ability to use an 
index file in some other directory.

 1: Use index file in another directory
 2: Copy/link/symlink pack files as appropriate

	-Daniel
*This .sig left intentionally blank*
