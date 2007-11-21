From: Theodore Tso <tytso@mit.edu>
Subject: Re: What is the whole process of cooking git as a maintainer?
Date: Wed, 21 Nov 2007 09:07:38 -0500
Message-ID: <20071121140738.GA13694@thunk.org>
References: <46dff0320711210511g7d9febf5k47b082cc13bb905a@mail.gmail.com> <46dff0320711210517y282643a2q62819d3583ec9344@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 15:08:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuqFT-0004Gz-06
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 15:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbXKUOH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 09:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbXKUOH5
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 09:07:57 -0500
Received: from thunk.org ([69.25.196.29]:48656 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064AbXKUOH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 09:07:56 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IuqPg-00060a-EG; Wed, 21 Nov 2007 09:18:48 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1IuqEs-0003ZB-FO; Wed, 21 Nov 2007 09:07:38 -0500
Content-Disposition: inline
In-Reply-To: <46dff0320711210517y282643a2q62819d3583ec9344@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65652>

On Wed, Nov 21, 2007 at 09:17:59PM +0800, Ping Yin wrote:
> On Nov 21, 2007 9:11 PM, Ping Yin <pkufranky@gmail.com> wrote:
> > I have scanned the manual and found a 'Linux subsystem maintainer'
> > example. However, that's a little brief and i wonder a more real
> > example. I think an example of how to cook git as a maintainer is
> > better.
> >
> > Junio , could you please share the whole process of cooking among pu,
> > next and master? Or, can i find this in the mail list archive?
> >
> > For example:
> > In which branch the test is performed?
> > How to rewind pu?
> > How to merge a subset of changes from pu to next, and from next to master?
> >
> 
> One more question:
> I see so many merges in pu branch, but where these merges go when a
> feature is moved to the master branch?

There is a discussion of some of these issues in the mail thread
beginning here:

http://kerneltrap.org/mailarchive/git/2007/10/23/350943

The git setup is actually pretty complex, and all of the details of
how to maintain the pu and next branches are pretty complicated ---
and if you don't have a large development community, it may not be
worth the overhead, and it may scare people off as being too complicated.

There are multiple ways to maintain a project in git, and it's usually
better to start simple --- with a development and maintenance branch.
If you need more, you can add more later, but I wouldn't recommend
starting off with a very complex system right off the bat.

	     	    	 	 	      - Ted
