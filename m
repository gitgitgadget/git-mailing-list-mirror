From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Cherry picking instead of merges.
Date: Thu, 3 Jul 2008 22:13:54 +0200
Message-ID: <20080703201354.GA3546@steel.home>
References: <20080703182650.GA11166@old.davidb.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 03 22:14:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEVCi-0004Ap-GV
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 22:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbYGCUN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 16:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbYGCUN6
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 16:13:58 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:49844 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbYGCUN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 16:13:57 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20xf4EDTSQ==
Received: from tigra.home (Fae7d.f.strato-dslnet.de [195.4.174.125])
	by post.webmailer.de (fruni mo59) (RZmta 16.45)
	with ESMTP id g05a87k63Jx4cl for <git@vger.kernel.org>;
	Thu, 3 Jul 2008 22:13:55 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C755D277BD
	for <git@vger.kernel.org>; Thu,  3 Jul 2008 22:13:54 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 7205D56D27; Thu,  3 Jul 2008 22:13:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080703182650.GA11166@old.davidb.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87313>

David Brown, Thu, Jul 03, 2008 20:26:50 +0200:
> Yesterday, one developer cherry picked company B's changes into a branch.
> It appears he resolved the conflicts for each commit, which should make
> bisecting easier.
>
> The problem is that we now have very divergent history.

...and have absolutely no idea on what were the changes of the company
B were made.

> Any advice on how to make use of how he resolved conflicts in order to
> merge company B's changes in using git-merge. ...

Let that developer do the merge next time? Or let the B do a merge
with a commonly accepted base?
