From: Petr Baudis <pasky@suse.cz>
Subject: Re: Re: Re: fsck --full is Ok, but clones are not, "missing
	commits"?!
Date: Wed, 16 Apr 2008 16:59:00 +0200
Message-ID: <20080416145900.GA10777@machine.or.cz>
References: <200804161334.17748.brian.foster@innova-card.com> <a537dd660804160448w5ba28f13m8c081ebc2a71db91@mail.gmail.com> <20080416121424.GA3133@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Foster <brian.foster@innova-card.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 17:14:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm972-0007A0-R0
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 16:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252AbYDPO7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 10:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752755AbYDPO7G
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 10:59:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45224 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101AbYDPO7G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 10:59:06 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 3E31E244C019; Wed, 16 Apr 2008 16:59:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080416121424.GA3133@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79712>

On Wed, Apr 16, 2008 at 04:14:24PM +0400, Dmitry Potapov wrote:
> info/grafts should never be used during normal work.

I don't really agree with this advice in general. Grafts can be very
useful especially when migrating to Git - a very good strategy might be
just to start from scratch with your current state, then import your
previous history and graft it. The big advantage is that if you find out
later that the import is screwed up, you can fix that and reimport. The
fact that you don't need to haul 10 years of CVS history around unless
you actually know you need it can be perceived as both advantage and
disadvantage.

The _BAD_ grafts are those that replace list of commit's parents instead
of just appending (typically to an empty one). I didn't actually have
any idea people use grafts in such a twisted and perverse way... ;-)

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
