From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: What are branches?
Date: Tue, 21 Apr 2009 00:16:06 +0400
Message-ID: <20090420201606.GH25059@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de> <20090420113216.GC25059@dpotapov.dyndns.org> <49EC6596.8060208@drmicha.warpmail.net> <20090420132414.GD25059@dpotapov.dyndns.org> <alpine.DEB.1.00.0904201621290.6771@intel-tinevez-2-302> <20090420184746.GG25059@dpotapov.dyndns.org> <alpine.DEB.1.00.0904202117010.6771@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 20 22:18:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvzww-000533-SS
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 22:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757156AbZDTUQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 16:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbZDTUQm
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 16:16:42 -0400
Received: from ti-out-0910.google.com ([209.85.142.187]:8974 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756961AbZDTUQk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 16:16:40 -0400
Received: by ti-out-0910.google.com with SMTP id 11so1413469tim.23
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 13:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8d9W1GIA/jHFq7vXYsL0Z9RXchcRPf+GFA23Bd18KRo=;
        b=EpFbngg/rpT4SWjU++kTS+8PLFh+Mc4EH4KJTM5r7rI8F5tgW3WO4MYr5JTUVRmeb0
         yLIyNgLYWhd/pGmgxIyOP9nf0Sny4Zun/EfIUBZhaZaxNBCgCmMoFqg7ArEloQ4tQ0NV
         OqwDVzuwKCZhKfiMpdDSky7EV+nqXuvO42IW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pLvRIFGhaS0lCGeiixt7tSIjhWgr/Y/TybSi/1Zp3KKlbYm8wvUYSzhfiuNxNkoA3C
         N2bpVHQjNlq8ayiZYzVuNzWlg/dbum5jq0nDWMAkXj9bB7AROaN9BuzRnmEJP3nwdiDr
         W9aUpkKHmv83M5lEaxVyg/O7Hw3yGsp4gUbGE=
Received: by 10.110.63.17 with SMTP id l17mr6596720tia.48.1240258599214;
        Mon, 20 Apr 2009 13:16:39 -0700 (PDT)
Received: from localhost (ppp91-78-50-115.pppoe.mtu-net.ru [91.78.50.115])
        by mx.google.com with ESMTPS id b7sm2192284tic.33.2009.04.20.13.16.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 13:16:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0904202117010.6771@intel-tinevez-2-302>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117028>

On Mon, Apr 20, 2009 at 09:19:10PM +0200, Johannes Schindelin wrote:
> 
> The purpose of my message was to make Git old-timers _aware_ of the 
> problems newbies have with our notion of branches.  And a wish to come up 
> with less confusing documentation.

Thank you for your attempt bringing attention to this problem, but I
think anyone who remember their first steps with Git or have observed
other people starting to use Git recently have noticed that already.

I will try quickly summarize my view of it:

- branches in Git are not fundamentally different than in other VCSes,
  and clearly correspond commonly used definition of this term.
  Obviously, every VCS has some difference in the way how it manages
  branches (which makes use of branches in some VCS much easier than in
  others).

- obviously, all newcomers have some ideas about branches based on their
  previous experience (whether it was another VCS or some books), but
  often they do not give much thought to branches before, because they
  rarely used them except two or three branches (like maint and master),
  and many have never merged branches.

- the graph shown by gitk may be very confusing for beginners, because
  they cannot see the branch line, in particular, of the master branch.

- I don't find documentation to be confusing, but it doesn't mean that it
  cannot be improved. Yet, based on my observation, most confusion are
  among those users who has shown less propensity to read documentation.


Dmitry
