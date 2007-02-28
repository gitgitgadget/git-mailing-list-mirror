From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How do get a specific version of a particular file?
Date: Wed, 28 Feb 2007 01:39:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702280137460.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <E1HM1XL-00071C-N5@candygram.thunk.org>
 <Pine.LNX.4.63.0702271356040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070227154241.GA8228@thunk.org> <Pine.LNX.4.63.0702272053080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070227223929.GA9027@thunk.org> <86vehnnpy2.fsf@blue.stonehenge.com>
 <7vfy8rb2do.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702271605290.12485@woody.linux-foundation.org>
 <7vejob9l70.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 28 01:39:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMCqo-0005gv-OD
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 01:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbXB1AjU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 19:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbXB1AjU
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 19:39:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:47160 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751140AbXB1AjT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 19:39:19 -0500
Received: (qmail invoked by alias); 28 Feb 2007 00:39:18 -0000
X-Provags-ID: V01U2FsdGVkX19UHy41DVFUR3fgK5LfZViW88duuiEzCoQMBSHoDY
	2LYQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vejob9l70.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40865>

Hi,

On Tue, 27 Feb 2007, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> >> > OK, how is that different from git-diff ?
> >> 
> >> I do not think there is any difference.  "show" is about
> >> multiple points, not ranges.  "diff" is about multiple
> >> (typically two) points, and not ranges.
> >
> > Well, I do think Ted has a good point. Having negative refs makes no sense 
> > for the "no-walk" case (aka "git show").
> >
> > ... Negative object refs really don't make any sense unless you walk 
> > the object list (or you're "git diff" and know about ranges explicitly).
> 
> If you did not say "(or you're..." part, then I would agree
> to this 100%.

git diff does not set revs->no_walk, so the patch would not trigger for 
git-diff.

Ciao,
Dscho
