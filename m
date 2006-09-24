From: Santi <sbejar@gmail.com>
Subject: Re: [CFH] Remotes conversion script
Date: Mon, 25 Sep 2006 00:34:24 +0200
Message-ID: <8aa486160609241534yc78b194g64038fe22048c443@mail.gmail.com>
References: <20060924212142.GB20017@pasky.or.cz>
	 <8aa486160609241457u40fffdd8h298e44351749bb29@mail.gmail.com>
	 <20060924221644.GE13132@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 25 00:34:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRcYP-0000xC-3I
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 00:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWIXWe0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 18:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWIXWeZ
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 18:34:25 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:50500 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751289AbWIXWeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 18:34:25 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1620329wxc
        for <git@vger.kernel.org>; Sun, 24 Sep 2006 15:34:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gx+vNWw4e5RYny9OjY9odZf4ED4oLL4hLdLJVLHWKKX5tTDVur5qCXQ5dQRMEZTJSTNh6O4gLtlvjq8xVwOxG6QbwvKx9ggvkERUDJMprNzLTJ9V47Jf9XLWZYHtYbj1GkJqETE8zXsVo1JlInNygB3Pn4iQzdj5xueDLb1pvVg=
Received: by 10.70.29.2 with SMTP id c2mr5335540wxc;
        Sun, 24 Sep 2006 15:34:24 -0700 (PDT)
Received: by 10.70.19.6 with HTTP; Sun, 24 Sep 2006 15:34:24 -0700 (PDT)
To: "Petr Baudis" <pasky@ucw.cz>
In-Reply-To: <20060924221644.GE13132@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27705>

2006/9/25, Petr Baudis <pasky@ucw.cz>:
> Dear diary, on Sun, Sep 24, 2006 at 11:57:34PM CEST, I got a letter
> where Santi <sbejar@gmail.com> said that...
> > 2006/9/24, Petr Baudis <pasky@suse.cz>:
> > >  I think about supporting just the [remote] sections in Cogito since
> > >they are much easier to handle than the remotes/ file format,
> >
> > What about branches/ files?
>
> I don't know yet. Cogito will certainly *recognize* them for *long* time
> ahead (many months to be sure), no matter what will we decide to do with
> them. Of course Cogito would start being growingly critical about them.
>

It could be I'm wrong (for sure, I miss something), but I see the
branches/ files like [remote] sections files with just one fetch:

.git/branches/git:
git://...../git.gi

would be:

[remote "git"]
url=git://...../git.git
fetch=refs/heads/master:refs/heads/git

you could have a wrapper around repo-config to "support" only the
[remote]  sections.

  Santi
