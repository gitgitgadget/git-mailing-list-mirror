From: Tommi Virtanen <tv@eagain.net>
Subject: Re: is gitosis secure?
Date: Wed, 4 Feb 2009 10:26:50 -0800
Message-ID: <20090204182650.GC1970@eagain.net>
References: <200812090956.48613.thomas@koch.ro> <1228813453.28186.73.camel@maia.lan> <873afgsul8.fsf@mid.deneb.enyo.de> <200901180650.06605.bss@iguanasuicide.net> <20090203213135.GA1970@eagain.net> <20090204121204.GA12393@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Feb 04 19:28:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUmTz-0000bJ-B5
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 19:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093AbZBDS0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 13:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbZBDS0w
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 13:26:52 -0500
Received: from eagain.net ([208.78.102.120]:53617 "EHLO eagain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261AbZBDS0w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 13:26:52 -0500
Received: from musti.eagain.net (unknown [208.79.94.252])
	by eagain.net (Postfix) with ESMTPS id 786CE56688;
	Wed,  4 Feb 2009 18:26:51 +0000 (UTC)
Received: by musti.eagain.net (Postfix, from userid 1000)
	id 7AC6D508013; Wed,  4 Feb 2009 10:26:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20090204121204.GA12393@cuci.nl>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108406>

On Wed, Feb 04, 2009 at 01:12:04PM +0100, Stephen R. van den Berg wrote:
> I installed gitosis a year ago.
> Then I tried to audit the code.
> I couldn't, the whole thing is too much spaghetti code.

Huh. It's about 1000 lines of python, with about 2000 lines of unit
tests. It has 3 top-level operations: init, serve, run_hook. That
still counts as "tiny" in my mind. I'm sorry if following the code was
too hard. I guess there's no accounting for taste.

> Auditing gitosis turned out to be too painful to be worth the trouble,
> so I reverted to a manually maintained git-shell solution which is so
> simple that I can actually audit it, and therefore is provably secure
> (which gitosis is not).

This word, "provably", tends to mean something else than what you use
it for. Definitely a simple audit doesn't prove anything. Most
real-world software is complex enough to be practically unprovable for
anything.

-- 
:(){ :|:&};:
