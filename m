From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: new file leaked onto release branch
Date: Wed, 14 Dec 2005 14:26:12 -0700
Message-ID: <20051214212612.GA24501@socrates>
References: <F7DC2337C7631D4386A2DF6E8FB22B30056B83F2@hdsmsx401.amr.corp.intel.com>
 <7virtrxv9c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Brown, Len" <len.brown@intel.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 22:29:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eme7t-0002iC-1I
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 22:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbVLNVZ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 16:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVLNVZ0
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 16:25:26 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:18169 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932356AbVLNVZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 16:25:25 -0500
Received: from pd3mr1so.prod.shaw.ca
 (pd3mr1so-qfe3.prod.shaw.ca [10.0.141.177]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0IRI00B27BIDT840@l-daemon> for git@vger.kernel.org; Wed,
 14 Dec 2005 14:25:25 -0700 (MST)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
 by pd3mr1so.prod.shaw.ca (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar
 15 2004)) with ESMTP id <0IRI003I9BICGMD0@pd3mr1so.prod.shaw.ca> for
 git@vger.kernel.org; Wed, 14 Dec 2005 14:25:25 -0700 (MST)
Received: from socrates ([68.148.44.80])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0IRI00KB1BICV800@l-daemon> for git@vger.kernel.org; Wed,
 14 Dec 2005 14:25:24 -0700 (MST)
Received: from socrates (localhost [127.0.0.1])	by socrates (8.13.4/8.13.4)
 with ESMTP id jBELQCoj024830; Wed, 14 Dec 2005 14:26:12 -0700
Received: (from cougar@localhost)	by socrates (8.13.4/8.13.4/Submit)
 id jBELQC1a024829; Wed, 14 Dec 2005 14:26:12 -0700
In-reply-to: <7virtrxv9c.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
Mail-followup-to: git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13644>

On Wed, Dec 14, 2005 at 12:45:51PM -0800, Junio C Hamano wrote:
> 
> I pointed out one anomaly which is the commit should never have
> been created because it was not even a fast forward but already
> up-to-date case, and it was followed up with exchange of a few
> messages between Linus and you.
> 

I don't remember any of the details now, but I remember that an old
version of git or cogito would create bogus fast-forward merges, if they
were used without GNU coreutils. The machine it happend on was running
FreeBSD 4.10, but current versions work fine.

  Tom
