From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn dcommit doesn't support --username option for file:///
 urls
Date: Mon, 15 Feb 2016 21:14:13 +0000
Message-ID: <20160215211413.GA1578@dcvr.yhbt.net>
References: <CAGZMbfc5Oi=EOYbCbZWfM1T65AZwCEbsso+QTkAe1sa4hRC61A@mail.gmail.com>
 <20160215100636.GA5785@dcvr.yhbt.net>
 <CAGZMbfdem6YzrEUw9A6ZWAbm6zXkNxqM3myAjHz4xFDS79VYwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Ringenbach <tim.ringenbach@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 22:14:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVQTK-0002hU-CG
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 22:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbcBOVOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 16:14:14 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:52061 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487AbcBOVOO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 16:14:14 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13BA20318;
	Mon, 15 Feb 2016 21:14:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAGZMbfdem6YzrEUw9A6ZWAbm6zXkNxqM3myAjHz4xFDS79VYwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286241>

Tim Ringenbach <tim.ringenbach@gmail.com> wrote:
> On Mon, Feb 15, 2016 at 4:06 AM, Eric Wong <normalperson@yhbt.net> wrote:
> [snip]
> > Totally untested, but does flipping the order of auth providers
> > help at all?
> 
> Thanks for looking into this. Unfortunately, that didn't seem to make
> a difference.

Thanks for trying.

It might take a while for me to get around to looking at this
more, so it would be very helpful if you poked around and tried
some different things in the source.

It should be helpful to look at any other SVN wrappers (or code
SVN itself).  In the past, I got a lot of help from looking at
svk/SVN::Mirror.

I'm certainly no expert when it comes to using the SVN API,
so it's likely we're doing something wrong...

Btw, which version of SVN are you using?  I also wonder if
there's something version-dependent.
