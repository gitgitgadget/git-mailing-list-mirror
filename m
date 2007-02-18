From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Attempt to improve git-rebase lead-in description.
Date: Sun, 18 Feb 2007 03:21:14 +0100
Organization: At home
Message-ID: <er8d34$ssm$1@sea.gmane.org>
References: <20070217093150.GA25871@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 18 03:19:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIbeL-0000fM-Aw
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 03:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993151AbXBRCTe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 21:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993153AbXBRCTe
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 21:19:34 -0500
Received: from main.gmane.org ([80.91.229.2]:56536 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993151AbXBRCTd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 21:19:33 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HIbeE-0007XV-HU
	for git@vger.kernel.org; Sun, 18 Feb 2007 03:19:30 +0100
Received: from host-81-190-26-89.torun.mm.pl ([81.190.26.89])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Feb 2007 03:19:30 +0100
Received: from jnareb by host-81-190-26-89.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Feb 2007 03:19:30 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-89.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40056>

Shawn O. Pearce wrote:

> +
> +The commits that were previously saved into the temporary area are
> +then reapplied to the current branch, one by one, in order.

Which is true for git-format-patch/git-am --3way driven "git rebase",
but not for git-merge driven "git rebase --merge".

The description is certainly more user-friendly, but I'd rather it avoid
mentioning saving to temporary area.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
