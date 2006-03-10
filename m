From: Paul Mackerras <paulus@samba.org>
Subject: git-rev-list feature request
Date: Fri, 10 Mar 2006 12:07:07 +1100
Message-ID: <17424.53563.622642.738307@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 10 02:07:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHW6G-0001i7-ST
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 02:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422677AbWCJBHV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 20:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422678AbWCJBHU
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 20:07:20 -0500
Received: from ozlabs.org ([203.10.76.45]:48256 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1422677AbWCJBHS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 20:07:18 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 3470A679EF; Fri, 10 Mar 2006 12:07:15 +1100 (EST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17444>

Hi,

I'd like to implement a new features in gitk to enable it to show the
relationship of a given commit to the tags and other references.  What
I would like is for git-rev-list to be able to output a dense graph
containing only one or more specified commits plus all the commits
that have a reference (i.e. a file under $GIT_DIR/refs that contains
their SHA1 ID), plus the merges that are needed to complete the
graph.

It would be nice also to be able to combine that with the existing
ability to output a dense graph containing the commits that modify a
specified set of files or directories.

In other words, I would like to be able to select any combination of
(a) some explicitly specified commits
(b) commits that have a reference
(c) commits that affect specified files or directories

and have git-rev-list output a graph that shows the relationship of
those commits.

Possible?

Thanks,
Paul.
