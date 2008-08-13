From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH (1b)] merge-recursive.c: Add more generic
 merge_recursive_generic()
Date: Wed, 13 Aug 2008 13:54:16 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0808131333230.19665@iabervon.org>
References: <1218559514-16890-1-git-send-email-vmiklos@frugalware.org> <1218572040-23362-1-git-send-email-s-beyer@gmx.net> <alpine.LNX.1.00.0808122309460.19665@iabervon.org> <20080813172938.GC12871@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Aug 13 19:55:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTKZA-00069b-1k
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 19:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbYHMRyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 13:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752911AbYHMRyS
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 13:54:18 -0400
Received: from iabervon.org ([66.92.72.58]:57229 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752294AbYHMRyR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 13:54:17 -0400
Received: (qmail 31791 invoked by uid 1000); 13 Aug 2008 17:54:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Aug 2008 17:54:16 -0000
In-Reply-To: <20080813172938.GC12871@leksak.fem-net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92251>

On Wed, 13 Aug 2008, Stephan Beyer wrote:

> Hi,
> 
> Daniel Barkalow wrote:
> > You might look at builtin-checkout and see if merge_working_tree() could 
> > be made cleaner with this API, or if some other API could accomodate both 
> > cases more nicely.
> 
> Puhh, I've not dug into merging stuff that deep, but for me it does not
> look that this can be done in a useful way, i.e. merge_working_tree()
> does not do a recursive merge.

Ah, true. It's actually doing a single merge in the way that 
merge_recursive would do a single merge. I think it ought to be doing 
a recursive merge, but that's probably a change for later, anyway. (This 
is for -m, which essentially picks the uncommited changes versus the old 
branch, applied to the new branch uncommitted)

	-Daniel
*This .sig left intentionally blank*
