From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: git-svn tags and branches
Date: Thu, 30 Aug 2007 13:44:35 +0200
Message-ID: <cb7bb73a0708300444q73e12d72o665a8266c2a90f61@mail.gmail.com>
References: <faulrb$483$1@sea.gmane.org> <20070830102115.GA17620@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Aug 30 13:45:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQiSR-0005Mh-Px
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 13:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755262AbXH3Loi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 07:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755215AbXH3Loi
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 07:44:38 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:23717 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755262AbXH3Loh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 07:44:37 -0400
Received: by py-out-1112.google.com with SMTP id u77so2818373pyb
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 04:44:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SfPsSrb/VHh+MxXXJFzGGQ8x95itDPfd0Z3gP++QskDVJ3nungKw21GyRv/Av2ZH72BUOhawtgPR7WEqCk94q0MVsmmUbFVr9a5pr8swCf2LmWJLZonn4rZFjZbc/hElXUU0gMrLikYhuPWvbCQDT/rdlo7RFrcWbB61H4PUY3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MZHPQr/Z7cVOvrnO7uo0hw3aOE34B5AIRX+1OVvo4X8068siJ/6u6l/qvhIsDuYFmlI+myup8WST/SNxUC5VYfmfB/TfESZcB1DU2jl3ejv3EZQWYVSXO872b+pcIBi3MoZ+4ClgH5TM4yh84STgT6/dDrWFNhZSfaKMXrayYks=
Received: by 10.35.101.1 with SMTP id d1mr519677pym.1188474276169;
        Thu, 30 Aug 2007 04:44:36 -0700 (PDT)
Received: by 10.35.43.11 with HTTP; Thu, 30 Aug 2007 04:44:35 -0700 (PDT)
In-Reply-To: <20070830102115.GA17620@muzzle>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57026>

On 8/30/07, Eric Wong <normalperson@yhbt.net> wrote:
> As noted by other repliers, SVN tags can be moving targets just like
> branches, and are treated as such by git-svn.
>
> I should note that tags in git can actually be updated like a branch
> just the same way, too, it's just not as easy to "accidentally" do.
>
> So I'll add the ability to modify refs under the refs/tags/ namespace to
> my git-svn TODO list (which is getting rather large).  I also plan to
> support branches outside of the refs/remotes/ namespace so it's easier
> to use (clone, browse from gitweb) from bare repositories.

Thank you very much, that would be very appreciated.

While we're at it: could you consider putting the svn-imported refs
not directly under remote? something like refs/remote/svn would be
rather cleaner.

> I really have a lot of catching up to do with all the new(er) things
> happening in git.  I learned git (what seems like) aeons ago have been
> more or less content with what the plumbing offered back then.  The past
> six months of my life hasn't exactly left me with a lot of time or
> energy for git, either; hopefully I'll have more time soon...

I enormously appreciate the efforts you've put into git-svn so far, it
has been quite a refreshing change from having to way eons every time
I had to commit something, while still giving me the ability to keep
my work nicely in sync with the upstream repo.

I've considered tackling these minor issues myself, but my
understanding of git's internals is most definitely not yet adequate,
so I haven't been able to do any hacking yet.

-- 
Giuseppe "Oblomov" Bilotta
