From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] git-gui USer's Survey 2007 (was: If you would write git
 from scratch now, what would you change?)
Date: Wed, 28 Nov 2007 12:32:10 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711281225150.27959@racer.site>
References: <200711252248.27904.jnareb@gmail.com> <fiet88$68n$1@ger.gmane.org>
 <e5bfff550711261125i92fb057i85d7217b18cd495d@mail.gmail.com>
 <20071127012013.GG14735@spearce.org> <fifstd$ilj$1@ger.gmane.org>
 <20071127015833.GL14735@spearce.org> <Pine.LNX.4.64.0711271136050.27959@racer.site>
 <fiib19$dj6$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 13:32:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxM5w-0000fI-MK
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 13:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbXK1McT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 07:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbXK1McT
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 07:32:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:53988 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750802AbXK1McS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 07:32:18 -0500
Received: (qmail invoked by alias); 28 Nov 2007 12:32:17 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 28 Nov 2007 13:32:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18j+Jk8pGIjLEBZuvyYYTCwB/8/kzJNW+uop4+C/2
	w5hob4cnnMSBqv
X-X-Sender: gene099@racer.site
In-Reply-To: <fiib19$dj6$1@ger.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66307>

Hi,

On Wed, 28 Nov 2007, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > On Mon, 26 Nov 2007, Shawn O. Pearce wrote:
> > 
> >> Actually I might revisit this XUL concept using an HTTP server and 
> >> AJAX.  I could actually link the damn HTTP server against libgit.a 
> >> (Junio will hate me).  If the server dies XUL can notice it and 
> >> simply restart it.
> > 
> > But if you can restart the HTTP server via XUL, you can start other 
> > git programs directly.
> > 
> > What you'd have to do is (urgh) write a wrapper via start_command() 
> > which would recognize that the second process die()d.
> > 
> > All in all, I think if you want to switch from Tcl/Tk to another 
> > language for git-gui, for the sake of attracting more developers, it 
> > might be wiser to go Java than XUL.
> 
> Wont we get with the same problems as egit/jgit?

My idea was not to get the same problems, but to use jgit.  After all, 
Shawn made a point of separating the both.

> ----
> This is proposed set of questions for git-gui mini survey...
> 
> 1. What language and what toolkit should git-gui be written in?
>    (single choice)
> 
>    a. Tcl/Tk    (current implementation)
>    b. C++/Qt
>    c. C/GTK+
>    d. Python    (native)
>    e. Python/PyQt
>    f. Python/PyGTK
>    g. Ruby
>    h. Java/Swing
>    i. Java/SWT
>    j. XUL+JavaScript+CSS/XULRunner
>    k. other
>    l. no opinion

I am pretty comfortable with a), but rather than go [b-gi-l] I would 
prefer h).

> 3. Do you contribute to git-gui?
>    Yes/No

Yes (sort of; not half as much as I'd like to.)

> 4. If git-gui would use other language/toolkit, would you contribute?
>    Yes/No

Yes, as long as it is a language/toolkit that is available on all 
platforms that I (have to) work.  That pretty much excludes C# and Python 
as a language.

> 5. What languages and what toolkits you are proficient with (to send
>    patches)? 
>    (multiple choice)
> 
>    a. Tcl/Tk    (current implementation)
>    b. C++/Qt
>    c. C/GTK+
>    d. Python    (native)
>    e. Python/PyQt
>    f. Python/PyGTK
>    g. Ruby
>    h. Java/Swing
>    i. Java/SWT
>    j. XUL+JavaScript+CSS/XULRunner
>    k. other
>    l. N/A

[abchk]

> 6. What other?

Personally, I am quite comfortable with the existing implementation, and 
IMHO people dismiss contributing to git-gui too easily; Tcl is not all 
that complicated, and it is not hard at all to change/imitate existing 
code.

Ciao,
Dscho
