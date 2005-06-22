From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/2] Pull objects of various types
Date: Tue, 21 Jun 2005 20:33:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506212029190.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Jun 22 02:28:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dkt6l-0007QS-6i
	for gcvg-git@gmane.org; Wed, 22 Jun 2005 02:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbVFVAes (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Jun 2005 20:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbVFVAes
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jun 2005 20:34:48 -0400
Received: from iabervon.org ([66.92.72.58]:35334 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262146AbVFVAeq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2005 20:34:46 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DktB9-0003HU-00; Tue, 21 Jun 2005 20:33:19 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This series handles pulling objects of various types, rather than just
commits. In order to support pulling tags (the interesting case), it is
necessary to support getting the struct object for the tagged object when
the tagged object isn't available.

 1: Support getting a valid struct object for the absent object tagged by
    a tag file.
 2: Support processing objects of unknown type in pull.c

	-Daniel
*This .sig left intentionally blank*

