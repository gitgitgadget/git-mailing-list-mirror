From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: [ANNOUNCE] Guilt v0.25
Date: Tue, 15 May 2007 13:58:32 -0400
Message-ID: <20070515175831.GE2126@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org, brandon@ifup.org
To: guilt@josefsipek.net
X-From: git-owner@vger.kernel.org Tue May 15 19:58:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho1IF-0007mZ-AB
	for gcvg-git@gmane.org; Tue, 15 May 2007 19:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754287AbXEOR6f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 13:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754553AbXEOR6f
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 13:58:35 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:48751 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346AbXEOR6e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 13:58:34 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l4FHwW7C016683;
	Tue, 15 May 2007 13:58:32 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l4FHwWhh016681;
	Tue, 15 May 2007 13:58:32 -0400
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47359>

Guilt v0.25 is available for download (once it mirrors out on kernel.org).

Guilt (Git Quilt) is a series of bash scripts which add a Mercurial
queues-like functionality and interface to git.

Tarballs:
http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/

Git repo:
git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git


Really the only major changes are the new commands: import and rebase.

guilt-import allows one to import a patch into the Guilt series easily

guilt-rebase is very similar to git-rebase - it detects patches that were
pushed upstream. NOTE: This command is still not perfect, so use it with
caution.

As always, patches, and other feedback is welcome.

Josef "Jeff" Sipek.

------------
Changes since v0.24:

Josef 'Jeff' Sipek (13):
      Docs: Fixed two small typos
      import: import a patch command
      import: Added -P to specify a name of the patch file within guilt
      new: Add an empty line after the message/signed-off-by
      guilt: be more careful when parsing hash ranges
      patchbomb: Added --in-reply-to argument
      rebase: Rebase pushed patches against an upstream branch
      docs: Skeleton of the rebase docs
      rebase: removed some leftover bits from git-cherry
      rebase: comment out patch instead of removing it
      rebase: created a helper function to pop all patches
      Fixed $PAGER detection logic
      Guilt v0.25
