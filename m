From: Andreas Gal <gal@uci.edu>
Subject: Re: [FILE] GNU BIT
Date: Mon, 25 Apr 2005 13:03:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504251257460.10788@sam.ics.uci.edu>
References: <Pine.LNX.4.21.0504251134090.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 21:59:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ9in-0004xn-Li
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 21:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbVDYUDY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 16:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbVDYUDY
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 16:03:24 -0400
Received: from sam.ics.uci.edu ([128.195.38.141]:33723 "EHLO sam.ics.uci.edu")
	by vger.kernel.org with ESMTP id S262755AbVDYUDS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 16:03:18 -0400
Received: from sam.ics.uci.edu (localhost.localdomain [127.0.0.1])
	by sam.ics.uci.edu (8.12.11/8.12.11) with ESMTP id j3PK3Gu9010811;
	Mon, 25 Apr 2005 13:03:16 -0700
Received: from localhost (gal@localhost)
	by sam.ics.uci.edu (8.12.11/8.12.8/Submit) with ESMTP id j3PK3Gvj010807;
	Mon, 25 Apr 2005 13:03:16 -0700
X-Authentication-Warning: sam.ics.uci.edu: gal owned process doing -bs
X-X-Sender: gal@sam.ics.uci.edu
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504251134090.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


I fixed this bug and another nasty one in "bit pull". The new version is 
up in its usual place:

bit clone http://nil.ics.uci.edu/~gal/public/bit

(You can't use pull because it was broken in the previous version.)

Another unrelated note: to add files to your repository, do "bit commit 
filename". To remove a file, delete it and then do "bit commit 
deleted-filename" (yes, I will add "bit add" and "bit rm" at some point).

Andreas

On Mon, 25 Apr 2005, Daniel Barkalow wrote:

> On Sun, 24 Apr 2005, Andreas Gal wrote:
> 
> > http-pull -a `cat .git/HEAD` \
> >     http://nil.ics.uci.edu/~gal/public/bit
> 
> Don't forget the slash at the end... (one of us should probably fix that
> at some point; just stick a slash at the end of any URL without one)
> 
> Also, it has become customary to have URLs like .../public/bit.git/, since
> the contents match a .git directory.
> 
> 	-Daniel
> *This .sig left intentionally blank*
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
