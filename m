From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: cogito - how do I ???
Date: Sat, 21 May 2005 18:06:04 -0400 (EDT)
Message-ID: <2765.10.10.10.24.1116713164.squirrel@linux1>
References: <20050521214700.GA18676@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 00:05:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZc5d-0005r1-1G
	for gcvg-git@gmane.org; Sun, 22 May 2005 00:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVEUWGJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 18:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVEUWGJ
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 18:06:09 -0400
Received: from simmts12.bellnexxia.net ([206.47.199.141]:17406 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261648AbVEUWGF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 18:06:05 -0400
Received: from linux1 ([69.156.111.46]) by simmts12-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050521220604.SICM1005.simmts12-srv.bellnexxia.net@linux1>;
          Sat, 21 May 2005 18:06:04 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4LM64jJ023893;
	Sat, 21 May 2005 18:06:04 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sat, 21 May 2005 18:06:04 -0400 (EDT)
In-Reply-To: <20050521214700.GA18676@mars.ravnborg.org>
To: "Sam Ravnborg" <sam@ravnborg.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, May 21, 2005 5:47 pm, Sam Ravnborg said:
> Hi all.
>
> While trying to get up to speed on cogito/git I stumbled across
> a few things that I at least did not find available in cogito.
>
> 1) Something similar to "bk changes -R". I use this to see what has
> happened upstream - to see if I really want to merge stuff.

Not sure what bk did here, but you can do something like:

cg-pull origin
cg-log -c -r origin

To see what is at the head of the unmerged objects you just pulled down,
and if you want to merge then "cg-merge origin".  Although as far as I
know there's no way to have the log stop automatically at the proper spot.

> 2) Export of individual patches. "bk export -tpatch -r1.2345"
> I have nu public git repository yet so I have to feed changes as
> plain patches. Browsing cg-* I did not find the command to do this.

cg-diff -p -r SHA1

Which asks for the diff from the parent (-p) to the revision (-r).

Sean


