From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: syntax for checking out specific tag on a remote
Date: Sat, 11 Aug 2007 21:57:34 -0400
Message-ID: <9e4733910708111857h1ec88ed2t513064e3661ef49b@mail.gmail.com>
References: <9e4733910708111833r6588557al1876bd6aaae38204@mail.gmail.com>
	 <7v1we9leb9.fsf@assigned-by-dhcp.cox.net>
	 <9e4733910708111850v6e9669c3i536fba49f63d0f10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 03:57:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IK2i3-0004tK-1y
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 03:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757916AbXHLB5g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 21:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757065AbXHLB5g
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 21:57:36 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:31057 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934AbXHLB5f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 21:57:35 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1385113wah
        for <git@vger.kernel.org>; Sat, 11 Aug 2007 18:57:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qpp9NPzgHdijTbYYtmj9EqgNYST7NGTcI4TtXrAkV283kgbumCVWTLMHozYp3PAtHlTzhluwY4l304fLp4yynFg5hBVLFCoBp4PGKTY8aD0hMTrvR2s62skeOt28nhHbJYdBs+vei4z0OLgQ0c+2hhA2bfs3xpoc+lRzW2FN7Cg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PiMtqlVL/M40djenaHqkNNukZbSU1BTpepsdOTt4u6BdQNo9sC/iHg3NChnHLtdkMLC6qbz2fr1imjr4O5S9kYHSekLOHbllXyYVSA4pBQcaoajHay57HjdQ/L4qSLVht5HoMllMQNGCHYVbNVvDLOGzb/N27TAV/x8LQ7PqILk=
Received: by 10.114.38.2 with SMTP id l2mr1931310wal.1186883854848;
        Sat, 11 Aug 2007 18:57:34 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Sat, 11 Aug 2007 18:57:34 -0700 (PDT)
In-Reply-To: <9e4733910708111850v6e9669c3i536fba49f63d0f10@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55661>

On 8/11/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 8/11/07, Junio C Hamano <gitster@pobox.com> wrote:
> > "Jon Smirl" <jonsmirl@gmail.com> writes:
> >
> > > What's the syntax for checking out a specific tag on a remote?
> >
> > This depends on where you stored the tags you obtained from the
> > remote.  By default, "git fetch --tags" would store the tags in
> > a flat namespace; there is no "remote tag" namespace.
>
> I've been storing unrelated trees in the same git db. It never
> occurred to me that there was a single tag name space. So if two of my
> remotes both make a tag TEST then last one fetched will win? Are
> "remote tag" namespaces planned for the future?

This seems inconsistent to me. Remote heads have their own namespace
but remote tags don't.

-- 
Jon Smirl
jonsmirl@gmail.com
