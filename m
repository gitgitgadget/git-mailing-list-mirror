From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Added --mirror-all to git-fetch.
Date: Wed, 20 Sep 2006 11:42:30 -0700
Message-ID: <45118B96.1080207@gmail.com>
References: <20060919232851.GA12195@spearce.org>	<7vac4ujzf0.fsf@assigned-by-dhcp.cox.net>	<20060920161407.GQ8259@pasky.or.cz>	<20060920162145.GA23260@spearce.org>	<7v1wq6jy3q.fsf@assigned-by-dhcp.cox.net>	<20060920164912.GD23260@spearce.org>	<7vac4uihr3.fsf@assigned-by-dhcp.cox.net>	<20060920173126.GG23260@spearce.org> <7vu032h1g1.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080502040603030700090503"
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Sep 20 20:43:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ71z-0007g4-Jj
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 20:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWITSmo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 14:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWITSmo
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 14:42:44 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:24589 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932233AbWITSmn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 14:42:43 -0400
Received: by wx-out-0506.google.com with SMTP id s14so371475wxc
        for <git@vger.kernel.org>; Wed, 20 Sep 2006 11:42:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=p0ZJVYKRHYban9/GUV/Fvomf+xPPD4sMSpG8YXoklhB7gFSZ7WoBEK+4jSU0chdsJtL2t/HAseMz6R613XWmdDq6pN6lt7olc1GOSyq2kgmsB8laq9Jcl/GUC8HNUfEW40O0WuoI/87oou/wiu3Q8MOJscdLl8COsmNRr0Tj0RA=
Received: by 10.70.108.18 with SMTP id g18mr25263780wxc;
        Wed, 20 Sep 2006 11:42:42 -0700 (PDT)
Received: from ?10.0.0.6? ( [67.20.86.89])
        by mx.gmail.com with ESMTP id i36sm1741182wxd.2006.09.20.11.42.41;
        Wed, 20 Sep 2006 11:42:41 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu032h1g1.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27392>

This is a multi-part message in MIME format.
--------------080502040603030700090503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
[...]
> 
> Another possibility.  The mirror might want to do something
> like:
> 
>         .git/refs/remotes/davem/sparc-2.6.git/...
> 	.git/refs/remotes/torvalds/linux-2.6.git/...
> 	.git/refs/remotes/jgarzik/netdev-2.6.git/...
> 
> to be a super-mirror of related projects.  This would give a
> convenient way for the visitors to browse them all at one place,
> and would save object store.  There are minor details such as
> gitweb may not allow browsing refs/remotes and git-fetch may not
> let you fetch from refs/remotes (I haven't checked), but they
> are fixable as needed.
> 

This is what I do with the 2 attached, poorly named, scripts. Very 
convenient for watching some of my favorite projects. ;-)

--------------080502040603030700090503
Content-Type: application/x-shellscript;
 name="fred.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="fred.sh"

IyEvYmluL3NoCgpyZXA9JDEKd2hvPSQyCgojZ2l0LWZldGNoIC0tbm8tdGFncyAkcmVwICQo
Z2l0LWxzLXJlbW90ZSAkcmVwCQkJCQlcCiMJCXwgc2VkCS1lICdzL14uKgkvLycJCQkJCVwK
IwkJCS1lICcvXF4vZCcJCQkJCQlcCiMJCQktZSAnczteXChcKHJlZnMvW14vXSovXClcKC4q
XClcKSQ7KyY6XDInIiR3aG8iJy9cMzsnCVwKIwkJCS1lICcvXityZWZzXC8vcCcJCQkJCVwK
IwkJCS1lIGQKIwkJKQoKZ2l0LWZldGNoIC1mIC11IC0tbm8tdGFncyAkcmVwICQoZ2l0LWxz
LXJlbW90ZSAkcmVwCQkJCVwKCQl8IHNlZAktZSAncy9eLioJLy8nCQkJCQlcCgkJCS1lICcv
XF4vZCcJCQkJCQlcCgkJCS1lICdzO15cKFwocmVmcy9bXi9dKi9cKVwoLipcKVwpJDsmOlwy
JyIkd2hvIicvXDM7JwlcCgkJCS1lICcvXnJlZnNcLy9wJwkJCQkJCVwKCQkJLWUgZAoJCSkK

--------------080502040603030700090503
Content-Type: text/plain;
 name="fred_history"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fred_history"

export GIT_COMMITTER_NAME="@"
export GIT_AUTHOR_NAME="@"

./fred.sh git://www.kernel.org/pub/scm/git/git.git git/git

./fred.sh git://www.kernel.org/pub/scm/gitk/gitk.git gitk/gitk

./fred.sh git://www.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.11.y.git stable/linux-2.6.11.y
./fred.sh git://www.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.12.y.git stable/linux-2.6.12.y
./fred.sh git://www.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.13.y.git stable/linux-2.6.13.y
./fred.sh git://www.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.14.y.git stable/linux-2.6.14.y
./fred.sh git://www.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.15.y.git stable/linux-2.6.15.y
./fred.sh git://www.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git stable/linux-2.6.16.y
./fred.sh git://www.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.17.y.git stable/linux-2.6.17.y

./fred.sh git://www.kernel.org/pub/scm/linux/kernel/git/tglx/history.git tglx/history

./fred.sh git://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git torvalds/linux-2.6
./fred.sh git://www.kernel.org/pub/scm/linux/kernel/git/torvalds/sparse.git torvalds/sparse

--------------080502040603030700090503--
