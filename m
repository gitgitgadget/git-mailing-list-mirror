From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Make '!' aliases more useful
Date: Mon, 2 Jul 2007 21:14:29 -0400
Message-ID: <20070703011429.GB5322@thunk.org>
References: <Pine.LNX.4.64.0707012249590.4438@racer.site> <20070702145549.GB4720@thunk.org> <Pine.LNX.4.64.0707021654450.4071@racer.site> <20070702160810.GD4720@thunk.org> <7vr6nqwgdi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 03:14:37 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5WyR-0000K2-P5
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 03:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756539AbXGCBOd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 21:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756844AbXGCBOd
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 21:14:33 -0400
Received: from THUNK.ORG ([69.25.196.29]:34529 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756476AbXGCBOd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 21:14:33 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I5X6E-0007Jp-Bp; Mon, 02 Jul 2007 21:22:38 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I5WyL-00058x-Rw; Mon, 02 Jul 2007 21:14:29 -0400
Content-Disposition: inline
In-Reply-To: <7vr6nqwgdi.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51438>

On Mon, Jul 02, 2007 at 04:11:21PM -0700, Junio C Hamano wrote:
> > Such a point exists, I agree, but I would draw after $* and $1/$2/$3
> > interpolation.  There is a lot more value that gets added with
> > positional arguments support, and it makes git aliases more usable on
> > platforms such as Windows where scripting capability is much more
> > limited.
> 
> That actually sounds sensible, but you could alias
> 
> 	!sh -c 'command $2 $1 $3'
> 
> to reorder the parameters, couldn't you?

Um, how would that work on the Windows platform?

(I'm assuming here that we are trying to support Windows better, since
there are projects such as Mozilla, and MySQL that care very much
about first class Windows support.  We could say this isn't important
enough, and that would be fine; but I wanted to at least raise the
question.)

						- Ted
