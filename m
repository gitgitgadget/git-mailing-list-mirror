From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: totorial-2 Re: (unknown)
Date: Sun, 21 May 2006 21:25:19 -0400
Message-ID: <20060522012519.GB4818@fieldses.org>
References: <1148255528.61d5d241.1@fieldses.org> <1148255528.61d5d241.2@fieldses.org> <7vfyj2hp5p.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 03:25:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhzAh-0003tp-TR
	for gcvg-git@gmane.org; Mon, 22 May 2006 03:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbWEVBZV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 21:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWEVBZV
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 21:25:21 -0400
Received: from mail.fieldses.org ([66.93.2.214]:40913 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S932384AbWEVBZU
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 May 2006 21:25:20 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.62)
	(envelope-from <bfields@fieldses.org>)
	id 1FhzAd-0001sT-I4; Sun, 21 May 2006 21:25:19 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyj2hp5p.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20472>

On Sun, May 21, 2006 at 05:35:46PM -0700, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> > +Besides blobs, trees, and commits, the only remaining type of object
> > +is a "tag", which we won't discuss here; refer to gitlink:git-tag[1]
> > +for details.
> 
> We have created a tag in tutorial#1, so it _might_ make sense to
> just tell the user to cat-file it.

The example in tutorial.txt is a "lightweight" tag.

The original tutorial.txt (unlike this sequel) doesn't actually try to
stick to a consistent example throughout, so it's awkward to refer back.
Probably something to fix some day....

> 
> > +------------------------------------------------
> > +$ git diff
> > +--- a/file.txt
> > ++++ b/file.txt
> > +@@ -1 +1,2 @@
> > + hello world!
> > + +hello world, again
> > +$ git update-index file.txt
> > +$ git diff
> > +------------------------------------------------
> 
> Is the second line of the diff " +" intentional?  The same
> comment to the example that immediately follows this part.

Oops, no--those look like cut'n'paste errors.  Would you like a revised
patch?--b.
