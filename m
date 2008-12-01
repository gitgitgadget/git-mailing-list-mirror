From: Csaba Henk <csaba-ml@creo.hu>
Subject: Is rebase always destructive?
Date: Mon, 1 Dec 2008 11:41:39 +0000 (UTC)
Message-ID: <slrngj7jch.2srb.csaba-ml@beastie.creo.hu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 12:43:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L77BO-0000Yb-VR
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 12:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022AbYLALlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 06:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753891AbYLALlx
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 06:41:53 -0500
Received: from main.gmane.org ([80.91.229.2]:43441 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753512AbYLALlw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 06:41:52 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L779u-0001qG-1I
	for git@vger.kernel.org; Mon, 01 Dec 2008 11:41:46 +0000
Received: from www.creo.hu ([217.113.62.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 11:41:46 +0000
Received: from csaba-ml by www.creo.hu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 11:41:46 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: www.creo.hu
User-Agent: slrn/0.9.8.1 (FreeBSD)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102021>

Hi,

When doing a rebase, I can find a number of reasons for which one might
feel like to preserve the rebased branch (that is, perform an operation
which copies the branch over a new base, not moves).

-  For example, a successful rebase doesn't necessarily mean that the
   code, as of the rebased branch, is consistent and compiles. That is,
   the rebase can be broken even if git can put things together diff-wise.
   In such a case I wouldn't be happy to lose the original instance of
   the branch.

-  Or I might want to build different versions of the program, and each
   version of it needs a given set of fixes (the same one). Then rebasing
   my bugfix branch is not a good idea, I'd much rather copy it over all
   those versions.

I can't see any option for rebase which would yield this cp-like
behaviour. Am I missing something? Or people don't need such a feature?
(Then give me some LART please, my mind is not yet gittified enough to
see why is this not needed.) Or is it usually done by other means, not
rebase?

Thanks
Csaba
