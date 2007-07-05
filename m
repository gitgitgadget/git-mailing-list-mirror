From: "Kees-Jan Dijkzeul" <k.j.dijkzeul@gmail.com>
Subject: Fwd: git-svn dcommit fail
Date: Thu, 5 Jul 2007 10:28:57 +0200
Message-ID: <fa0b6e200707050128h6bc3caa4rd661c64128ac7367@mail.gmail.com>
References: <4b3406f0707040256x31f0909cie126d950c60374f1@mail.gmail.com>
	 <468C999C.60701@midwinter.com>
	 <fa0b6e200707050126m17a23de6uad4909533306eb06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 05 10:29:03 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6Mhx-0000bU-Mr
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 10:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757106AbXGEI27 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 04:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752784AbXGEI27
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 04:28:59 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:4384 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbXGEI26 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 04:28:58 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2278971wxd
        for <git@vger.kernel.org>; Thu, 05 Jul 2007 01:28:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MOWmQ5ZUkurnww7sy1lqq7lE9fyZah0Z3i+dAh+w5vHrJrOL9xCL3FGrcqGAxOW9gCL7YMhiED6g9HathvouLOjWunxhCVj/SaQvARBveAEKVGfNAXxrfoEw6ACN4bTjVEqk4xT/DHk6qtMZqXLMv9ZGvVAFOiO/Jksf0xM2JFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QQbVrBfj5Y0JwqkDL9TY2Uc/4dEMy3miPnugc+UP/bh65kLLDvI2gRjxDeXv+2FAP2HJMaWZlvwmZGZKBQuBfxhlocFC33BWy51TKjdd8SS3dQHhFAo9s/esmy/hEvahoJa1dMxdSRFdaXwK56dm2pOJZuVs1U67eYVc6BFzyEo=
Received: by 10.143.7.11 with SMTP id k11mr564294wfi.1183624137170;
        Thu, 05 Jul 2007 01:28:57 -0700 (PDT)
Received: by 10.143.5.9 with HTTP; Thu, 5 Jul 2007 01:28:57 -0700 (PDT)
In-Reply-To: <fa0b6e200707050126m17a23de6uad4909533306eb06@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51664>

This one should have gone to the list. Sorry, Steven, for mailing privately.

---------- Forwarded message ----------
From: Kees-Jan Dijkzeul <k.j.dijkzeul@gmail.com>
Date: Jul 5, 2007 10:26 AM
Subject: Re: git-svn dcommit fail
To: Steven Grimm <koreth@midwinter.com>


On 7/5/07, Steven Grimm <koreth@midwinter.com> wrote:
> git-svn doesn't support nonlinear history in any of the official
> releases, though there will be some support in the next release (you can
> try it out by grabbing the latest version from git.git's master branch).

I just fetched the master branch. For me it is at commit
d44c782bbd6b0e806e056f9e8ff8cd8e426e67a3.
At this point, git-svn is identical to the one in 1.5.2.3.

I've attempted to use git to merge two subversion branches, but when
dcommitting attempts to commit the correct delta to the wrong branch,
and subsequently claims that "Your file or directory is probably out
of date" (which, in a weird way, makes sense).

I'd be happy to test this support for nonlinear history, but so far,
I've been unable to locate the correct commit.

Groetjes,

Kees-Jan
