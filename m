From: Junio C Hamano <junkio@cox.net>
Subject: Re: Merge git-gui into 1.5.0 ?
Date: Mon, 12 Feb 2007 13:55:42 -0800
Message-ID: <7v64a782ht.fsf@assigned-by-dhcp.cox.net>
References: <20070211084030.GE2082@spearce.org>
	<7vwt2oba8s.fsf@assigned-by-dhcp.cox.net>
	<20070211224158.GA31488@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 22:55:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGj9H-00025p-8u
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 22:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965289AbXBLVzo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 16:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965338AbXBLVzn
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 16:55:43 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:45571 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965289AbXBLVzn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 16:55:43 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070212215543.GYC4586.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 12 Feb 2007 16:55:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Nlvi1W00R1kojtg0000000; Mon, 12 Feb 2007 16:55:42 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39443>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> git-gui development is going to continue past 1.5.0's release.
> There are still a lot of operations it should support that it
> currently does not do, and there are certainly user interface
> improvements that can still be made.
>
> It may be saner for all involved if that development happens in
> the git-gui.git repository, with drops made to git.git by way of
> merging the "subproject" every so often.

Ok, so here is what I did last night.

$ git remote show git-gui
* remote git-gui
  URL: git://repo.or.cz/git-gui.git/
  Tracked remote branches
    master
$ git fetch git-gui
$ git read-tree --prefix=git-gui/ git-gui/master
$ git checkout git-gui
$ git rev-parse git-gui/master >.git/MERGE_HEAD
$ git commit
