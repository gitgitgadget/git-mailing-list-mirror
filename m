From: Ray Chen <rchen@cs.umd.edu>
Subject: Re: [PATCH v2] git-svn: New flag to emulate empty directories
Date: Wed, 1 Jun 2011 21:22:05 +0000 (UTC)
Message-ID: <loom.20110601T231627-922@post.gmane.org>
References: <1306391903-22092-1-git-send-email-rchen@cs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 23:25:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRsuk-00027K-HL
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 23:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201Ab1FAVZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 17:25:10 -0400
Received: from lo.gmane.org ([80.91.229.12]:35728 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607Ab1FAVZI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 17:25:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QRsuY-00022x-97
	for git@vger.kernel.org; Wed, 01 Jun 2011 23:25:06 +0200
Received: from c-76-21-241-143.hsd1.md.comcast.net ([76.21.241.143])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 23:25:06 +0200
Received: from rchen by c-76-21-241-143.hsd1.md.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 23:25:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 76.21.241.143 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.6.17-1.fc14 Firefox/3.6.17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174903>

Ray Chen <rchen <at> cs.umd.edu> writes:

> 
> Adds the --preserve-empty-dirs flag to the clone operation that will
> detect empty directories in the target Subversion repository and create
> placeholder files in the corresponding local Git directories.  This allows
> "empty" directories to exist in the history of a Git repository.
> 
> Also adds the --placeholder-file flag to control the name of any
> placeholder files created.  Default value is ".gitignore".
> 

Is there anything I can do to make this patch more palatable for inclusion?

It'd also be fine if this patch got left by the wayside.  I recognize that
cloning Subversion repositories with empty directories is something of a corner
case.

- Ray
