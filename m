From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git bug/feature request
Date: Tue, 27 Nov 2007 15:19:42 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711271514180.5349@iabervon.org>
References: <200711271127.41161.gapon007@gmail.com>
 <Pine.LNX.4.64.0711271531110.1011@ds9.cixit.se> <fihc5u$mbs$1@ger.gmane.org>
 <FA6B0BE9-FC43-4298-932F-627826ADE18F@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 21:20:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix6ua-0005VG-8r
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 21:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021AbXK0UTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 15:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754940AbXK0UTo
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 15:19:44 -0500
Received: from iabervon.org ([66.92.72.58]:34039 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754762AbXK0UTo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 15:19:44 -0500
Received: (qmail 5847 invoked by uid 1000); 27 Nov 2007 20:19:42 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Nov 2007 20:19:42 -0000
In-Reply-To: <FA6B0BE9-FC43-4298-932F-627826ADE18F@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66256>

On Tue, 27 Nov 2007, Steven Grimm wrote:

> On Nov 27, 2007, at 7:13 AM, Jakub Narebski wrote:
> >I thought that modern git refuses to push into checked out branch
> >(in HEAD) in non-bare repositories.
> 
> It doesn't -- otherwise the "update the working copy when a push to the
> current branch comes in" update hook scripts that some of us use wouldn't
> work, and they do work at the moment. (Before anyone warns me of the dangers
> of that: the hook only runs in a shared repo that no human is allowed to
> modify, so the working copy is always a clean version of HEAD and thus is safe
> to update.)

It could require the working copy to be a clean version of HEAD, and, in 
this case, update it. Then it would always be kept consistent one way or 
the other, without consistency depending on the use of a hook. (This is 
like how a pre-refs/remotes/ pull into a checked-out origin was handled, 
and it seemed reliable there)

	-Daniel
*This .sig left intentionally blank*
