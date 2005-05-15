From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 4/4] Pulling refs by ssh
Date: Sun, 15 May 2005 11:48:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505151146540.30848-100000@iabervon.org>
References: <4284F909.9000309@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun May 15 17:49:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXLMP-0001Hi-6F
	for gcvg-git@gmane.org; Sun, 15 May 2005 17:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVEOPtG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 11:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVEOPtG
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 11:49:06 -0400
Received: from iabervon.org ([66.92.72.58]:11270 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261670AbVEOPtE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2005 11:49:04 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DXLLy-000355-00; Sun, 15 May 2005 11:48:30 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4284F909.9000309@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 13 May 2005, H. Peter Anvin wrote:

> Use && rather than semicolon, and make sure you quote things that need 
> to be quoted.

This is a separate issue from the change for refs; could you send a patch
that quotes things properly? The "cd" should be unnecessary now that we
have the GIT_DIR environment variable.

	-Daniel
*This .sig left intentionally blank*

