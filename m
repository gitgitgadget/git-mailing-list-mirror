From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFD] Overlapping projects
Date: Tue, 10 May 2005 00:56:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505100040320.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue May 10 06:50:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVMgh-0001ml-2X
	for gcvg-git@gmane.org; Tue, 10 May 2005 06:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVEJE4z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 00:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVEJE4z
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 00:56:55 -0400
Received: from iabervon.org ([66.92.72.58]:14342 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261552AbVEJE4u (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 00:56:50 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DVMnJ-0000Lo-00
	for git@vger.kernel.org; Tue, 10 May 2005 00:56:33 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It seems to me like projects like cogito which are based on a core which
is itself a project and which is also part of other projects would benefit
from some sort of support.

In particular, it would be nice if Linus could pull the changes to the
core without getting the wrapper programs at all.

I'm thinking something like having a head for cogito and a head for git in
the same repository, where the trees for git only have the core files, and
the commits for cogito have, in addition to a tree with only the
cogito-specific files, a reference to a git commit that they include.

It seems to me like this area contains a brilliant idea that I haven't
had so far, and maybe someone can come up with it.

	-Daniel
*This .sig left intentionally blank*

