From: Bill Lear <rael@zopyra.com>
Subject: How to archive repo from sub-directory
Date: Mon, 10 Mar 2008 18:33:04 -0600
Message-ID: <18389.54080.211086.922039@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 01:33:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYsRA-00013H-D6
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 01:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbYCKAdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 20:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbYCKAdJ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 20:33:09 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61537 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbYCKAdI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 20:33:08 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id m2B0X7W22779;
	Mon, 10 Mar 2008 18:33:07 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76777>

If I have a git repo with several levels of sub-directories, how
do I get git-archive to archive the entire tree, and not just
the tree from where I am?  Example:

% cd foo
% cat .git/description
foo project
% cd bar/baz
% git archive --format=tar --prefix=foo/ HEAD | bzip2 > foo.tar.bz2

produces a tar file starting only at baz.

If I can't conjur this on the command line with a clever argument to
git archive (I've tried several), then how would I ask git "What is
your top-level directory" so at least I could write a script to
do this?


Bill
