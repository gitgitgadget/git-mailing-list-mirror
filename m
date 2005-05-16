From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: git-rev-list  in local commit order
Date: Mon, 16 May 2005 17:25:25 -0400 (EDT)
Message-ID: <1629.10.10.10.24.1116278725.squirrel@linux1>
References: <4127.10.10.10.24.1116107046.squirrel@linux1>                    
      <1116186533.11872.152.camel@tglx>                      
    <4971.10.10.10.24.1116187076.squirrel@linux1>                      
    <1116189873.11872.171.camel@tglx>                      
    <1102.10.10.10.24.1116189916.squirrel@linux1>                      
    <1116191636.11872.195.camel@tglx>                      
    <1273.10.10.10.24.1116192097.squirrel@linux1>                      
    <1116192629.11872.201.camel@tglx>                      
    <1392.10.10.10.24.1116193437.squirrel@linux1>                     
    <1116195235.11872.213.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 23:29:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXn92-00073n-4u
	for gcvg-git@gmane.org; Mon, 16 May 2005 23:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVEPV2Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 17:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVEPV0v
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 17:26:51 -0400
Received: from simmts12.bellnexxia.net ([206.47.199.141]:48309 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261898AbVEPVZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2005 17:25:26 -0400
Received: from linux1 ([69.156.111.46]) by simmts12-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050516212525.USOO19200.simmts12-srv.bellnexxia.net@linux1>;
          Mon, 16 May 2005 17:25:25 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4GLPOk7020562;
	Mon, 16 May 2005 17:25:25 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Mon, 16 May 2005 17:25:25 -0400 (EDT)
To: tglx@linutronix.de
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
In-Reply-To: <1116195235.11872.213.camel@tglx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 15, 2005 6:13 pm, Thomas Gleixner said:
> Last try.
>
> A repository Id makes it possible to identify workflows in and across
> repositories.

Sorry, your proposal falls short, accurate work flow would allow you to
show every repository a commit passed through on the way to its final
destination.  Your proposal does not allow that; as discussed.  Nor does
it handle multiple projects or branches within a single repository.

As noted by others, using git often means the creation of temporary
repositories, hardly something that deserves an identifier.  Git, by
design, doesn't give a hoot about individual repositories.

And you also haven't addressed what to do when someone else uses say,
Linus' repoid, as their own.  It seems like a risk to have the operation
of each repository depend on a value anyone else can duplicate.  Linus
can't control what repoid everyone else uses, he can control the time on
his own machine.  Unique repoid's are an illusion.

> This information is valuable for me and others due to already discussed
> reasons.

Why should everyone else manage repoids in their own personal repository
for you; what value will _they_ get out of it?

> I accept that is irrelevant for you.

Personally I don't really care either way.  But you haven't given one real
example where it is actually needed to do useful work.  Making pretty
graphs on a web page doesn't count if they're not useful to anyone.  You
shouldn't force everyone else to manage repoid's unless there is some
value for _them_.

If you're still going to pursue this, at least make sure repoid is not
mandatory.  If a local repository identifier isn't defined, don't create a
repoid line in the commits.

Sean


