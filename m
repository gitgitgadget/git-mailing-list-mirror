From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: integrity of a repository
Date: Sat, 15 Mar 2008 14:26:45 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20080315132645.GC17579@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 14:27:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaWQT-000060-0c
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 14:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbYCON0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 09:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbYCON0v
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 09:26:51 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:41417 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbYCON0u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 09:26:50 -0400
Received: from localhost.localdomain (xdsl-87-78-93-177.netcologne.de [87.78.93.177])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 5182B40002E2F
	for <git@vger.kernel.org>; Sat, 15 Mar 2008 14:26:49 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1JaWPN-0004cN-Hx
	for git@vger.kernel.org; Sat, 15 Mar 2008 14:26:45 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77330>

Hello giters,

I am aware that git provides integrity of a commit (and thus, a branch
head) via its sha, which covers both the tree and its history.

But what about the integrity of a git repository as a whole?

For example, if I have a set of branches, create a file listing
  branchname  sha-of-head

for each such branch, and hash that file, and also 'git gc --prune',
can I then be sure that not only does the repository contain exactly
what I want (namely all history of all branches), but also that it does
not contain any other material (say, stuff that may not be disclosed)?

Would I need the in file listing all local and remote branches?
What about all heads in .git/*HEAD (such as FETCH_HEAD)?

Thanks,
Ralf
