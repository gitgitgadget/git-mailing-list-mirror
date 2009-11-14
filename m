From: Paul Mackerras <paulus@samba.org>
Subject: Re: [gitk] [PATCH] 0/2 Merging master into dev
Date: Sat, 14 Nov 2009 22:20:10 +1100
Message-ID: <19198.37482.530441.875982@cargo.ozlabs.ibm.com>
References: <871vkbw7x2.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Nov 14 12:21:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9GgY-0000Dr-UG
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 12:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370AbZKNLUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 06:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbZKNLUg
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 06:20:36 -0500
Received: from ozlabs.org ([203.10.76.45]:54593 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751760AbZKNLUg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 06:20:36 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 62CBCB7B5F; Sat, 14 Nov 2009 22:20:41 +1100 (EST)
In-Reply-To: <871vkbw7x2.fsf@users.sourceforge.net>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132870>

Pat Thoyts writes:

> I've merged the current changes for gitk master onto the dev branch
> and fixed some conflicts and then modified the default colour
> assignments for windows to use the system colours so that it will pick
> up the stock colours defined via the windows property pages.
> 
> However, I'm not too certain how to post such a merge commit. Usually
> I do 'git format-patch -M' but in this case that emits all the commits
> that were merged. It looks like 'git show -p' is producing a merge
> patch so I am posting that for 1/2 and a normal patch for 2/2. If
> there is better way let me know and I will redo.

I don't think there is a way to send a merge commit by email.  I think
you would have to put a repository somewhere with the merge in it and
invite me to pull it.

In any case, I have just merged the dev branch into the master branch
and then applied your second patch, and pushed out the result.

Paul.
