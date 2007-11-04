From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-fetch: more terse fetch output
Date: Sun, 4 Nov 2007 00:58:00 -0400
Message-ID: <20071104045800.GB12359@segfault.peff.net>
References: <alpine.LFD.0.9999.0711030101340.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 05:58:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoXYw-0001mA-Us
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 05:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbXKDE6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 00:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752737AbXKDE6D
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 00:58:03 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4550 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752559AbXKDE6B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 00:58:01 -0400
Received: (qmail 12393 invoked by uid 1000); 4 Nov 2007 04:58:00 -0000
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0711030101340.21255@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63348>

On Sat, Nov 03, 2007 at 01:32:48AM -0400, Nicolas Pitre wrote:

> This makes the fetch output much more terse and prettier on a 80 column 
> display, based on a consensus reached on the mailing list.  Here's an 
> example output:

Thank you for this; it was at the end of a very long todo list for me.

> Receiving objects: 100% (5439/5439), 1.60 MiB | 636 KiB/s, done.
> Resolving deltas: 100% (4604/4604), done.
> From git://git.kernel.org/pub/scm/git/git
>  ! [rejected]        html -> origin/html  (non fast forward)
>    136e631..f45e867  maint -> origin/maint  (fast forward)
>    9850e2e..44dd7e0  man -> origin/man  (fast forward)
>    3e4bb08..e3d6d56  master -> origin/master  (fast forward)
>    fa3665c..536f64a  next -> origin/next  (fast forward)
>  + 4f6d9d6...768326f pu -> origin/pu  (forced update)
>  * [new branch]      todo -> origin/todo

One nice thing about this format is that it works equally well for
"push" (changing "From" to "To" and reversing the order of the
branches). Comments?

-Peff
