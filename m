From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Local branch to remote branch translation
Date: Sun, 11 Nov 2007 17:46:04 -0500
Message-ID: <9e4733910711111446u3e19be7ch90cf79f1d3efc3ef@mail.gmail.com>
References: <9e4733910711110954m3ed3f9adtf19ca15dff61f0@mail.gmail.com>
	 <9e4733910711111002x2f8cabf7yce263faf7b33bde1@mail.gmail.com>
	 <A1B9CE91-15E0-4298-A606-68BB31541574@zib.de>
	 <9e4733910711111136s20616468sd70b4bb19e7f3d0c@mail.gmail.com>
	 <B5C127C0-04B8-4469-B6DD-C8B5335BBA88@zib.de>
	 <9e4733910711111320u1deafe69r96d64babbb893adf@mail.gmail.com>
	 <A7871D5B-9E05-4F9B-92AC-B74ECF35460B@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 23:46:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrLZr-0008E0-JG
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 23:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757260AbXKKWqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 17:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755786AbXKKWqG
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 17:46:06 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:43894 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757260AbXKKWqF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 17:46:05 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1331870wah
        for <git@vger.kernel.org>; Sun, 11 Nov 2007 14:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=tO3kUdN9YqZdTmVrQ8jvBHgUgisWccWlxl7LbkLL6WY=;
        b=FGPvEEjsa9pR3jS4H5YBcyCkYnU1Pn4PInfd7fkkWMzQXvkh1qXWe5xUXQl9+ZOXkMNKdorxal12JTvtFXAUb52O0fqDVNDP5Tv5WDZI/j0WOykDFNliq/syRWcDtMqVXSknRaZDr7SRQ7p0i44FV8+LvzZf5Lj6yLMcchFydcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uaHg7QNxVQQXHR046F2/DYzFKfQflz0s7WK0FP8XrK5kpnbK5C2LJlnntqiLwd3o6ijtvihhuRKba8uGmAyow1iErj6pZh66wImAeQyzvWRT6pW+qE+ns92I7n5AeRHIL0mXg6/w/B7g+ETWBNG3ehpB574gf0YsBDVEvz7aYn0=
Received: by 10.114.154.1 with SMTP id b1mr1984344wae.1194821164488;
        Sun, 11 Nov 2007 14:46:04 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Sun, 11 Nov 2007 14:46:04 -0800 (PST)
In-Reply-To: <A7871D5B-9E05-4F9B-92AC-B74ECF35460B@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64532>

On 11/11/07, Steffen Prohaska <prohaska@zib.de> wrote:
>
> On Nov 11, 2007, at 10:20 PM, Jon Smirl wrote:
>
> > On 11/11/07, Steffen Prohaska <prohaska@zib.de> wrote:
> >>> jonsmirl@terra:~/mpc5200b$ git remote show linus
> >>> * remote linus
> >>>   URL: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/
> >>> linux-2.6.git
> >>>
> >>> How do I push the definition of the linus remote repo?
> >>
> >> You can't. Remotes are local to a repository. They cannot be
> >> "pushed" nor will they be "cloned" or "fetched".
> >
> > Dreamhost is way slow compared to kernel.org, so it is better to clone
> > from kernel.org first and then pull from dreamhost. What is the right
> > sequence of commands so that a new user will end up with a kernel they
> > can use 'git pull' on to get updates from dreamhost? I'll add these to
> > the repo description page.
> >
> > I'm trying this locally and I can't figure out the right sequence of
> > git command to redirect origin from kernel.org to dreamhost.
>
> How about the following (untested sequence)
>
>         mkdir linux-2.6
>         cd linux-2.6
>         git init
>         git remote add linus git://git.kernel.org/pub/scm/linux/kernel/git/
> torvalds/linux-2.6.git
>         git remote add origin ssh://jonsmirl1@git.digispeaker.com/~/
> mpc5200b.git
>         git fetch linus
>         git fetch origin
>         git checkout -b master origin/master
>
> The general idea should be correct. You have a non-standard
> setup, so avoid git-clone.

What should I do to standardize the setup so that 'clone/pull' will
work on it? I created a master branch. I gave up on fighting with
gitweb and no branch named master.

I'd like to do this, but I can't figure out how.

git clone linus
move origin to digispeaker
git pull

There doesn't seem to be a simple way to redirect the origin.

-- 
Jon Smirl
jonsmirl@gmail.com
