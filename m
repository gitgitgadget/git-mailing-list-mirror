From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-merge-ff: fast-forward only merge
Date: Thu, 28 Jun 2007 13:33:46 +0200
Message-ID: <20070628113346.GA4914@moooo.ath.cx>
References: <1182830470640-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Jun 28 13:33:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3sG1-00009Z-4d
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 13:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758442AbXF1Ldw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 07:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757702AbXF1Ldw
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 07:33:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:57482 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755257AbXF1Ldv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 07:33:51 -0400
Received: (qmail invoked by alias); 28 Jun 2007 11:33:49 -0000
Received: from pD9EBB5BD.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.189]
  by mail.gmx.net (mp001) with SMTP; 28 Jun 2007 13:33:49 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1++nfVi4C6+IR+fpbvbx45AgP//d2GgstYPLH25uW
	utiDxQejt/lba5
Content-Disposition: inline
In-Reply-To: <1182830470640-git-send-email-sam.vilain@catalyst.net.nz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51100>

Sam Vilain <sam.vilain@catalyst.net.nz> wrote:
> This is primarily so that there is an easy switch to 'git-pull' to
> be sure to fast forward only.
> ---
>  Documentation/merge-strategies.txt |    5 +++++
>  Makefile                           |    2 +-
>  git-merge-ff.sh                    |    8 ++++++++
>  3 files changed, 14 insertions(+), 1 deletions(-)
>  create mode 100644 git-merge-ff.sh

git-merge-ff.sh should be executable, added to .gitignore and the
strategy should be added to the available strategies.

And somehow it did not work for me at all:

% git merge -s ff origin/master
git-merge.sh: needs update   
Trying really trivial in-index merge...
Wonderful.
In-index merge
[..]
% git show HEAD|grep Merge
Merge: 117a93c... f578825...
    Merge commit 'origin/master'
