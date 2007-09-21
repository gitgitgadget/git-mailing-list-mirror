From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Added a new placeholder '%cm' for full commit message
Date: Fri, 21 Sep 2007 12:08:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709211207070.28395@racer.site>
References: <20070921101420.GD22869@mageo.cz> <Pine.LNX.4.64.0709211146090.28395@racer.site>
 <20070921110646.GA9072@mageo.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Michal Vitecek <fuf@mageo.cz>
X-From: git-owner@vger.kernel.org Fri Sep 21 13:09:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYgO9-0007Uo-F1
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 13:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963AbXIULJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 07:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756210AbXIULJc
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 07:09:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:42029 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753558AbXIULJb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 07:09:31 -0400
Received: (qmail invoked by alias); 21 Sep 2007 11:09:30 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 21 Sep 2007 13:09:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19A7esm0ahAAQsRNy3PzeYK5cDA8m9ibQIZgYVu/6
	CkS0/I+m3+5p9+
X-X-Sender: gene099@racer.site
In-Reply-To: <20070921110646.GA9072@mageo.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58844>

Hi,

On Fri, 21 Sep 2007, Michal Vitecek wrote:

> Johannes Schindelin wrote:
> >On Fri, 21 Sep 2007, Michal Vitecek wrote:
> >
> >> I have added a new placeholder '%cm' for a full commit message.
> >
> >You mean the raw message, including the headers?  Why not use "%r" for 
> >that?
> 
>  No, sorry for the incorrect term. I meant the whole commit message
>  (subject + 2*\n + body).

Ah, makes sense.  In that case, "%M" maybe?

> >> I made it because I want to use my own pretty format which currently 
> >> only allows '%s' for subject and '%b' for body. But '%b' is 
> >> substituted with <undefined> if the body is "missing" which I 
> >> obviously don't like :)
> >
> >Then you should fix %b not to show "<undefined>".
> 
>  I'll do it if it is okay. Shall I do the same for the other
>  placeholders as well?

Yeah.  Don't know why I did it that way.

> >And please adher to the tips in Documentation/SubmittingPatches.
> 
>  Will do, sorry about the attachment - still learning :)

No problem.  Thanks for contributing!

Ciao,
Dscho
