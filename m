From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC/PATCH] gitweb: Enable transparent compression form HTTP
	output
Date: Sat, 25 Aug 2007 20:03:50 +0200
Message-ID: <20070825180350.GA1219@pasky.or.cz>
References: <513314.51284.qm@web31813.mail.mud.yahoo.com> <200707252039.44312.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 20:10:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IP05y-0001pc-Bh
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 20:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758088AbXHYSKc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 14:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756967AbXHYSKc
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 14:10:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34447 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753436AbXHYSKb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 14:10:31 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Aug 2007 14:10:31 EDT
Received: (qmail 9782 invoked by uid 2001); 25 Aug 2007 20:03:50 +0200
Content-Disposition: inline
In-Reply-To: <200707252039.44312.jnareb@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56647>

On Wed, Jul 25, 2007 at 08:39:43PM CEST, Jakub Narebski wrote:
> Check if PerlIO::gzip is available, and if it is make it possible to

It doesn't really check if the require succeeded. Either the description
or (preferrably, but not a showstopper, IMO) the code should be
adjusted.

> enable (via 'compression' %feature) transparent compression of HTML
> output.  Error messages and any non-HTML output are excluded from
> transparent compression.
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>

Acked-by: Petr Baudis <pasky@suse.cz>

I'd put it on repo.or.cz... too bad that there I value CPU much more
than the bandwidth. ;-)

Why did you exclude non-HTML output from transparent compression? Me and
I guess other people too sometimes download rather large chunks of raw
data over gitweb.

-- 
				Petr "Pasky" Baudis
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
