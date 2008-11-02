From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: change dashed git-commit-tree to git
	commit-tree
Date: Sun, 2 Nov 2008 01:38:58 -0800
Message-ID: <20081102093858.GA16003@untitled>
References: <20081031041025.GB20322@euler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Sun Nov 02 10:40:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwZRR-0006I0-6p
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 10:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213AbYKBJjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 04:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbYKBJjB
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 04:39:01 -0500
Received: from hand.yhbt.net ([66.150.188.102]:60219 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065AbYKBJjA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 04:39:00 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 287A52DC01B;
	Sun,  2 Nov 2008 09:39:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081031041025.GB20322@euler>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99833>

Deskin Miller <deskinm@umich.edu> wrote:
> Signed-off-by: Deskin Miller <deskinm@umich.edu>
> ---
> Once again I'm using a copy of git-svn.perl directly, and this fails to exec.
> I looked at it more closely and it fails because git binary calls setup_path,
> which puts the libexec path into $PATH; of course, this doesn't happen when
> git-svn is called directly.

Thanks Deskin, looks like Junio already picked it up; but if we had
git-notes I'd add my Signed-off-by there :)


Also, on the subject of using git-svn.perl directly from the source
tree, it may become less usable that way in the near future:

Most of us (myself included) at GitTogether seemed like the idea of
splitting git-svn.perl into multiple files for maintainability reasons.
I just haven't gotten around to doing it yet.

OTOH, Git.pm is already required (but likely also installed in your
normal load paths); so you may just have to remember to use perl -I

-- 
Eric Wong
