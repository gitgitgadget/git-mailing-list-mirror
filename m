From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Rollback of git commands
Date: Wed, 28 Nov 2007 12:03:28 -0500
Message-ID: <9e4733910711280903w26e9821ah17db9ad468dea460@mail.gmail.com>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com>
	 <7vmyszb39s.fsf@gitster.siamese.dyndns.org>
	 <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com>
	 <BAYC1-PASMTP02DBA3FB25E09FE45F0BF2AE770@CEZ.ICE>
	 <9e4733910711272037r2ce3ed01y31ec8531f5803efe@mail.gmail.com>
	 <alpine.LFD.0.99999.0711280951150.9605@xanadu.home>
	 <9e4733910711280758x38ca3cdau4e62bfe8776e5c0d@mail.gmail.com>
	 <alpine.LFD.0.99999.0711281125320.9605@xanadu.home>
	 <9e4733910711280837o43003e93p470bb403e6bdd3bb@mail.gmail.com>
	 <alpine.LFD.0.99999.0711281141150.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sean <seanlkml@sympatico.ca>, "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 18:04:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxQKC-0002F1-Kx
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 18:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759947AbXK1RDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 12:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759835AbXK1RDc
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 12:03:32 -0500
Received: from nz-out-0506.google.com ([64.233.162.227]:38787 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757607AbXK1RDa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 12:03:30 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1141361nze
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 09:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=awqsu8UCzt7q3ChS2dXb9SAGCPVRRDofn4rjWX5il5w=;
        b=WTvqf/oPPgLQQFUfJBvwOy9gubYLH/1fYjdbKG/ERGJtBRLAfGzLUlKJIqoI55ayVxWj0Wx+/gxDgzrxI6p9xkuf3wrxblDGWzYYpAFUCNhLAoQv4LKv2OIviy0xmT4TA7PMaJ6Dp7NPHMVcl6lxt8DX5BFMt2kOvh1yvDxaW+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U3eKeUh5bk5LWKHaie4AnMegefELVfK1a8KVeU+6dulz8yTY1flmOwijrmjJE+wA6i+D5hW+CfJL/y4yn1/9kz3N/Nc85xgBNNIcwjaAuIFUS7Y93LCuded/TfqWt7yCRrldnKcUAQRQvrtkIctPVjKfvJSjT5a62H8XWmGl/bE=
Received: by 10.114.103.1 with SMTP id a1mr283073wac.1196269408891;
        Wed, 28 Nov 2007 09:03:28 -0800 (PST)
Received: by 10.114.160.3 with HTTP; Wed, 28 Nov 2007 09:03:28 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0711281141150.9605@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66384>

On 11/28/07, Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 28 Nov 2007, Jon Smirl wrote:
>
> > On 11/28/07, Nicolas Pitre <nico@cam.org> wrote:
> > > On Wed, 28 Nov 2007, Jon Smirl wrote:
> > >
> > > > On 11/28/07, Nicolas Pitre <nico@cam.org> wrote:
> > > > > On Tue, 27 Nov 2007, Jon Smirl wrote:
> > > > >
> > > > > > Of course you've never screwed up a repository using git commands,
> > > > > > right? I've messed up plenty. A good way to mess up a repo is to get
> > > > > > the data in .git/* out of sync with what is in the repo. I'm getting
> > > > > > good enough with git that I can fix most mess up with a few edits, but
> > > > > > it took me two years to get to that point. Rolling back to a check
> > > > > > point is way easier. User error and a command failing are both equally
> > > > > > valid ways to mess up a repo.
> > > > >
> > > > > The reflog contains all your check points, for every modifications you
> > > > > make, even the stupid ones.  You should look at it.
> > > >
> > > > The state contained in the other config files in .git/* is not getting
> > > > check pointed. I can use reflog to move my branch heads around. But
> > > > doing that does not undo the changes to the state recorded in .git/*.
> > > > After the error I encountered  I moved my branch head back, but the
> > > > state stgit had stored in .git/* was out of sync with where the branch
> > > > had been moved to.
> > >
> > > It's up to stgit to version control its state then.  It may even use a
> > > reflog for it.  All the machinery is there already.
> >
> > Git has state in .git/* too, shouldn't it be version controlling it
> > too? If git was version controlling the state in .git/* you'd have
> > checkpoints with the ability to roll back.
>
> Well, the .git directory contains data to identify what is actually
> version controlled.  If you start versioning the data used to implement
> the versioning, don't you get into endless recursion here?

You would end up with a single non-version controlled sha pointer that
would need to be stored externally.  That pointer would be the
beginning of the rollback log. It's just a normal commit chain.

In a totally version controlled system. .git/* would only contain
objects and the one pointer to the current state of the system.


-- 
Jon Smirl
jonsmirl@gmail.com
