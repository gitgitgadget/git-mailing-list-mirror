From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Make gc a builtin.
Date: Wed, 14 Mar 2007 03:44:40 -0400
Message-ID: <20070314074440.GC12710@thunk.org>
References: <11738375021267-git-send-email-jbowes@dangerouslyinc.com> <20070314060727.GC20978@spearce.org> <7vodmwfg2c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	James Bowes <jbowes@dangerouslyinc.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 08:45:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HROAu-0002Zi-Kw
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 08:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933294AbXCNHpJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 03:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933873AbXCNHpI
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 03:45:08 -0400
Received: from thunk.org ([69.25.196.29]:47370 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933294AbXCNHpH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 03:45:07 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HROG5-0003mY-Sv; Wed, 14 Mar 2007 03:50:54 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HROA4-0000t1-H1; Wed, 14 Mar 2007 03:44:40 -0400
Content-Disposition: inline
In-Reply-To: <7vodmwfg2c.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42180>

On Wed, Mar 14, 2007 at 12:19:07AM -0700, Junio C Hamano wrote:
> >> -test "true" != "$pack_refs" ||
> >> -git-pack-refs --prune &&
> >> -git-reflog expire --all &&
> >> -git-repack -a -d -l &&
> >> ...
> 
> I do not necessarily think so.  This is not even a performance
> critical part of the system, so if there _were_ no other
> constraints, I would rather keep scripts like this as scripts.

I agree with Junio; I think the scripts are much more readable and
easier to understand; In fact, it would be nice if the script were
preserved somewhere, perhaps as comments in the .c file.

						- Ted
