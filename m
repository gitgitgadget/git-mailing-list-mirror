From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to make a repository config up-to-date
Date: Thu, 19 Apr 2007 17:07:31 -0700
Message-ID: <7v7is76h8c.fsf@assigned-by-dhcp.cox.net>
References: <20070419234532.GA38838@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Olivier Galibert <galibert@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 02:07:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hegf3-00078f-6B
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 02:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031166AbXDTAHd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 20:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031164AbXDTAHd
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 20:07:33 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:55011 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031145AbXDTAHd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 20:07:33 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070420000732.TXKK1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 19 Apr 2007 20:07:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pC7X1W00g1kojtg0000000; Thu, 19 Apr 2007 20:07:32 -0400
In-Reply-To: <20070419234532.GA38838@dspnet.fr.eu.org> (Olivier Galibert's
	message of "Fri, 20 Apr 2007 01:45:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45049>

Olivier Galibert <galibert@pobox.com> writes:

> I've got a number of a little over one year old repositories I do my
> private stuff into.  Looks like in that year things changed quite a
> bit (remote going from files to some kind of config file?  reflog
> stuff?).  What should I do to change them to what would be considered
> an up-to-date, full bells-and-whistles configuration?

A better question to ask before that is "do I need to change to
take advantage of any bells-and-whistles", I think.

* To enable reflog in your repository with working-tree, you do
  not have to do anything.  It's on by default.

* $GIT_DIR/remotes/origin is still consulted for a pull/fetch.
  If you do not do complicated multi-branch workflow, you do not
  gain much by moving that information to .git/config.

There is a contrib/remotes2config.sh script that copies
information from remotes/origin into .git/config if you are
interested.
