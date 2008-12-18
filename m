From: Alan <alan@clueserver.org>
Subject: Odd merge behaviour involving reverts
Date: Thu, 18 Dec 2008 15:25:34 -0800
Message-ID: <1229642734.5770.25.camel@rotwang.fnordora.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 19 00:27:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDSGn-0007He-EX
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 00:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbYLRXZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 18:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752227AbYLRXZp
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 18:25:45 -0500
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:47780 "EHLO
	clueserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258AbYLRXZo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 18:25:44 -0500
Received: from [127.0.0.1] (blackbox.fnordora.org [127.0.0.1])
	by clueserver.org (Postfix) with ESMTP id 6BE7CF501C8
	for <git@vger.kernel.org>; Thu, 18 Dec 2008 15:25:37 -0800 (PST)
X-Mailer: Evolution 2.24.2 (2.24.2-1.fc10) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103508>

I am encountering an odd problem with how merging branches are working.
I expect I am doing something wrong, I just need to know what.

Here is my situation...

I have a master branch.  We have a branch off of that that some
developers are doing work on.  They claim it is ready. We merge it into
the master branch.  It breaks something so we revert the merge.  They
make changes to the code.  they get it to a point where they say it is
ok and we merge again.

When examined, we find that code changes made before the revert are not
in the master branch, but code changes after are in the master branch.

We now have code that does not contain all of the changes in the branch.

Is there a different way to undo merges into a branch that does not
block further merges from that branch?

What am i doing wrong here?
