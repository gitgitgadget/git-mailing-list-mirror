From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [BUG] unable to checkout branch with a clean worktree
Date: Mon, 5 Jan 2009 17:05:27 +0100
Message-ID: <20090105160527.GA7718@localhost>
References: <35079.bFoQE3daRhY=.1231170168.squirrel@webmail.hotelhot.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Mon Jan 05 17:08:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJrza-0008Gv-8c
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 17:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbZAEQGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 11:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712AbZAEQGT
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 11:06:19 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:34639 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbZAEQGS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 11:06:18 -0500
Received: from darc.dyndns.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 5 Jan 2009 17:06:14 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LJrxH-00023u-Si; Mon, 05 Jan 2009 17:05:27 +0100
Content-Disposition: inline
In-Reply-To: <35079.bFoQE3daRhY=.1231170168.squirrel@webmail.hotelhot.dk>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 05 Jan 2009 16:06:15.0279 (UTC) FILETIME=[8943C7F0:01C96F4F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104582>

On Mon, Jan 05, 2009 at 04:42:48PM +0100, Anders Melchiorsen wrote:
> Git v1.6.1: The final checkout fails with an error about merge conflicts.
> However, the worktree is clean, and I am not trying to do a merge.
> 
> Is this a known issue? If so, what is the particular issue that we should
> avoid?

This is fixed by the recent patches for verify_absent. (Actually, just PATCH
2/3 should be enough to fix this issue.)

http://article.gmane.org/gmane.comp.version-control.git/104317
