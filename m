From: Petr Baudis <pasky@suse.cz>
Subject: Re: TopGit: how to deal with upstream inclusion
Date: Wed, 24 Sep 2008 17:29:13 +0200
Message-ID: <20080924152913.GY10360@machine.or.cz>
References: <20080914203043.GA4872@lapse.rw.madduck.net> <20080914210316.GJ10360@machine.or.cz> <20080919170406.GA22849@lapse.rw.madduck.net> <20080921141924.GI10360@machine.or.cz> <20080923063550.GC19084@piper.oerlikon.madduck.net> <20080923095528.GR10360@machine.or.cz> <20080924112115.GA14841@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Wed Sep 24 17:30:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiWJs-0008WR-Fl
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 17:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbYIXP3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 11:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbYIXP3P
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 11:29:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56470 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592AbYIXP3O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 11:29:14 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 2C3923939B43; Wed, 24 Sep 2008 17:29:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080924112115.GA14841@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96650>

On Wed, Sep 24, 2008 at 01:21:15PM +0200, martin f krafft wrote:
> also sprach Petr Baudis <pasky@suse.cz> [2008.09.23.1155 +0200]:
> > > Well, but what if upstream implemented our solution slightly
> > > differently, and if it's only because they used tabs instead of
> > > spaces? We wouldn't want -s ours then, huh?
> > 
> > You still would want to get tabs in other patches that depended on
> > the merged one, no? Otherwise tg patch output will produce patches
> > that do not apply and tg export will change the tabs back to
> > spaces.
> 
> I would want to have to resolve all dependent branches and change
> them to use tabs, right. But since I used spaces and they used tabs,
> using -s ours would give preference to spaces, no?

Please read again carefully :-) :

>   (i) Take the RETIRED _base_ branch
>
>   (ii) Merge in VANILLA
>
>   (iii) Merge in RETIRED head branch with -s ours
>
>   (iv) Now we have a commit that contains RETIRED topic branch, but
>   with the RETIRED's changes taken from VANILLA instead of RETIRED

-s ours keeps vanilla version.

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism,
but they have cold baths.
