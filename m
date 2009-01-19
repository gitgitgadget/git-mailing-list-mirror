From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: how to track multiple upstreams in one repository
Date: Sun, 18 Jan 2009 21:18:31 -0500
Message-ID: <4973E2F7.2090104@gmail.com>
References: <alpine.DEB.1.10.0901181855400.20741@asgard.lang.hm>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060400040106080405070806"
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Jan 19 03:20:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOjkE-0008WQ-Pz
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 03:20:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757022AbZASCSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 21:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758179AbZASCSk
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 21:18:40 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:11226 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758147AbZASCSi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 21:18:38 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1151748yxm.1
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 18:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type;
        bh=HmdzYCEQDyTdCl+zYQ86jiN+tpMAgVgwPM9FSJ4hBhA=;
        b=VetWaPrB5KdJyWJqwh822mNWUgyqlyXq42FlrCusSAV7btNOvc7pyNb8BSVRE2bK3Z
         lCjQ95IlYBkaHqNaTKXaA/bLJbOZdcwXZFRj+xL7ZHJjp12BLJvkCcNQIhrUzS4u1qDP
         MLUhEmi33HOKowq3AuMHzJvV5Ku7dV7pQU0Yw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type;
        b=xONQRcUsx92IetJH/1rpAko1nblR/Ge5SiDTubLogwZSvhQ0LuplXqiroMJ89zPTtQ
         rIsl3yeEcaQ1YhXYQz7pVpzBNBGnFDJLKruL0/YJ9oSiIRZommyIVLAoFUSldKzrBJu7
         lS2CezRS+3r/FNS0zEDv1QsLUwzpUY9Nd2toc=
Received: by 10.100.105.13 with SMTP id d13mr3611863anc.102.1232331517666;
        Sun, 18 Jan 2009 18:18:37 -0800 (PST)
Received: from ?10.0.0.6? (c-66-177-19-100.hsd1.fl.comcast.net [66.177.19.100])
        by mx.google.com with ESMTPS id c28sm1899724anc.5.2009.01.18.18.18.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Jan 2009 18:18:36 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <alpine.DEB.1.10.0901181855400.20741@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106304>

This is a multi-part message in MIME format.
--------------060400040106080405070806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

david@lang.hm wrote:
> for linux I want to track both the linus tree and the -stable tree. 
> Ideally I want to be able to do a checkout of tags from either tree from 
> the same directory (along with diffs between items in both trees, etc)
> 
> I have found documentation on how to clone from each of them, but I 
> haven't found any simple documentation on how to work with both of them.

Attached are what I use. It's not pretty but it's works for me; YMMV.

--------------060400040106080405070806
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

--------------060400040106080405070806
Content-Type: text/plain;
 name="fred_history"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fred_history"

export GIT_COMMITTER_NAME="@"
export GIT_AUTHOR_NAME="@"

./fred.sh git://git.kernel.org/pub/scm/git/git.git git/git

./fred.sh git://git.kernel.org/pub/scm/gitk/gitk.git gitk/gitk

./fred.sh git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/sparse.git torvalds/sparse

./fred.sh git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git torvalds/linux-2.6

./fred.sh git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.11.y.git stable/linux-2.6.11.y
./fred.sh git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.12.y.git stable/linux-2.6.12.y
./fred.sh git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.13.y.git stable/linux-2.6.13.y
./fred.sh git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.14.y.git stable/linux-2.6.14.y
./fred.sh git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.15.y.git stable/linux-2.6.15.y
./fred.sh git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git stable/linux-2.6.16.y
./fred.sh git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.17.y.git stable/linux-2.6.17.y
./fred.sh git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.18.y.git stable/linux-2.6.18.y
./fred.sh git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.19.y.git stable/linux-2.6.19.y
./fred.sh git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.20.y.git stable/linux-2.6.20.y
./fred.sh git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.21.y.git stable/linux-2.6.21.y
./fred.sh git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.22.y.git stable/linux-2.6.22.y
./fred.sh git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.23.y.git stable/linux-2.6.23.y
./fred.sh git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.24.y.git stable/linux-2.6.24.y
./fred.sh git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.25.y.git stable/linux-2.6.25.y
./fred.sh git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.26.y.git stable/linux-2.6.26.y
./fred.sh git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.27.y.git stable/linux-2.6.27.y
./fred.sh git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.28.y.git stable/linux-2.6.28.y

./fred.sh git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git tglx/history


--------------060400040106080405070806--
