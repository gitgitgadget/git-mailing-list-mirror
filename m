From: Sergei Organov <osv@javad.com>
Subject: Re: [PATCH 2/4] git.el: Added a command to amend a commit.
Date: Thu, 07 Feb 2008 16:23:23 +0300
Message-ID: <87prv8294k.fsf@osv.gnss.ru>
References: <87ve51orq8.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Thu Feb 07 14:24:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN6jj-0000dd-3k
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 14:24:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbYBGNXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 08:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752643AbYBGNXo
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 08:23:44 -0500
Received: from javad.com ([216.122.176.236]:3075 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636AbYBGNXn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 08:23:43 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id m17DNTd39519;
	Thu, 7 Feb 2008 13:23:29 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1JN6ip-0001wf-9T; Thu, 07 Feb 2008 16:23:23 +0300
In-Reply-To: <87ve51orq8.fsf@wine.dyndns.org> (Alexandre Julliard's message of "Thu\, 07 Feb 2008 13\:50\:39 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72938>

Alexandre Julliard <julliard@winehq.org> writes:

> It reverts the commit and sets up the status and edit log buffer to
> allow making changes and recommitting it. Bound to C-c C-a.

Nice! Doesn't it lack something like this:

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index c3c0c45..9ad37a1 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1385,6 +1385,7 @@ Return the list of files that haven't been handled."
     `("Git"
       ["Refresh" git-refresh-status t]
       ["Commit" git-commit-file t]
+      ["Ammend Commit" git-ammend-commit t]
       ("Merge"
 	["Next Unmerged File" git-next-unmerged-file t]
 	["Prev Unmerged File" git-prev-unmerged-file t]

-- Sergei.
