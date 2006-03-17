From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: git-cvsimport "you may need to merge manually"
Date: 16 Mar 2006 18:37:39 -0800
Message-ID: <86veud23v0.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Mar 17 03:38:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FK4qx-000321-3g
	for gcvg-git@gmane.org; Fri, 17 Mar 2006 03:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWCQChp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 21:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWCQChp
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 21:37:45 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:42844 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750828AbWCQCho (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 21:37:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id C48D88F2FC
	for <git@vger.kernel.org>; Thu, 16 Mar 2006 18:37:39 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 11415-01-8 for <git@vger.kernel.org>;
 Thu, 16 Mar 2006 18:37:39 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 495FF8F2E3; Thu, 16 Mar 2006 18:37:39 -0800 (PST)
To: <git@vger.kernel.org>
x-mayan-date: Long count = 12.19.13.2.8; tzolkin = 2 Lamat; haab = 6 Cumku
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17651>


Starting recently, git-cvsimport has always ended with "you
may need to merge manually".  Why?  It worked before.  What
is it doing now?

    $ cd /home/merlyn/Git/stonehenge.git || exit 1
    $ git-cvsimport -v -k -o master -d /web/cvs stonehenge
    .
    .
    .
    skip patchset 323: 1142297290 before 1142351976
    Fetching htdocs/courses.html   v 1.4
    Update htdocs/courses.html: 8767 bytes
    Fetching htdocs/rates.html   v 1.2
    Update htdocs/rates.html: 2043 bytes
    Tree ID 38280334da5eaa4fd80fe1011e63db4b527f1d13
    Parent ID e93de754181fe963b8623423f509540021caead0
    Committed patch 324 (master 2006-03-16 18:14:31)
    Commit ID 985ca72d4e8a07d4189794231f035bac63c9e91d
    DONE; you may need to merge manually.
    $ git-status
    #
    # Updated but not checked in:
    #   (will commit)
    #
    #       modified: htdocs/courses.html
    #       modified: htdocs/rates.html
    #

Right... why didn't it commit those?  I'm having to issue "fake"
commits now, so I've lost the cvs-log comments that were formerly
very complete and cool.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
