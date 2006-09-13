From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Marking abandoned branches
Date: Wed, 13 Sep 2006 11:59:53 -0400
Message-ID: <9e4733910609130859v347a7a9ew5c3ebc982bf9b07b@mail.gmail.com>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com>
	 <20060913152451.GH23891@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 13 18:00:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNX9m-0007Ph-8a
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 18:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWIMP7z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 11:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWIMP7y
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 11:59:54 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:56509 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751013AbWIMP7y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 11:59:54 -0400
Received: by nz-out-0102.google.com with SMTP id n1so990082nzf
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 08:59:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DHmzhd8cNKEStFcdDSxWQanQCOoam9ly37gwuFj5/0UPSVye8x9xAhyomHhb6Xr9zBPTTtEmS4qb7yc75uBAj+EnSrxHQeeTL+slSg5HaCXUDhuOoPgKxfWQZCwDg61dR+sKb4TypuB/K+v+tzkdqW5rM5oR0uzodyageMMcCZE=
Received: by 10.35.51.13 with SMTP id d13mr13216886pyk;
        Wed, 13 Sep 2006 08:59:53 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Wed, 13 Sep 2006 08:59:52 -0700 (PDT)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <20060913152451.GH23891@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26917>

On 9/13/06, Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Wed, Sep 13, 2006 at 05:17:59PM CEST, I got a letter
> where Jon Smirl <jonsmirl@gmail.com> said that...
> > Abandoned branches are common in CVS since it is not distributed.
> > People start working on something in the main repo and then decide it
> > was a bad idea. In the git world these branches usually don't end up
> > in the main repo.
>
> Can't you just toss the branch away in that case? :-)

It is a historical import. Everything that was in the initial repo
needs to be preserved otherwise they aren't going to get rid of the
old CVS repo.

> You could also stash the ref to refs/heads-abandoned/ instead of
> refs/heads/ if you want to keep the junk around for some reason. Of
> course you don't get the nice marker with explanation of why is this
> abandoned and who decided that, but you can just use an empty commit for
> the same purpose.
>
> Object classes are precious things and we shouldn't get carried away.

If this is done with an object there should probably be some way to
encode it into the existing commit object.

Moving the refs into refs/abandoned would work too. We would need new
git commands to do this and flags on the visualization tools to
include the abandoned branches. On the other hand doing this is
recording state about the repository in the refs directory instead of
writing this state into the repo itself.

-- 
Jon Smirl
jonsmirl@gmail.com
