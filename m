From: Wincent Colaiuta <win@wincent.com>
Subject: Re: yet another workflow question...
Date: Thu, 11 Oct 2007 16:39:01 +0200
Message-ID: <00CC9676-C6D8-4E9E-ABE3-A6238810B536@wincent.com>
References: <e2a1d0aa0710110711m77ca967bmd1d5ffd5d3099aab@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: "Patrick Doyle" <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 16:39:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfzCJ-00088m-UL
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 16:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbXJKOj1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Oct 2007 10:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752773AbXJKOj1
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 10:39:27 -0400
Received: from wincent.com ([72.3.236.74]:41801 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbXJKOj0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2007 10:39:26 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l9BEdNYF025469;
	Thu, 11 Oct 2007 09:39:24 -0500
In-Reply-To: <e2a1d0aa0710110711m77ca967bmd1d5ffd5d3099aab@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60602>

El 11/10/2007, a las 16:11, Patrick Doyle escribi=F3:

> Sorry for cluttering up the list with yet another very basic workflow
> question, but I'm still struggling with finding an answer to the
> burning question, "What can git do for me?"  (So far, I have come to
> the conclusion that, for my simple, single developer, branchless,
> linear projects, there's not much that git can do for me that any
> other SCM could do for me.  It appears to have been designed to solve
> problems for which I have absolutely no appreciation whatsoever. :-))

Even with the workflow you describe, Git brings some nice benefits:

1. Faster than anything else out there
2. You can work offline (even if you have an "always on" net =20
connection, think about the times when it goes down)
3. You can easily amend mistakes in your last commit (git-commit --=20
amend)
4. You can easily stash away work in progress and go off on a tangent =20
(git-stash)
5. You get nice colorized diff and log output for free
6. Great visualization tools included for free (gitk, git-gui etc)

And those are just a few off the top of my head. The more you work =20
with Git, the more benefits you will discover, even if you're not =20
trying to do anything fancy with it. And although you are currently =20
using branchless development, you may find with time that you start =20
using things like topic branches simply because Git makes it so darn =20
easy to do so, and the benefit is that you'll keep your history much =20
cleaner and easier to understand when you go back to look at it later =20
on.

Cheers,
Wincent
