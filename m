From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [0/5] Updates for library, fsck-cache
Date: Thu, 28 Apr 2005 01:00:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504280055180.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 06:56:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR13s-0006jB-2y
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 06:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVD1FAx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 01:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVD1FAx
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 01:00:53 -0400
Received: from iabervon.org ([66.92.72.58]:39428 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261976AbVD1FA1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 01:00:27 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DR18S-0001DX-00; Thu, 28 Apr 2005 01:00:24 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch series updates the parser library for some new things, adds a
function to parse an object of a type that's understood by the library but
not known in advance by the program, updates fsck-cache to use it, and
adds support for fsck-cache getting the root set out of .git/refs/.

 1: Consider a blob to be parsed
 2: Add tag header/parser to library
 3: Add function to parse an object of unspecified type.
 4: Rework fsck-cache to use parse_object().
 5: Make fsck-cache read heads out of .git/refs/*/*

	-Daniel
*This .sig left intentionally blank*

