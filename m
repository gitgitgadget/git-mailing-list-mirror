From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Mon, 12 Nov 2007 19:55:41 +0100
Message-ID: <200711121955.42154.wielemak@science.uva.nl>
References: <86k5on8v6p.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0711121727130.4362@racer.site> <vpq7iknqrtp.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 19:56:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IreS2-0007Ia-B1
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 19:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbXKLSzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 13:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbXKLSzp
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 13:55:45 -0500
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:2305 "EHLO
	smtp-vbr8.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbXKLSzp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 13:55:45 -0500
Received: from ct.xs4all.nl (ct.xs4all.nl [82.92.39.12])
	by smtp-vbr8.xs4all.nl (8.13.8/8.13.8) with ESMTP id lACIthXM098896
	for <git@vger.kernel.org>; Mon, 12 Nov 2007 19:55:43 +0100 (CET)
	(envelope-from wielemak@science.uva.nl)
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <vpq7iknqrtp.fsf@bauges.imag.fr>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64685>

On Monday 12 November 2007 18:47:14 Matthieu Moy wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > I don't see what is soooo hard with using git-remote in the repo you are
> > pushing from.  It's just a "git remote add origin <url>", and you can
> > even use this to push right afterwards: "git push --all origin".
>
> If "git remote add" is so easy, why does "git clone" set up the remote
> for you?
>
> And don't tell me that you didn't notice that "git clone" does more
> than your proposed "git remote add origin ...".
>
> > Besides, if you really want to work together, chances are that you do
> > _not_ want to start with <n> independent initial commits.
>
> So, what?
>
> > So you need to populate the repository before starting _anyway_.
>
> Last time I checked, the thread was talking about bare repository.
> Perhaps you have a magic formula to populate a bare repository without
> pushing to it from another repo, but I don't.

Hey guys, don't fight about the details.  Just stick to

	* Creating a bare empty repositiory is possible and a perfectly
	valid way to create a shared repositiory.
	* Clone and push is the natural way to modify it.  At least to
	me this was the obvious thing to do.  Explicitely playing with
	remotes is -as far as i'm concerned- lesson 2.
	* If this cannot be done (but, what is wrong with an empty tree?)
	at least
		- git clone should *not* say it created a repository
		- The documentation should have a note on that

	Cheers --- Jan
