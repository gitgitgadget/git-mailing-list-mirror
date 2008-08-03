From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: ref markers link to named shortlogs
Date: Sun, 3 Aug 2008 14:03:50 +0200
Message-ID: <20080803120350.GW32184@machine.or.cz>
References: <1217691554-10407-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 14:04:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPcKS-0001Np-Ad
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 14:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973AbYHCMDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 08:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753585AbYHCMDv
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 08:03:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34921 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753531AbYHCMDv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 08:03:51 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 31953393A2E2; Sun,  3 Aug 2008 14:03:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1217691554-10407-1-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91234>

On Sat, Aug 02, 2008 at 05:39:14PM +0200, Giuseppe Bilotta wrote:
> This patch turns ref markers for tags and heads into links to
> shortlog/refname. Appropriate changes are made in the CSS to prevent ref
> markers to be annoyingly blue and underlined.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

I think this is good idea in principle, but

	(i) Why not do this for all the refs?

	(ii) I think you should decide on the type of the action based
on the object type of the ref; actually, any kind of object type can be
ref'd, and for tags you would rather want tag view, etc. (The tag view
actually sucks and should behave more like git show tag - i.e. append
the appropriate view after the tag info - but that is different matter.)

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
