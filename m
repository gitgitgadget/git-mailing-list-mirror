From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 0/3] git-daemon: plug new upload-tar command
Date: Sat, 2 Sep 2006 10:14:50 +0200
Message-ID: <cda58cb80609020114h1e1ee553saf5aa90df8bc3ba0@mail.gmail.com>
References: <11570277231100-git-send-email-vagabon.xyz@gmail.com>
	 <44F72039.3040206@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 10:15:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJQeW-0004WB-Ay
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 10:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWIBIOx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 04:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWIBIOx
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 04:14:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:19908 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750838AbWIBIOw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 04:14:52 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1115029ugc
        for <git@vger.kernel.org>; Sat, 02 Sep 2006 01:14:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JkyHBD5X1a9GV2mInZfyGGJXHT0OcN6uiymHc3wrG5lMnWu/IiB+Wj74rh+GZrINMsnE3WCvecls3bqpQWjggv5VYNEz1DaIn3CdyPXFbX7OS60qJi67Onr9NTDIA82HHVnfNFv+uNS7KQXC/7l5B7u4LXe+Iykv+zDLJmTKkK8=
Received: by 10.67.22.2 with SMTP id z2mr1655372ugi;
        Sat, 02 Sep 2006 01:14:50 -0700 (PDT)
Received: by 10.67.95.4 with HTTP; Sat, 2 Sep 2006 01:14:50 -0700 (PDT)
To: "Rene Scharfe" <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <44F72039.3040206@lsrfire.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26322>

Hi,

2006/8/31, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>:
> Junio has similar code in the 'next' branch.  And he correctly pointed

duh, wasn't aware of it. :(

> out that with the arrival of git-zip-tree the time has come to think
> about a format independent tree-to-archive converter command to avoid
> re-implementing essentially the same thing under the names of
> git-upload-zip, git-upload-rar etc.
>

That would make sense if you're going to implement any possible
archive formats ;)

> I'm trying for a few days now to find time for implementing a
> git-archive command, but I'm failing.  And I won't be able to do so
> before the weekend (at least).
>
> I propose to make the command line syntax more similar to the one of
> git-ls-tree (e.g. --prefix instead of optional second non-option
> parameter for base dir, support for path specs).  In a previous mail I
> also proposed to merge the upload command into git-archive, but now that
> I thought a bit about it it doesn't make sense to me anymore.
>

Maybe it's time for a "upload-archive" that would implement a common
git archiver protocol used by all git-{zip,tar,..}-tree. And by that
time move git-tar-tree protocol stuff into git-archive.

> So if you beat me to it, that would be great.  Or if you have a better
> idea, that would be also great. :-)
>

Well I'll try to start something, not sure to have a lot of time
though. Please contact me before starting anything, I would be sad to
write something for /dev/null again ;)

One point would make git-tar-tree able to compress data and git-daemon
would refuse any requests for a non compressed archive format.

-- 
               Franck

-- 
VGER BF report: U 0.499999
