From: Petr Baudis <pasky@suse.cz>
Subject: Re: Need help for migration from CVS to git in one go (ie,
	FORGETTING CVS history)
Date: Thu, 6 Nov 2008 00:50:35 +0100
Message-ID: <20081105235035.GA10544@machine.or.cz>
References: <200811060014.57046.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Francis Galiegue <fg@one2team.net>
X-From: git-owner@vger.kernel.org Thu Nov 06 00:52:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxsAM-0008Qv-Gk
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 00:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbYKEXuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 18:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677AbYKEXuj
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 18:50:39 -0500
Received: from w241.dkm.cz ([62.24.88.241]:60392 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752657AbYKEXuj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 18:50:39 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 974D4393A1AC; Thu,  6 Nov 2008 00:50:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200811060014.57046.fg@one2team.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100204>

  Hi,

On Thu, Nov 06, 2008 at 12:14:56AM +0100, Francis Galiegue wrote:
> * second: even though this may be a "non problem", we use Bonsai, which has 
> the ability to see what was commited by whom, given a time interval (from d1 
> to d2): the base gitweb allows to search by commiter, which is good, but it 
> has no date boundaries: do tools exist for git that can do this? If not, that 
> wouldn't be a big deal, however...

	git log --since='2 months ago' --until='1 month ago'

  There is no gitweb functionality for this right now, but I think an
implementation of that would be welcome in principle.

> * third: also Bonsai-related; Bonsai can link to Bugzilla by matching (wild 
> guess) /\b(?:#?)(\d+)\b/ and transforming this into 
> http://your.bugzilla.fqdn.here/show_bug.cgi?id=$1. Does gitweb have this 
> built-in? (haven't looked yet) Is this planned, or has it been discussed and 
> been considered not worth the hassle?

  This is planned and I think there are third-party patches for this
(cannot find them quickly, though), but upstream gitweb does not have
the support for this included yet.

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
