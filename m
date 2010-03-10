From: MALAISE Pascal <malaise@magic.fr>
Subject: wishlist: git gui not listing untracked files in unstaged list
Date: Wed, 10 Mar 2010 19:43:18 +0000 (UTC)
Message-ID: <loom.20100310T203316-38@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 10 20:45:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpRqD-0002us-TW
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 20:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368Ab0CJTpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 14:45:08 -0500
Received: from lo.gmane.org ([80.91.229.12]:49306 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753462Ab0CJTpG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 14:45:06 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NpRq2-0002qA-O1
	for git@vger.kernel.org; Wed, 10 Mar 2010 20:45:02 +0100
Received: from fon31-1-78-224-49-155.fbx.proxad.net ([78.224.49.155])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Mar 2010 20:45:02 +0100
Received: from malaise by fon31-1-78-224-49-155.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Mar 2010 20:45:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 78.224.49.155 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.18) Gecko/2010021501 Ubuntu/8.04 (hardy) Firefox/3.0.18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141913>

Many projects are organized so that the result of compilation is mixed with
sources.
It would be very useful to configure git gui so that untracked files are not
listed in the un-staged list.
I have patched git gui, function rescan_stage2, line 1414 to do so:
  # set fd_lo [eval git_read ls-files --others -z $ls_others]
  set fd_lo [eval git_read ls-files -z $ls_others]

but it would be nice to make this behavior tunable via the "Options..." menu.
