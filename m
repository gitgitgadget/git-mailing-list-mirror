From: Federico Mena Quintero <federico@novell.com>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
	summary continued
Date: Thu, 25 Oct 2007 11:16:04 -0500
Message-ID: <1193328964.4522.361.camel@cacharro.xalalinux.org>
References: <Pine.LNX.4.64.0710212308540.25221@racer.site>
	 <471C9B13.9080603@op5.se> <Pine.LNX.4.64.0710221445170.25221@racer.site>
	 <471CB443.9070606@op5.se>
	 <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com>
	 <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de>
	 <Pine.LNX.4.64.0710231155321.25221@racer.site>
	 <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de>
	 <20071024192058.GF29830@fieldses.org> <471F9FD1.6080002@op5.se>
	 <8fe92b430710241648j609d4d00x121836001a69d1e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 18:14:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il5LR-0002Pf-Hq
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 18:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbXJYQNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 12:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbXJYQNw
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 12:13:52 -0400
Received: from jericho.provo.novell.com ([137.65.248.124]:23704 "EHLO
	jericho.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbXJYQNw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 12:13:52 -0400
Received: from [164.99.192.129] ([164.99.192.129])
	by jericho.provo.novell.com with ESMTP; Thu, 25 Oct 2007 10:13:47 -0600
In-Reply-To: <8fe92b430710241648j609d4d00x121836001a69d1e6@mail.gmail.com>
X-Mailer: Evolution 2.11.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62333>

On Thu, 2007-10-25 at 01:48 +0200, Jakub Narebski wrote:

> git push is opposite (almost) to git fetch, not to git pull.

This asymmetry is also part of what makes Git hard to learn at first.

There is a lot of new terminology to learn:

  refs
  remotes
  fast-forwarding
  rebasing
  origin
  master
  HEAD (which is not quite the same as good old CVS's HEAD)
  etc.

The solution is not, "have a good glossary" (which is needed, anyway),
but to make the documentation introduce those concepts at the right
time, instead of being chock-full of them from the beginning :)

Carl Worth's git-ification of the Mercurial book chapter is very nice in
this regard; it doesn't dump all the terminology on you, but rather
takes its time to introduce each concept when you are ready to know
about it [1].

It's kind of sad that the first thing "man git-push" tells you is this:

       git-push - Update remote refs along with associated objects

So you go, "refs?  associated objects?  whaaaaaat?" :)

Imagine someone learning the GIMP a few versions ago.  "I want to make
this photo sharper".  You go to the Filters/Enhance menu and you see

  Laplace
  Sobel
  Sharpen
  Unsharp mask

All of those sharpen the image.  Which one do you pick?

[1] http://cworth.org/hgbook-git/

  Federico
