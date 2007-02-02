From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2/3] Rebase to parent branch after git-fetch in "stg pull".
Date: Fri, 2 Feb 2007 23:01:59 +0000
Message-ID: <b0943d9e0702021501g2cb9bb6cocae0d706c8742868@mail.gmail.com>
References: <20070201234534.3313.10426.stgit@gandelf.nowhere.earth>
	 <20070201234805.3313.20525.stgit@gandelf.nowhere.earth>
	 <b0943d9e0702020158o1a07b8efu9302794c57d050e1@mail.gmail.com>
	 <20070202180706.GE5362@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20070202224250.GF5362@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Feb 03 00:02:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD7Py-0001wV-BL
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 00:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946139AbXBBXCD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 18:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946152AbXBBXCD
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 18:02:03 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:55561 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946139AbXBBXCA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 18:02:00 -0500
Received: by wr-out-0506.google.com with SMTP id 68so856846wri
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 15:01:59 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LZe8TKLbw+M5UGkYNTdI9zISqD6Ur1j88PQZuRI2lQsPlcFfteTO06SbYj+GRhTPwwCMYEZ+zhQ1kMihB0i/fZjUZLjWl/7XvC/kdCRRxac7TesiarfGYUwnr8riiWj70g4MJildD9TdJcnWWL9uqA6Gn/vvnjqXl/o0kx79by8=
Received: by 10.114.126.1 with SMTP id y1mr435736wac.1170457319118;
        Fri, 02 Feb 2007 15:01:59 -0800 (PST)
Received: by 10.115.110.12 with HTTP; Fri, 2 Feb 2007 15:01:59 -0800 (PST)
In-Reply-To: <20070202224250.GF5362@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38538>

On 02/02/07, Yann Dirson <ydirson@altern.org> wrote:
> On Fri, Feb 02, 2007 at 07:07:06PM +0100, Yann Dirson wrote:
> > > The t1200-push-modified.sh test fails after applying this patch. It
> > > looks like the 3rd test fails to pull the changes from 'foo' into
> > > 'bar'.
> >
> > Strange, it passes here, even after pulling you latest commits
> > (HEAD=fba895f5f12a652c248b0fd02b7c41f8342cfbdc).
>
> Wondering which GIT version you are using, I tried to run the
> testsuite with current GIT HEAD, and it fails much earlier (t1001).
> We'll have some work here :)

I tried the latest GIT and it only fails at t1200. I think I got a
t1001 failure but I fixed it. Do you want me to push the snapshot I
have and you can see whether it fails on your system? I tried it with
both Python 2.4 and 2.3 but what's strange is that 'pull' run manually
(not from the test script) seems to work.

-- 
Catalin
