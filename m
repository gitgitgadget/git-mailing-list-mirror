From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [RFD] Overlapping projects
Date: Tue, 10 May 2005 08:04:54 -0400 (EDT)
Message-ID: <4385.10.10.10.24.1115726694.squirrel@linux1>
References: <Pine.LNX.4.21.0505100040320.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 13:58:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVTMp-0001mU-OU
	for gcvg-git@gmane.org; Tue, 10 May 2005 13:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVEJME6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 08:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVEJME6
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 08:04:58 -0400
Received: from simmts5.bellnexxia.net ([206.47.199.163]:16081 "EHLO
	simmts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261620AbVEJME4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 08:04:56 -0400
Received: from linux1 ([69.156.111.46]) by simmts5-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050510120455.GFW1614.simmts5-srv.bellnexxia.net@linux1>;
          Tue, 10 May 2005 08:04:55 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4AC4pNj016749;
	Tue, 10 May 2005 08:04:52 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Tue, 10 May 2005 08:04:54 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.21.0505100040320.30848-100000@iabervon.org>
To: "Daniel Barkalow" <barkalow@iabervon.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, May 10, 2005 12:56 am, Daniel Barkalow said:
> It seems to me like projects like cogito which are based on a core which
> is itself a project and which is also part of other projects would benefit
> from some sort of support.
>
> In particular, it would be nice if Linus could pull the changes to the
> core without getting the wrapper programs at all.
>
> I'm thinking something like having a head for cogito and a head for git in
> the same repository, where the trees for git only have the core files, and
> the commits for cogito have, in addition to a tree with only the
> cogito-specific files, a reference to a git commit that they include.
>
> It seems to me like this area contains a brilliant idea that I haven't
> had so far, and maybe someone can come up with it.
>

That sounds like a great idea and shouldn't need any brilliant ideas to
implement.  Just need to push a little more multi-head handling down into 
 git.  The Cogito build process could then include a checkout of the
git-core branch.  Would be much cleaner than the way it is handled now.

Sean


