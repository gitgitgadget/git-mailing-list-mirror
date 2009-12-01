From: Dale Farnsworth <dale@farnsworth.org>
Subject: Re: Transplant branch from another repository
Date: Tue, 01 Dec 2009 09:53:41 -0700
Message-ID: <E1NFVyv-0000EN-Qx@xyzzy.farnsworth.org>
References: <hf2t2i$l2b$1@xyzzy.farnsworth.org>
To: jeenuv@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 18:22:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFWRF-0008Ng-NP
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 18:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753710AbZLARWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 12:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753641AbZLARWp
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 12:22:45 -0500
Received: from xyzzy.farnsworth.org ([65.39.95.219]:39490 "EHLO
	xyzzy.farnsworth.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462AbZLARWo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 12:22:44 -0500
X-Greylist: delayed 1742 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Dec 2009 12:22:44 EST
Received: from dale by xyzzy.farnsworth.org with local (Exim 4.69)
	(envelope-from <dale@farnsworth.org>)
	id 1NFVyv-0000EN-Qx; Tue, 01 Dec 2009 09:53:47 -0700
In-Reply-To: <hf2t2i$l2b$1@xyzzy.farnsworth.org>
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on xyzzy.farnsworth.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NO_RELAYS
	autolearn=ham version=3.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134233>

> Say, I have two repositories A and B (local, independent, but similar
> - they are for content tracking and not collaboration purposes). A has
> a branch 'a', which I want to have in B. What I mean is that I'd like
> to have the sequence of changes in the branch 'a' to be present in B,
> thus creating an independent branch 'b' in B.
> 
> Is there any way to achieve this? One thing that I could think of is
> to use 'format-patch' to generate the list of patch files from A. But
> I don't see how to convert those patches to a sequence of commits in
> repo B. I could do a 'git apply patches/*' but then all patches
> collapse to one single commit. If format-patch is a/the way, could
> somebody tell me how to get this done? Or are there any alternatives?
> 
> FWIW: I'm running Git under Cygwin, and sendmail isn't configured.

Try "cd B; git fetch A a:b"

-Dale


Dale Farnsworth
