From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Tags of non-commits
Date: Fri, 24 Aug 2007 15:13:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0708241506300.5774@iabervon.org>
References: <Pine.LNX.4.64.0708241337560.5774@iabervon.org>
 <7vwsvkdaz0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 21:13:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOeaw-0006oB-WA
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 21:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbXHXTNS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 15:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbXHXTNS
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 15:13:18 -0400
Received: from iabervon.org ([66.92.72.58]:3954 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751078AbXHXTNR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 15:13:17 -0400
Received: (qmail 29419 invoked by uid 1000); 24 Aug 2007 19:13:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Aug 2007 19:13:16 -0000
In-Reply-To: <7vwsvkdaz0.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56593>

On Fri, 24 Aug 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > There seems to be an inconsistency between the fetch and tag over whether 
> > lightweight tags of non-commits are allowed. Fetch doesn't like them, but 
> > tag creates them without any particular fuss.
> 
> Is your "fetch does not like them" about the automated
> following?  If you say "git fetch $remote tag $that_tag" there
> shouldn't be any difference.
> 
> And the difference in the automated following behaviour is
> deliberate.  Lightweight ones tend to be private "anchor point"
> during development (these days we need that less often, thanks
> to reflogs), and annotated ones, especially the signed kinds are
> meant for public consumption.

I get a bunch of:

error: Object 0938d5832b4e40e6f440fa5c424c77b70714fb59 is a blob, not a commit

lines. I think it's either in trying to decide whether they should be put 
in FETCH_HEAD or in trying to determine reachability through them. The 
server also seems to be unable to tell that I already have the blobs, and 
sends a pack of all of them each time I pull with tags.

	-Daniel
*This .sig left intentionally blank*
