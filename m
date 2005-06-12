From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: cogito and tags propagation
Date: Sun, 12 Jun 2005 13:54:44 -0400
Message-ID: <9e473391050612105461005e3f@mail.gmail.com>
References: <9e4733910506120850f762078@mail.gmail.com>
	 <20050612174905.GA18751@tumblerings.org>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 12 19:50:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhWbG-0005OH-2y
	for gcvg-git@gmane.org; Sun, 12 Jun 2005 19:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbVFLRyx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Jun 2005 13:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbVFLRyx
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jun 2005 13:54:53 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:4412 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262663AbVFLRyo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2005 13:54:44 -0400
Received: by wproxy.gmail.com with SMTP id 69so965794wri
        for <git@vger.kernel.org>; Sun, 12 Jun 2005 10:54:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=INEQ35FLaK5EspQLDxNgQ7y/fGIqMKaX6UJn7vD7oKt81dF5Mn4pyftqbv43GaXOQASdWOpUgSdq3x3wFailtDY6UnifaXNTPlTUl9QPqd1a8Thkl9cf3k+2+z/U4vEIkan8Mv4MDjeDsYAKDog3pgLf/niOJLkYdKR+wMoaawA=
Received: by 10.54.133.3 with SMTP id g3mr2310386wrd;
        Sun, 12 Jun 2005 10:54:44 -0700 (PDT)
Received: by 10.54.94.8 with HTTP; Sun, 12 Jun 2005 10:54:44 -0700 (PDT)
To: Zack Brown <zbrown@tumblerings.org>
In-Reply-To: <20050612174905.GA18751@tumblerings.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/12/05, Zack Brown <zbrown@tumblerings.org> wrote:
> On Sun, Jun 12, 2005 at 11:50:08AM -0400, Jon Smirl wrote:
> > If I add a tag to tree A,  then go to tree B which depends on A and do
> > cg update. It says the branch is already fully merged. It's not
> > counting the addition of a tag as something that marks the tree dirty.
> 
> My impression is that tags are local to a given repo, i.e. they are not included
> by default in the publically accessible data. The repo owner has to somehow
> 'tell' people about the tags, in order for them to be able to get them.

I have a bunch of tags in my repo that have been cloned from linus. So
the tags do move through the system. But it seems that they need a
commit to make them move, apparently creating a new tag doesn't count
as a commit (and make a new tree head id).

[jonsmirl@jonsmirl .git]$ ls refs/tags
v2.6.11  v2.6.11-tree  v2.6.12-rc2  v2.6.12-rc3  v2.6.12-rc4 
v2.6.12-rc5  v2.6.12-rc6

> 
> Apparently this is useful because it allows smaller groups to work together with
> their own 'local' tags, without polluting the main tree.
> 
> Be well,
> Zack
> 
> >
> > --
> > Jon Smirl
> > jonsmirl@gmail.com
> > -
> > To unsubscribe from this list: send the line "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> Zack Brown
> 


-- 
Jon Smirl
jonsmirl@gmail.com
