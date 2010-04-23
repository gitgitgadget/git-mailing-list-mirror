From: Petr Baudis <pasky@suse.cz>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Fri, 23 Apr 2010 09:10:14 +0200
Message-ID: <20100423071014.GL3563@machine.or.cz>
References: <201004150630.44300.chriscool@tuxfamily.org>
 <201004191243.24209.jnareb@gmail.com>
 <20100419115113.GC3563@machine.or.cz>
 <201004202014.19477.jnareb@gmail.com>
 <k2le72faaa81004211349o1628ed42s4fa0aa412006128@mail.gmail.com>
 <20100422202501.GJ10939@machine.or.cz>
 <7vwrvz2npn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 23 09:10:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5D1u-00026l-N0
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 09:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756183Ab0DWHKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 03:10:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47020 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756165Ab0DWHKT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 03:10:19 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id E6262125A0EE; Fri, 23 Apr 2010 09:10:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vwrvz2npn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145591>

On Thu, Apr 22, 2010 at 02:15:32PM -0700, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Note that for the latter two, operation mode without working copy is
> > essential; I have not seen you address it anywhere.
> 
> What do you mean by "without working copy"?  Is the proposal about having
> a working copy _per_ client on the server side, and the file editor and
> goodies listed in the "Wrote modules" list operate on these files?

  Currently, the write side will probably not be able to work on bare
repositories; it will have a working copy _per repository_ and the
operations like git add will work on the working copy.

  The original idea was to just have a git-gui replacement that runs
within your browser, and that's what is getting implemented I think.
This is not that interesting to me, but the applications it can be
easily extended to are. ;-)

> Perhaps you meant to say "without working copy on the client side", and if
> that is the case I think we are on the same wavelength.  That is exactly
> why I earlier said that I imagine that the "Gitweb client write support"
> would be based on something more standard like DeltaV, instead of rolling
> a custom hack that is not compatible with anybody else.

  DeltaV?

  I think WebDAV API would be very fine to have *in addition* to
user-friendly web interface, but is useful in very different scenarios.
You need something to frontend WebDAV anyway.

-- 
				Petr "Pasky" Baudis
http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
