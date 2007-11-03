From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: git-svn questions: how to clone/init non-standard layout branches/tags?
Date: Sat, 3 Nov 2007 21:52:46 +0100
Message-ID: <8c5c35580711031352n3396807fm3004ebe8f86110ed@mail.gmail.com>
References: <756D5EE2-FB2C-48DB-8242-14E154E34A9C@vicaya.com>
	 <87597D7C-60FB-4CD8-BB27-7E870001A899@lrde.epita.fr>
	 <8c5c35580711030659x203f8ae8s40366c493a3eeae6@mail.gmail.com>
	 <C81F0AB6-ED04-405F-AA29-CD72816FB7B9@vicaya.com>
	 <8c5c35580711031332y4018dba6y5d24965ebf2fbefb@mail.gmail.com>
	 <8644CD78-25F0-42C4-A163-BD88528594F3@vicaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Benoit SIGOURE" <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: "Luke Lu" <git@vicaya.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 21:53:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoPzJ-0005Iu-5f
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 21:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756776AbXKCUwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 16:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757390AbXKCUwr
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 16:52:47 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:34511 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756482AbXKCUwr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 16:52:47 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1395165wah
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 13:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2WyZs/pIgIO5w7+dFcVl/KUbRa1Sy7fQqqQu3TLzjK4=;
        b=uodOSFBz4I24MGhvv9KAp5wyp/DAntGzu6aCiYorZoKz7+tB/RVnaybKMZzC5LQeQQfBfcNk3xwLXQnUQ9StPnYWW6UOdQLC95I5W8Ip1XjRJiYtXXUm9Nb94/RjSm3L/icB9c69C6vKhOQElB4Pbn57d98Ntg7z0SsXD5I+KUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XgbMaDzsIzs5xUsqCFNOrtY6hWk0gNX1wRDdovfHVLd+MKj/95t/QTDIWHP49e/oO6LG0w+3dKD0VzBTtNaQJGwm1jXvez75rLl3MPd8padh4ywch1oyan+4BdRi4FsAn6OuoCgJuHfFPDFHxs7dy7vGsri4uzY9G7hxYal/gPc=
Received: by 10.114.13.1 with SMTP id 1mr3348520wam.1194123166390;
        Sat, 03 Nov 2007 13:52:46 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sat, 3 Nov 2007 13:52:46 -0700 (PDT)
In-Reply-To: <8644CD78-25F0-42C4-A163-BD88528594F3@vicaya.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63313>

On Nov 3, 2007 9:41 PM, Luke Lu <git@vicaya.com> wrote:
> On Nov 3, 2007, at 1:32 PM, Lars Hjemli wrote:
> > On Nov 3, 2007 9:01 PM, Luke Lu <git@vicaya.com> wrote:
> >> I did try to add a "fetch" line for the production branch like this:
> >>
> >> [svn-remote "svn"]
> >>          url = svn+ssh://host/svn/project
> >>          fetch = production:refs/remotes/svn-prod
> >>          fetch = trunk:refs/remotes/git-svn
> >>
> >> which is modeled after http://lists-archives.org/git/420712-git-svn-
> >> remote-tracking-branch-question.html
> >>
> > Did you forget to run 'git svn fetch' after modifying your .git/
> > config?
>
> Yes, I did. It didn't seem to do anything.

Hmm, it works for me, I've been adding and removing branches like this
for months, but my .git/config is slightly different:

[svn-remote "svn"]
        url = svn://example.org
        fetch = project/trunk:refs/remotes/svn/trunk
        fetch = project/branches/topic:refs/remotes/svn/topic

I don't know if this difference is important, though...

-- 
larsh
