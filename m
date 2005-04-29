From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 14:33:40 -0400 (EDT)
Message-ID: <2712.10.10.10.24.1114799620.squirrel@linux1>
References: <Pine.LNX.4.58.0504291051460.18901@ppc970.osdl.org> (message from
    Linus Torvalds on Fri, 29 Apr 2005 10:56:30 -0700 (PDT))
    <200504291808.LAA25870@emf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: torvalds@osdl.org, mpm@selenic.com, linux-kernel@vger.kernel.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 20:28:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRaDp-0001ZD-BU
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 20:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262880AbVD2Sdz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 14:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbVD2Sdz
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 14:33:55 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:46791 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262877AbVD2Sdu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 14:33:50 -0400
Received: from linux1 ([67.71.124.169]) by simmts8-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050429183345.DBBO1623.simmts8-srv.bellnexxia.net@linux1>;
          Fri, 29 Apr 2005 14:33:45 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j3TIXaId000787;
	Fri, 29 Apr 2005 14:33:40 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Fri, 29 Apr 2005 14:33:40 -0400 (EDT)
In-Reply-To: <200504291808.LAA25870@emf.net>
To: "Tom Lord" <lord@emf.net>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, April 29, 2005 2:08 pm, Tom Lord said:

> The confusion here is that you are talking about computational complexity
> while I am talking about complexity measured in hours of labor.
>
> You are assuming that the programmer generating the signature blindly
> trusts the tool to generate the signed document accurately.   I am
> saying that it should be tractable for human beings to read the documents
> they are going to sign.


Developers obviously _do_ read the changes they submit to a project or
they would lose their trusted status.  That has absolutely nothing to do
with signing, it's the exact same way things work today, without sigs.

It's not "blind trust" to expect a script to reproducibly sign documents
you've decided to submit to a project.  The signature is not a QUALITY
guarantee in and of itself.  It doesn't mean you have any additional
responsibility to remove all bugs before submitting.  Conversely, not
signing something doesn't mean you can submit crap.

See?  Signing something does not change the quality guarantee one way or
the other.  It does not put any additional demands on the developer, so
it's fine to have an automated script do it.  It's just a way to avoid
impersonations.

Sean

