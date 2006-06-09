From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 16:56:17 -0400
Message-ID: <9e4733910606091356w391b4fdao23db5b2ce3c3e282@mail.gmail.com>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
	 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
	 <9e4733910606091113vdc6ab06l2d3582cb82b8fd09@mail.gmail.com>
	 <Pine.LNX.4.64.0606091158460.5498@g5.osdl.org>
	 <9e4733910606091317p26d66579mdf93db293f93fb50@mail.gmail.com>
	 <Pine.LNX.4.64.0606091331170.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 09 22:56:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Foo1l-0008KP-Bs
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 22:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965290AbWFIU4S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 16:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965294AbWFIU4S
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 16:56:18 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:18169 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965290AbWFIU4R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 16:56:17 -0400
Received: by nz-out-0102.google.com with SMTP id 13so791800nzn
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 13:56:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VYD4VMHhz/RliKd+R6JK3+MOmb/eh8hC0gkBPxWmVDTRmBKB1qDv8CW+8hOPLpirjIwNwl6WmKvSUrg98nPseGpd08duuawC/ukW8ZqEoc5cCLEXX5R+ftmjzFtiYNUetgtLsovucLeJP6njHH7SITDZRpxul2vIKsSmrZfSZck=
Received: by 10.36.104.15 with SMTP id b15mr4734920nzc;
        Fri, 09 Jun 2006 13:56:17 -0700 (PDT)
Received: by 10.36.37.15 with HTTP; Fri, 9 Jun 2006 13:56:17 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606091331170.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21557>

On 6/9/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > I haven't come up with anything that is likely to result in Mozilla
> > switching over to git. Right now it takes three days to convert the
> > tree. The tree will have to be run in parallel for a while to convince
> > everyone to switch. I don't have a solution to keeping it in sync in
> > near real time (commits would still go to CVS). Most Mozilla
> > developers are interested but the infrastructure needs some help.
>
> Sure. That said, I pretty much guarantee that the size issues will be much
> much worse for any other distributed SCM.
>
> If Mozilla doesn't need the distributed thing, then SVN is probably the
> best choice. It's still a total piece of crap, but hey, if crap (==
> centralized) is what people are used to, a few billion flies can't be
> wrong ;)

They need the distributed thing whether they realize it or not. Some
of the external projects like songbird and nvu are vulnerable to drift
since they are running their own repositories.  Once a  few
move/renames happen they can't easily stay in sync anymore. It has
been over a year since NVU was merged back into the trunk.

That is the same reason I want it, so that I can work on stuff locally
and have a repository. The core staff doesn't have this problem
because they can make all the branches they want in the main
repository.

> If you got your import done, is there some place I can rsync it from, and
> at least I can make sure that everything works fine for a repo that size..
> One day the Mozilla people will notice that they really _really_ want the
> distribution, and they'll figure out quickly enough that SVK doesn't cut
> it, I suspect.

It would be better to rsync Martins copy, he has a lot more bandwidth.
It will take over a day to copy it off my cable modem. I'm signed up
to get FIOS as soon as they turn it on in my neighborhood, it's
already wired on the poles.


>
>                 Linus
>


-- 
Jon Smirl
jonsmirl@gmail.com
