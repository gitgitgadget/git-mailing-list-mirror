From: "Elijah Newren" <newren@gmail.com>
Subject: Re: Trying to use git-filter-branch to compress history by removing large, obsolete binary files
Date: Sun, 7 Oct 2007 16:00:51 -0600
Message-ID: <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com>
	 <20071007213817.GJ31659@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Frank Lichtenheld" <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Mon Oct 08 00:01:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeeBL-0001JI-KN
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 00:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474AbXJGWAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 18:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752328AbXJGWAx
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 18:00:53 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:16439 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbXJGWAw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 18:00:52 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1438940wah
        for <git@vger.kernel.org>; Sun, 07 Oct 2007 15:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=O1A7ARufOI9NGyqLDcJ+Zq6dkIYXPyhZg+rGJ1nF5KI=;
        b=lNQxRm7fX7NL3UtUGzcRjTASQSYDPB1Cai2y/KZg0PjEg2mPsACht55nC/xs9OoL9AMO5zc1HHnfmkThNMT+pZteIxsN9bwaTp2N1zZOb0/ZYFzexESn4uErBs5/4c++Y2DopCQZucb08qx376L+KopC6tVHQIFOWPVoO0GJ5+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t6HOx/gHpNy4Ac6Q8/nscQsHXA3ECXhtvBEPyy3eAUoE0lNmtGZqgUWBU8iyb6eFP3XP6xebMdFCh0o4P0nhuDFdQJKEk6ZT97vqr4K+kagwVlH8Dy1S34PuM69lPQFdGtbMwH1EHbY6j6Cj7a8etK7t/JD7uXGyyThT4xbIsLs=
Received: by 10.114.175.16 with SMTP id x16mr2314579wae.1191794451958;
        Sun, 07 Oct 2007 15:00:51 -0700 (PDT)
Received: by 10.114.211.8 with HTTP; Sun, 7 Oct 2007 15:00:51 -0700 (PDT)
In-Reply-To: <20071007213817.GJ31659@planck.djpig.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60228>

On 10/7/07, Frank Lichtenheld <frank@lichtenheld.de> wrote:
> On Sun, Oct 07, 2007 at 03:23:59PM -0600, Elijah Newren wrote:
> > The following set of instructions will duplicate my problem with a
> > smaller repo; why is the local git repository bigger after running
> > git-filter-branch rather than smaller as I'd expect?  I'm probably
> > missing something obvious, but I have no idea what it is.
>
> The usual suspect would be the reflog.

The git-filter-branch documentation mentions creating refs/original
under .git.  Unfortunately, it doesn't contain any links or
documentation on how I'd clean those out and I haven't been able to
figure it out.  I asked on #git how to clean these out and got some
answers that didn't work (git branch -d and something else I don't
remember).  So...how do I fix the reflog, and then repack to have a
pack under 11MB in size?

Thanks,
Elijah
