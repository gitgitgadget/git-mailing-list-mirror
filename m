From: Petr Baudis <pasky@suse.cz>
Subject: Re: [kernel.org users] README and ChangeLog files
Date: Thu, 21 Aug 2008 18:01:13 +0200
Message-ID: <20080821160113.GM10544@machine.or.cz>
References: <1219264114.7576.1121.camel@calx> <20080820210733.GA418@smurf.noris.de> <20080820223033.GD18947@flint.arm.linux.org.uk> <alpine.LFD.1.10.0808201552070.3487@nehalem.linux-foundation.org> <57C9024A16AD2D4C97DC78E552063EA309E70713@orsmsx505.amr.corp.intel.com> <20080820232332.GE18947@flint.arm.linux.org.uk> <alpine.LFD.1.10.0808201629590.3487@nehalem.linux-foundation.org> <m163pv59lo.fsf@frodo.ebiederm.org> <48AD03BD.9000909@zytor.com> <alpine.LFD.1.10.0808210830080.3487@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	"Luck, Tony" <tony.luck@intel.com>,
	"users@kernel.org" <users@kernel.org>,
	Matt Mackall <mpm@selenic.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 18:04:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWCcJ-0007dh-Hi
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 18:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbYHUQBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 12:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbYHUQBV
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 12:01:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:36016 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751471AbYHUQBV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 12:01:21 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id BFB6E393A6C5; Thu, 21 Aug 2008 18:01:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808210830080.3487@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93169>

On Thu, Aug 21, 2008 at 08:35:52AM -0700, Linus Torvalds wrote:
> One of the reasons that the dashed format is being removed is a real 
> technical one, though: git aliases. They never supported the dashed 
> format, since they never were real executables (that's the whole point of 
> an alias, after all).

On the other hand, with the dashed form you can easily use shell
aliases. Sure, there are differences, like that they are set per-session
at most, not per-repository; but if you actually define different
aliases with same names in your repositories, that seems like shooting
yourself in the foot elaborately most of the time.

				Petr "Pasky" Baudis
