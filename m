From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 0/2] Documentation fixes for git-svn.txt
Date: Mon, 25 Apr 2011 14:06:23 -0700
Message-ID: <20110425210623.GB13953@dcvr.yhbt.net>
References: <1303491819-9850-1-git-send-email-valentin.haenel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Valentin Haenel <valentin.haenel@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 25 23:06:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QESzF-0000np-Mn
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 23:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984Ab1DYVGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 17:06:24 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40800 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752629Ab1DYVGX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 17:06:23 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id D81061F6AA;
	Mon, 25 Apr 2011 21:06:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1303491819-9850-1-git-send-email-valentin.haenel@gmx.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172047>

Valentin Haenel <valentin.haenel@gmx.de> wrote:
> My remaining question regarding the second option, '--add-author-from',
> is about the subcommands which it is applicable to. The current
> documentation states 'commit' and 'dcommit'. My feeling is that 'commit'
> is a typo, since 'git svn' does not have a 'commit' subcommand. I had a
> look at the code, and while I am not familiar with perl, it seems to me
> that the three subcommands that use the option are 'commit-diff',
> 'set-tree' and 'dcommit'. But this is non-trivial -- feedback is
> appreciated.

Yes, commit-diff, set-tree, and dcommit all use --add-author-from.

I don't have time to build the docs and test formatting, but your
changes all look reasonable, consider them:

Acked-by: Eric Wong <normalperson@yhbt.net>

Thanks!

-- 
Eric Wong
