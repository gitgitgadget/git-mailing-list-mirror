From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/4] git-gui i18n: Add more words to glossary.
Date: Wed, 10 Oct 2007 02:03:28 -0400
Message-ID: <20071010060328.GO2137@spearce.org>
References: <200710052239.02492.stimming@tuhh.de> <Pine.LNX.4.64.0710080029430.4174@racer.site> <20071007233937.GG2137@spearce.org> <200710082143.13750.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 08:03:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfUfY-0002yT-K6
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 08:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbXJJGDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 02:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbXJJGDe
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 02:03:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35071 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbXJJGDd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 02:03:33 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IfUfJ-00050z-Gn; Wed, 10 Oct 2007 02:03:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 56FBC20FBAE; Wed, 10 Oct 2007 02:03:28 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200710082143.13750.stimming@tuhh.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60465>

Christian Stimming <stimming@tuhh.de> wrote:
> All pushed to git-gui-i18n.git mob branch now.  I hope you can easily merge 
> them over.

I basically had to cherry-pick your 4 patches out of the mob branch
from the i18n fork.  The issue is the mob branch is based on an old
lineage that Dscho hand picked patches out of and squashed when he
created the initial i18n series for me to merge.

The i18n fork as it currently stands is pretty far away from my
own tree; it probably should be reset to my tree in the near future.
 
> Maybe po/git-gui.pot should be updated by you on git-gui.git and (by Dscho?) 
> on git-gui-i18n.git as well. 

Yea, I'll run it before I push out my newest master tonight.
 
> http://wiki.gnucash.org/wiki/index.php?title=String_Freeze&oldid=2022 is an 
> example on how the gnucash project tried to communicate to its translators 
> how the special "string freeze" period (i.e. a few weeks before the release) 
> will be handled in order to get a finalized translation for the actual 
> release. I don't know how formal you want to put this, but at least *some* 
> period of string freeze would be very good. As for the German translation, 
> I'd prefer any period length greater than 10 days in order to verify a 
> complete translation...

I agree on the need for the string freeze period and will plan
to include a 14+ day window near the end of the 0.9.0 release to
update the translations.  I want to get the major functionality
written and then we can work on debugging/testing/translation.

Schedule wise I'm probably looking at middle of next month or the
month after (so Nov 15th-ish or Dec 15th-ish) for the 0.9.0 string
freeze period starting.  That means there is a good chance we won't
be seeing 0.9.0 final in 2007; probably it will be in early 2008.

-- 
Shawn.
