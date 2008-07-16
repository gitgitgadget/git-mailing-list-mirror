From: Lars Noschinski <lars-2008-1@usenet.noschinski.de>
Subject: Re: git-cvsexportcommit keyword mismatch issue
Date: Wed, 16 Jul 2008 23:16:26 +0000 (UTC)
Message-ID: <20080716231622.GA5399@lars.home.noschinski.de>
References: <E1KJ30U-0004EL-BV@corti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 02:11:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJH5T-0003cI-5f
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 02:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbYGQAKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 20:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbYGQAKM
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 20:10:12 -0400
Received: from main.gmane.org ([80.91.229.2]:52352 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbYGQAKK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 20:10:10 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KJH4M-0003aP-8U
	for git@vger.kernel.org; Thu, 17 Jul 2008 00:10:02 +0000
Received: from xdsl-87-78-234-55.netcologne.de ([87.78.234.55])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 00:10:02 +0000
Received: from lars-2008-1 by xdsl-87-78-234-55.netcologne.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 00:10:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: xdsl-87-78-234-55.netcologne.de
Content-Disposition: inline
In-Reply-To: <E1KJ30U-0004EL-BV@corti>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88788>

* Barak A. Pearlmutter <barak@cs.nuim.ie> [08-07-16 11:09]:
>Simply avoiding expanded keywords should solve the problem.  I thought
>git-cvsimport -k would keep them out of my git repo, but no such luck.
>Even when I use "cvs checkout -kk" for the CVS sandbox and then
>"git-cvsimport -k", keywords were *still* expanded in my git repo.
>(This is with both git 1.4.4.4 and git 1.5.6.)  Either the -k switch
>to git-cvsimport is busted, or I'm doing something wrong.

git-cvsimport -k works for me as of version 1.5.5.2 and 1.5.6.2.

In my opinion, git-cvsexportcommit misses an option -k to do cvs update
with -kk (as -kk is sticky for already checked out files, but not for
the whole repository, so new files will not get -kk set). If I cannot
get rid of this cvs repository soon, I'll probably cook up a patch for
it.
