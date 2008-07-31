From: "Craig L. Ching" <cching@mqsoftware.com>
Subject: RE: Git vs Monotone
Date: Thu, 31 Jul 2008 14:28:21 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F79430238A5EC@emailmn.mqsoftware.com>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com> <alpine.LFD.1.10.0807311211260.3277@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Git Mailinglist" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
	<sverre@rabbelier.nl>
X-From: git-owner@vger.kernel.org Thu Jul 31 21:30:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOdr7-0008Go-TS
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 21:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008AbYGaT3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 15:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753547AbYGaT3d
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 15:29:33 -0400
Received: from mail.de.mqsoftware.com ([66.192.70.108]:55125 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbYGaT3c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 15:29:32 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <alpine.LFD.1.10.0807311211260.3277@nehalem.linux-foundation.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Git vs Monotone
Thread-Index: AcjzQpKt1InvJeuJRmaYho7KUAh5pgAAIhlg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90973>

 

> [mailto:git-owner@vger.kernel.org] On Behalf Of Linus Torvalds
> Sent: Thursday, July 31, 2008 2:18 PM
> Subject: Re: Git vs Monotone
> 
> On Thu, 31 Jul 2008, Sverre Rabbelier wrote:
> > 
> The guy is apparently happy using a single database for 
> monotone (which apparently has a database that is two times 
> the size of the git one), but then doesn't want to use a 
> single database for git, but wants to force a full clone for 
> each. Not to mention that in git, you'd normally not do 11 
> clones to begin with, you'd just do 11 branches in one repo.
> 

Having come from monotone to git recently, I have to say that it isn't
immediately obvious how you get the single database for git a la
monotone (with remotes that point to the right place, etc.).  At first,
I also thought that you didn't share the object database on clones and I
had to discover that myself.  It's possible that I'm just an idiot too
;-)

> So there is no point discussing things with people like that. 
> If he wants to skew things in monotone's favor, he can do it. 
> Let him. 
> 

It's possible he's doing that, but it's also possible he just isn't that
familiar with git.

> 			Linus
> --

Cheers,
Craig
