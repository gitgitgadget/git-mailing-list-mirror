From: Stephen Bash <bash@genarts.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Fri, 15 Oct 2010 20:16:59 -0400 (EDT)
Message-ID: <26761091.515858.1287188219315.JavaMail.root@mail.hq.genarts.com>
References: <AANLkTim6w54CPhw0GzaDxT9e0t19XQ7-rMEe5aSBevS+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	David Barr <david.barr@cordelta.com>,
	Tomas Carnecky <tom@dbservice.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 16 02:17:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6uSY-0001vL-Uh
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 02:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab0JPARI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 20:17:08 -0400
Received: from hq.genarts.com ([173.9.65.1]:44069 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751044Ab0JPARH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 20:17:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id D1C161E26960;
	Fri, 15 Oct 2010 20:17:05 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8PXHkmeTchdA; Fri, 15 Oct 2010 20:16:59 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 8D9C61E2695F;
	Fri, 15 Oct 2010 20:16:59 -0400 (EDT)
In-Reply-To: <AANLkTim6w54CPhw0GzaDxT9e0t19XQ7-rMEe5aSBevS+@mail.gmail.com>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159151>



----- Original Message -----
> From: "Sverre Rabbelier" <srabbelier@gmail.com>
> To: "Stephen Bash" <bash@genarts.com>
> Sent: Friday, October 15, 2010 7:39:09 PM
> Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial git-svn fetch)
> 
> On Fri, Oct 15, 2010 at 09:50, Stephen Bash <bash@genarts.com> wrote:
> > I think using notes is a better way to associate conversion
> > information
> > with commits, but I would probably still end up mining the notes to
> > create
> > some sort of svn to git mapping... Correct me if I'm wrong, but I
> > don't see
> > how notes would help me get from an svn rev to a git sha (a common
> > practice for tickets and wiki links in our organization).
> 
> Ah, hmm, that is a good point. Couldn't you just tag object
> 0000000000000000143 for svn revision 143?

Yeah, I actually thought about that as I was writing the comment...  And after a completely unrelated conversation about tags at $WORK this afternoon, I'm half tempted to make a refs/tags/svn directory with lightweight tags named for SVN revs that point to the appropriate git object.  That idea along with a bunch of others are now brewing a 2.0 in my head since I started revisiting this proces.  We'll see if I have a productive weekend or not...

> > I guess after that I should add that I'm happy to help, I'm just not
> > sure
> > where my experience maps to the on going effort.
> 
> Just general feedback, sanity checking, and if you're interested,
> "beta testing" I think would be very useful :).

I will do my best.

Thanks,
Stephen
