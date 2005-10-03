From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: What to expect after 0.99.8
Date: Sun, 02 Oct 2005 20:06:07 -0700
Message-ID: <4340A01F.7040901@gmail.com>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 05:07:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMGel-0005v9-3Q
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 05:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVJCDGQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Oct 2005 23:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVJCDGQ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Oct 2005 23:06:16 -0400
Received: from qproxy.gmail.com ([72.14.204.197]:59005 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932122AbVJCDGP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Oct 2005 23:06:15 -0400
Received: by qproxy.gmail.com with SMTP id e12so373082qbe
        for <git@vger.kernel.org>; Sun, 02 Oct 2005 20:06:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ppj7sn4mudiKp0/+dcZNS1h0ti01FbW2s9EJVhRI1yH89xE++1cAxRbRtHlcG/41mmCkEWa1zwS+3PDqPHX57itzyNIZmGXNV7/RBRbnQp3QhFUz9C3GVKFWohhRkgdSpdWZgEUL8gSFvBmJCvEexmFAMtmW/xSjIrtE39nh/Co=
Received: by 10.65.112.18 with SMTP id p18mr892281qbm;
        Sun, 02 Oct 2005 20:06:13 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.171.49.207])
        by mx.gmail.com with ESMTP id f14sm2499143qba.2005.10.02.20.06.12;
        Sun, 02 Oct 2005 20:06:13 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9628>

Junio C Hamano wrote:
> As I mentioned in teh 0.99.8 announcement, let's start aiming
> for 1.0, really this time.  From now on, brown paper bags,
> bugfixes, portability fixes, usability enhancements including
> documentation updates take precedence over any new features.
> One exception area is probably merge strategy modules -- they
> are like adding new device drivers or adding new filesystem, and
> can come in anytime as long as they do not touch the coreish.
> 
> 
> The GIT To-Do File
> ==================
> 
>   The latest copy of this document is found at 
> 
>     http://kernel.org/git/?p=git/git.git;a=blob;hb=todo;f=TODO

If you were to publish the ToDo to the mailing list once a week it might 
encourage more of those patches you want to accept.

> 
...
> 
> * Maybe update tutorial with a toy project that involves two or
>   three developers..

This is *important* to have for 1.0.

> 
> * Update tutorial to cover setting up repository hooks to do
>   common tasks.

This is nice to have for 1.0.

> 
> * Accept patches to finish missing docs.

A list of missing, incomplete, and/or wrong docs in the ToDo file would 
help focus effort when people (like me) have space cycles.

> 
> * Accept patches to talk about "Whoops, it broke.  What's
>   next?".

This is *important* to have for 1.0.

> 
> * Accept patches to make formatted tables in asciidoc to work
>   well in both html and man pages (see git-diff(1)).

A Git documentation asciidoc style guide and howto would be _very_ 
useful. The current Git documentation is not all that consistent. (and I 
accept the blame for the docs I wrote)

> 
> 
> Technical (heavier)
> -------------------
...
> 
> * Maybe a pack optimizer.

Huh?

...

> 
> * Internally split the project into non-doc and doc parts; add
>   an extra root for the doc part and merge from it; move the
>   internal doc source to a separate repository, like the +Meta
>   repository; experiment if this results in a reasonable
>   workflow, and document it in howto form if it does.

I think this is a bad idea. The docs should be part of the project 
(repository and head) as the code. Otherwise, they'll become even more 
out-of-sync.

> 
...
> 
> Technical (trivial)
> -------------------
> 
...
> 
> * 'git merge-projects'?

Huh?

> 
> * 'git lost-and-found'?  Link dangling commits found by
>   fsck-objects under $GIT_DIR/refs/lost-found/.  Then
>   show-branch or gitk can be used to find any lost commit. [A
>   feeler patch sent out. Very underwhelming response X-<.]

The response may have been underwhelming but it's still a good idea.

> 
>   Do not name it /lost+found/; that would probably confuse
>   things that mistake it a mount point (not our code but
>   somebody else's).

I the this concern is overblown.

> 
...
