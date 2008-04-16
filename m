From: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] Clarify and fix English in git-rm documentation.
Date: Wed, 16 Apr 2008 08:29:33 -0500
Message-ID: <E1Jm7hd-0005R1-AL@jdl.com>
References: <E1Jl91r-0000yT-8T@jdl.com> <7vve2is2gv.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 15:36:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm7iO-0000UM-LL
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 15:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758681AbYDPN3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 09:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755252AbYDPN3f
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 09:29:35 -0400
Received: from jdl.com ([208.123.74.7]:44909 "EHLO jdl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754713AbYDPN3f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 09:29:35 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>)
	id 1Jm7hd-0005R1-AL; Wed, 16 Apr 2008 08:29:33 -0500
In-reply-to: <7vve2is2gv.fsf@gitster.siamese.dyndns.org> 
Comments: In-reply-to Junio C Hamano <junio@pobox.com>
   message dated "Wed, 16 Apr 2008 00:06:40 -0700."
X-Spam-Score: -102.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79700>

> Jon Loeliger <jdl@jdl.com> writes:
> 
> > --- a/Documentation/git-rm.txt
> > +++ b/Documentation/git-rm.txt
> > @@ -11,28 +11,34 @@ SYNOPSIS
> >  
> >  DESCRIPTION
> >  -----------
> > +Remove files from the index, or from the working tree and the index.
> > +`git rm` will not remove a file from just your working directory.
> 
> The last sentence made me stop reading and read the paragraph twice and
> half.  Perhaps it would make it easier to read if we make it
> 
> 	(there is no option to remove a file only from work tree and keep
> 	it in the index; use regular "/bin/rm" if you want to do that).
> 
> a parenthesized note as the tail part of the previous sentence?

Yeah, I thought about adding that as well, so let's do it.

> > +The files being removed have to be identical to the tip of the branch,
> > +and no updates to their contents can be staged in the index.
> 
> Perhaps add "This can be overridden with the `-f` option" here?

Good idea.

I'll respin it this evening.

Thanks,
jdl
