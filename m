From: Franck <vagabon.xyz@gmail.com>
Subject: Re: [QUESTION] Access to a huge GIT repository.
Date: Tue, 22 Nov 2005 20:10:26 +0100
Message-ID: <cda58cb80511221110i3d7ea4dj@mail.gmail.com>
References: <cda58cb80511160424j1acac7c6j@mail.gmail.com>
	 <cda58cb80511190423w1e46bf5bu@mail.gmail.com>
	 <Pine.LNX.4.64.0511190953520.13959@g5.osdl.org>
	 <7vzmo04dpl.fsf@assigned-by-dhcp.cox.net>
	 <cda58cb80511211211l2ff6ff12j@mail.gmail.com>
	 <7vhda5pw6l.fsf@assigned-by-dhcp.cox.net>
	 <cda58cb80511220122r76ca69a2y@mail.gmail.com>
	 <7vfyppf1va.fsf@assigned-by-dhcp.cox.net>
	 <cda58cb80511220240u45267b18o@mail.gmail.com>
	 <7v1x18fw8j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 20:13:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EedXD-0004mZ-99
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 20:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbVKVTK2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 14:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbVKVTK1
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 14:10:27 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:38367 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965121AbVKVTK0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 14:10:26 -0500
Received: by zproxy.gmail.com with SMTP id 14so77422nzn
        for <git@vger.kernel.org>; Tue, 22 Nov 2005 11:10:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=siFvlJuNsR9o+BKHJpIWSmeO/yQ+3OyGCmZ96gkV2ocykhrB/dtTwlq654NekzJdF7OLwHofPfNwwuHysszfxF0o6822m+ojQyYNcbneOJ1UcwRBBDzQiVBSQVTaAnlfmNBaR9UO/MyfMQ2PaEfgEB6GN55nC3XmEdr1baHTnL4=
Received: by 10.36.91.13 with SMTP id o13mr1677392nzb;
        Tue, 22 Nov 2005 11:10:26 -0800 (PST)
Received: by 10.36.47.8 with HTTP; Tue, 22 Nov 2005 11:10:26 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x18fw8j.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12566>

2005/11/22, Junio C Hamano <junkio@cox.net>:
> Were you around on this list, around the beginning of this
> month?

nope, I subscribed to the list one week later.

> The thread that starts here may be of interest:
>
>         http://marc.theaimsgroup.com/?l=git&m=113089701819420
>
> I think (although I do not exactly know how the "lite"
> repository was constructed) what you are doing is similar to
> what I called "shallow clone" there in that thread.

Indeed. What I'm doing to get my "shallow clone" is basicaly remove
every ref/branchs I don't want, then run git-prune, git-repack -a -d.
But the result should be the same as your "shallow clone" method.

>  At the end
> of the thread I think I listed what you can and cannot do in
> such an incomplete repository.
>

Yes. But the big difference is that, in my case, the shallow copy is
used as a public repository, whereas in your case the shallow copy is
used as a working repository. Anyway, Ralf (the mips arch maintainer)
is going to create a new pruned repository that should resolve my
problem. I'm going to wait for it instead of trying to make my own
"broken" repository.

Thanks
--
               Franck
