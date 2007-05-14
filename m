From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 08/10] user-manual: add a "counting commits" example
Date: Mon, 14 May 2007 12:03:35 -0400
Message-ID: <20070514160335.GA20736@fieldses.org>
References: <20070514155111.GE5272@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Mon May 14 18:03:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hnd1V-00007i-Tq
	for gcvg-git@gmane.org; Mon, 14 May 2007 18:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755157AbXENQDj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 12:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755105AbXENQDj
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 12:03:39 -0400
Received: from mail.fieldses.org ([66.93.2.214]:34620 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755148AbXENQDi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 12:03:38 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1Hnd1L-0005f7-2R; Mon, 14 May 2007 12:03:35 -0400
Content-Disposition: inline
In-Reply-To: <20070514155111.GE5272@planck.djpig.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47263>

On Mon, May 14, 2007 at 05:51:11PM +0200, Frank Lichtenheld wrote:
> On Mon, May 14, 2007 at 11:21:27AM -0400, J. Bruce Fields wrote:
> > +Suppose you want to know how many commits you've made on "mybranch"
> > +since it diverged from "origin":
> > +
> > +-------------------------------------------------
> > +$ git log --pretty=oneline origin..maint | wc -l
> > +-------------------------------------------------
> 
> Shouldn't that be mybranch instead of maint?
> 
> > +Alternatively you may often see this sort of thing done with the
> > +lower-level command gitlink:git-rev-list[1], which just lists the SHA1's
> > +of all the given commits:
> > +
> > +-------------------------------------------------
> > +$ git rev-list origin..maint | wc -l
> > +-------------------------------------------------
> 
> Same here.

Yep, thanks for the sharp eyes.

--b.
