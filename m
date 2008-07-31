From: "Craig L. Ching" <cching@mqsoftware.com>
Subject: RE: Git vs Monotone
Date: Thu, 31 Jul 2008 14:11:25 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F79430238A5EB@emailmn.mqsoftware.com>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com> <20080731190209.GA8372@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Git Mailinglist" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>, <sverre@rabbelier.nl>
X-From: git-owner@vger.kernel.org Thu Jul 31 21:13:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOdai-0008FR-Fy
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 21:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799AbYGaTMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 15:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754468AbYGaTMg
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 15:12:36 -0400
Received: from emailmn.mqsoftware.com ([66.192.70.108]:54121 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064AbYGaTMf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 15:12:35 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <20080731190209.GA8372@sigill.intra.peff.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Git vs Monotone
Thread-Index: AcjzP9Z3H+9E4Mk/Qqe69r0YvF724AAAKC3A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90969>

 

> -----Original Message-----
> From: git-owner@vger.kernel.org 
> [mailto:git-owner@vger.kernel.org] On Behalf Of Jeff King
> Sent: Thursday, July 31, 2008 2:02 PM
> To: sverre@rabbelier.nl
> Cc: Git Mailinglist
> Subject: Re: Git vs Monotone
> 
> On Thu, Jul 31, 2008 at 08:13:59PM +0200, Sverre Rabbelier wrote:
> 
> > If I clone the git mirror of our monotone repository, I find a 
> > checkout size of 148 MB after git-repack--running git-gc also 
> > increased the size by 2 MB, but I'll stick with the initial 
> checkout 
> > size for fairness. If I multiply this by my 11 checkouts, I 
> will have
> > 1628 MB. This is even more compelling for me, as I now save 
> 728 MB of 
> > disk space with monotone."
> 
> Yikes. This is not even remotely a fair comparison to 
> monotone, which is keeping a central db.
> 
I think it is a fair comparison, but as you point out, the author is
doing the comparison wrong.  Monotone's "central db" (as you call it) is
really equivalent to git's object database.

> > I'm in the process of cloning the repo myself, and will 
> check if doing 
> > a more aggressive (high --window and --depth values) repack 
> will get 
> > us below that 148, but I'm thinking it's just that big a 
> repo. Anyway,
> 
> It's much better than that. I just cloned
> 
>   git://github.com/felipec/pidgin-clone.git
> 
> and the _whole thing_ is 148M, including the working tree. 
> His object db is only 88M. So he can do his 11 trees in 61 * 
> 11 + 88 = 759M, saving 141M over monotone.
> 
Right, that's been my experience too, that git is smaller than monotone.
The author just needs to compare eqivalent concepts ;-)

> -Peff
> --

Cheers,
Craig
