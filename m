From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Wed, 31 Jan 2007 17:15:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701311708470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87odognuhl.wl%cworth@cworth.org>
 <8b65902a0701310513s1f8bfa04o7e1c7e43b7453ac8@mail.gmail.com>
 <87k5z3npsz.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Guilhem Bonnefille <guilhem.bonnefille@gmail.com>,
	git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Wed Jan 31 17:25:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCI7d-0008Qh-IH
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 17:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbXAaQPg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 11:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbXAaQPg
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 11:15:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:59747 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030226AbXAaQPf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 11:15:35 -0500
Received: (qmail invoked by alias); 31 Jan 2007 16:15:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp051) with SMTP; 31 Jan 2007 17:15:34 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <87k5z3npsz.wl%cworth@cworth.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38267>

Hi,

On Wed, 31 Jan 2007, Carl Worth wrote:

> On Wed, 31 Jan 2007 14:13:42 +0100, "Guilhem Bonnefille" wrote:
> > If the user is not a developer and only interested in testing, what
> > about a simple snapshot tarball?
> > So, you prepare the fix and then you pack everything in a
> > myapp-timestamp.tar.gz and send this tarball to the user.
> 
> That's bad for all the same reasons we don't send tarballs around to 
> each other.

Well, that's not completely fair. Guilhem has a point here.

> 1. I want to be able to easily publicize a new branch with
>    instructions that anyone can use, (regardless of git experience).

How about gitweb, with a snapshot link? It's as easy as it gets. Even 
those Windows idio^H^H^H^Husers can unpack tar.gz files by now, and you 
send them just a link. They can even see what was fixed, and when, if they 
care enough.
 
> > 2. I've got the stuff available in a git branch already, and I don't
>    want to do any more work.

That is one of the lousiest excuses in this world. Unfortunately, I hear 
it very, very often. (I mean the second sentence.)

> 3. I want the exchange to be as efficient as possible, (I might send
>    multiple fixes in series to the user and it'd be really nice to
>    take advantage of git's efficiency here).

There's two kinds of efficient here. Efficient in the sense of network 
traffic, or in the sense of time spent talking back and forth, until the 
package is finally tested.

If the efficiency you are thriving for is network traffic, go a head, make 
the user use git.

However, if it is the other efficiency you want to achieve, stay away from 
git. Chances are that your user will never appreciate what git can to for 
her, and just wants to test the darned package, and be done with it, 
thank you very much.

> 4. I don't want to condemn the user to never being able to learn
>    git. If I make this easy for the user then I get a nice lead-in to
>    teach the user new things, (which is good for me since it helps me
>    if the user starts sending me git commits rather than random
>    patches without commit messages connected to who-knows-what
>    tar-file version of the software, etc.)

That's nice of you. But it might just be that you royally p*ss the 
customer off, because he does not have time for that game.

Ciao,
Dscho
