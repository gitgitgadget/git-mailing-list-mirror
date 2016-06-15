From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] --amend Rename --pretty=changelog to --pretty=gnucl
Date: Fri, 02 Mar 2007 00:49:54 -0800
Message-ID: <7vslcoghcd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702271621120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0702280258200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<alpine.LRH.0.82.0702272147590.29426@xanadu.home>
	<Pine.LNX.4.63.0702281343200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Simon Josefsson <simon@josefsson.org>, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 02 09:50:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN3Si-0006G9-23
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 09:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422681AbXCBIt5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 03:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422699AbXCBIt5
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 03:49:57 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:38682 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422681AbXCBIt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 03:49:56 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070302084955.NTGT2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 2 Mar 2007 03:49:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Vkpv1W0021kojtg0000000; Fri, 02 Mar 2007 03:49:55 -0500
In-Reply-To: <Pine.LNX.4.63.0702281343200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 28 Feb 2007 13:44:46 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41168>

Is it just me or is your word wrapper misbehaving?  Notice the
line that ends with read-cache.c, and the line the comes after
it, in the sample output.

$ ./git show -s --pretty=gnucl ':/convert object type h'
2007-02-26  Nicolas Pitre <nico@cam.org>

        * archive-tar.c, archive-zip.c, blob.c, builtin-apply.c,
          builtin-blame.c, builtin-cat-file.c, builtin-commit-tree.c,
          builtin-for-each-ref.c, builtin-grep.c, builtin-log.c,
          builtin-pack-objects.c, builtin-prune.c, builtin-reflog.c,
          builtin-unpack-objects.c, cache.h, combine-diff.c, commit.c,
          convert-objects.c, diff.c, entry.c, fast-import.c, http-push.c,
          index-pack.c, merge-file.c, merge-recursive.c, merge-tree.c,
          mktag.c, mktree.c, object.c, object.h, pack-check.c, read-cache.c
           sha1_file.c, tag.c, tree-diff.c, tree.c, unpack-file.c: convert
          object type handling from a string to a number
