From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] bash completion: Hide more plumbing commands
Date: Thu, 4 Sep 2008 00:31:18 +0200
Message-ID: <20080903223118.GW10544@machine.or.cz>
References: <20080826171012.GO10360@machine.or.cz> <20080826171144.21328.82727.stgit@localhost> <20080826172410.GJ26523@spearce.org> <7v1w0bab1c.fsf@gitster.siamese.dyndns.org> <20080903222350.GC10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	andi@firstfloor.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 00:32:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb0to-0002X2-Kv
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 00:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbYICWbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 18:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbYICWbX
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 18:31:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51479 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757AbYICWbW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 18:31:22 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id F20573939B3B; Thu,  4 Sep 2008 00:31:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080903222350.GC10360@machine.or.cz>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94867>

On Thu, Sep 04, 2008 at 12:23:50AM +0200, Petr Baudis wrote:
> I started on a patch, but frankly, I hate it. Adding such a filtering to
> git-status is quite invasive, while I believe that it's simply not worth
> it - I have yet to encounter a situation with git when simply looking at
> either git diff or plain git status is impractical to check which files
> need to be merged yet, so I don't want to expend energy on a patch which
> is going to be ugly and useless by my belief.
> 
> If you do insist that we need this functionality, can you please just
> drop the git ls-files bit from the patch, or should I resend it?

It just occured to me - what about

	git diff --diff-filter=U [--name-status]

or is that too long? (The universal answer being, "you can alias it".
;-)

				Petr "Pasky" Baudis
