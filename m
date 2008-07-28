From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Documentation/git-ls-tree.txt: Add a caveat about
	prefixing pathspec
Date: Mon, 28 Jul 2008 02:46:04 +0200
Message-ID: <20080728004604.GF32184@machine.or.cz>
References: <20080720233956.GH10151@machine.or.cz> <20080721075618.14163.45309.stgit@localhost> <7v1w1nvf7q.fsf@gitster.siamese.dyndns.org> <20080721210452.GP10151@machine.or.cz> <7vd4l6sqqz.fsf@gitster.siamese.dyndns.org> <20080722224759.GJ32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 02:47:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNGtI-0007ki-ML
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 02:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756902AbYG1AqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 20:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756755AbYG1AqH
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 20:46:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41659 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756370AbYG1AqG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 20:46:06 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 2B295393B928; Mon, 28 Jul 2008 02:46:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080722224759.GJ32184@machine.or.cz>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90382>

On Wed, Jul 23, 2008 at 12:47:59AM +0200, Petr Baudis wrote:
> On Mon, Jul 21, 2008 at 05:32:20PM -0700, Junio C Hamano wrote:
> > Petr Baudis <pasky@suse.cz> writes:
> > 
> > >> 	commit.  E.g.
> > >> 
> > >> 		$ cd some/deep/path
> > >> 		$ git ls-tree --name-only -r HEAD~20
> > >> 
> > >> 	will list the files in some/deep/path (i.e. where you are) 20
> > >> 	commits ago, just like running "/bin/ls" there will give you the
> > >> 	list of files you have right now.
> > >
> > > Frankly, I think this is overdoing it. I'm all for being positive, but
> > > it is obvious why this is good thing when you inspect a root tree and
> > > there's no need to be too wordy about it...
> > 
> > I mildly disagree.
> 
> We may throw a dice or go with your version, I don't care *that* much
> about this change, I just wouldn't make it personally.

What is the status of this patch? :-) Dropped altogether?

				Petr "Pasky" Baudis
