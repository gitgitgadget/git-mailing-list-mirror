From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC/PATCH] gitweb: Enable transparent compression form HTTP
	output
Date: Sun, 26 Aug 2007 00:14:45 +0200
Message-ID: <20070825221445.GD1219@pasky.or.cz>
References: <513314.51284.qm@web31813.mail.mud.yahoo.com> <200707252039.44312.jnareb@gmail.com> <20070825180350.GA1219@pasky.or.cz> <200708260009.30092.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 00:15:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IP3uR-0008QQ-11
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 00:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587AbXHYWOr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 18:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897AbXHYWOr
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 18:14:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37942 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752741AbXHYWOq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 18:14:46 -0400
Received: (qmail 31992 invoked by uid 2001); 26 Aug 2007 00:14:45 +0200
Content-Disposition: inline
In-Reply-To: <200708260009.30092.jnareb@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56654>

On Sun, Aug 26, 2007 at 12:09:29AM CEST, Jakub Narebski wrote:
> On Sat, Aug 25, 2007, Petr Baudis wrote:
> > On Wed, Jul 25, 2007 at 08:39:43PM CEST, Jakub Narebski wrote:
> 
> >> Check if PerlIO::gzip is available, and if it is make it possible to
> > 
> > It doesn't really check if the require succeeded. Either the description
> > or (preferrably, but not a showstopper, IMO) the code should be
> > adjusted.
> 
> It does not check if require succeeded (I could do that this way),
> but instead checks if $PerlIO::gzip::VERSION is defined (if it is true).
> 
> our $enable_transparent_compression = !! $PerlIO::gzip::VERSION;

Whoops, I completely missed this chunk.

 Bareword "PerlIO::gzip::VERSION" not allowed while "strict subs" in use at /home/pasky/WWW/repo/gitweb.cgi line 26.

-- 
				Petr "Pasky" Baudis
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
