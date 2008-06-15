From: Vaclav Hanzl <hanzl@noel.feld.cvut.cz>
Subject: Re: [PATCH] Documentation: Note about the meaning of "clone"
Date: Sun, 15 Jun 2008 19:03:04 +0200 (CEST)
Message-ID: <20080615.190304.41663135.hanzl@noel.feld.cvut.cz>
References: <20080614.150548.71104932.hanzl@noel.feld.cvut.cz>
	<m3od63ozuf.fsf@localhost.localdomain>
	<200806151505.27686.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: jnareb@gmail.com, git@vger.kernel.org, gitster@pobox.com
To: robin.rosenberg.lists@dewire.com
X-From: git-owner@vger.kernel.org Sun Jun 15 19:09:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7vjm-0001dy-V3
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 19:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758492AbYFORIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 13:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758540AbYFORIZ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 13:08:25 -0400
Received: from magi4.feld.cvut.cz ([147.32.198.214]:48273 "EHLO mepi"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758481AbYFORIY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 13:08:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by mepi (Postfix) with ESMTP id 8A6E3FD806;
	Sun, 15 Jun 2008 19:03:04 +0200 (CEST)
In-Reply-To: <200806151505.27686.robin.rosenberg.lists@dewire.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85100>

> +*NOTE*: Although this command is called clone, the clone is not identical
> +in all respects. Local branches in the repository being cloned
> +becomes remote tracking branches in the clone and remote tracking
> +branches are not cloned at all. For security reasone the config sections
> +and triggers are not cloned either.

In order to better specify what gets cloned and what does not, one
might also replace "active branch" (under DESCRIPTION) with "current
branch".

According to grep in Documentation/*.txt, "current branch" is used
much more often than "active branch". Most frequent use of term
"active branch" is found in git-fast-import.txt and it seems to mean
something else there.

(The fact that tiny volatile detail - which branch happens to be
checked out at the moment of clone - has profound influence on the
result of clone was quite a surprise for me, so I would like to
see this described as exactly as possible.)

Regards

Vaclav
