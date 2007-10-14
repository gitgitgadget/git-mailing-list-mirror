From: Theodore Tso <tytso@mit.edu>
Subject: Re: How to manage heads on a remote repository?
Date: Sun, 14 Oct 2007 07:07:14 -0400
Message-ID: <20071014110714.GA17368@thunk.org>
References: <E1Ih0zJ-0004FZ-0A@tinytim.thunk.org> <ee77f5c20710140403j7a88ffa4q579a8c4118d8fd71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 13:08:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih1KC-000839-Cv
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 13:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755663AbXJNLHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 07:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755349AbXJNLHu
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 07:07:50 -0400
Received: from thunk.org ([69.25.196.29]:39124 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755279AbXJNLHt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 07:07:49 -0400
Received: from root (helo=tinytim.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1Ih1Tm-0002QT-U5; Sun, 14 Oct 2007 07:17:55 -0400
Received: from tytso by tinytim.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1Ih1Jd-0004Yn-1O; Sun, 14 Oct 2007 07:07:25 -0400
Content-Disposition: inline
In-Reply-To: <ee77f5c20710140403j7a88ffa4q579a8c4118d8fd71@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60829>

On Sun, Oct 14, 2007 at 09:03:48PM +1000, David Symonds wrote:
> On 14/10/2007, Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > I'm currently exploring the idea of not only making the equivalent of
> > "pu" and "next" available on a public repository for one of my projects,
> > but also the topics/* branches.   When thinking about how I might do
> > this, one snag I ran into is that the topics/foo and topics/bar branches
> > are ephemeral, and so when I replicate them to a remote repository,
> > either on kernel.org or repo.or.cz, I would need a way of removing a
> > head for a topic branch that had already been merged.
> 
> git push <remote> :<branch_name>
> 
> If the left side of the colon in a push refspec is empty, it deletes
> the remote ref given by the right hand side.

Cool, thanks!  It's not in the git-push man page.  I'll play with it
some and then submit a patch update the man page.

     	      	       	     	    	    - Ted
