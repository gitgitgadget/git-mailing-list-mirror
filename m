From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: ref markers link to named shortlogs
Date: Sun, 3 Aug 2008 15:20:50 +0200
Message-ID: <20080803132050.GA10151@machine.or.cz>
References: <1217691554-10407-1-git-send-email-giuseppe.bilotta@gmail.com> <20080803120350.GW32184@machine.or.cz> <cb7bb73a0808030614v260dea2ek6757b7a22b13afa2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 15:21:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPdX3-0005bq-K4
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 15:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701AbYHCNUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 09:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754530AbYHCNUy
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 09:20:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42139 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753986AbYHCNUx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 09:20:53 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id C00B5393A2E4; Sun,  3 Aug 2008 15:20:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <cb7bb73a0808030614v260dea2ek6757b7a22b13afa2@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91238>

On Sun, Aug 03, 2008 at 03:14:09PM +0200, Giuseppe Bilotta wrote:
> On Sun, Aug 3, 2008 at 2:03 PM, Petr Baudis <pasky@suse.cz> wrote:
> >        (ii) I think you should decide on the type of the action based
> > on the object type of the ref; actually, any kind of object type can be
> > ref'd, and for tags you would rather want tag view, etc. (The tag view
> > actually sucks and should behave more like git show tag - i.e. append
> > the appropriate view after the tag info - but that is different matter.)
> 
> Funny that. My original plan was to have a different action depending
> on tag (I tried shortlog for tag and commitdiff for branch). And since
> I I had no idea what kind of action to use for 'generic' refs, I left
> them out. Then I had second thoughts and started using shortlog for
> both heads and tags, and collapsed the code but still kept the generic
> refs out of the way. So maybe we can use shortlog as default action
> and single out tags (and whatever else we'll find to need a different
> action)?

What's wrong with my proposed approach to choose actoin based on object
type of the ref?

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
