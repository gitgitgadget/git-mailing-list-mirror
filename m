From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Local branch to remote branch translation
Date: Mon, 12 Nov 2007 08:53:34 -0500
Message-ID: <9e4733910711120553r6b7e887eke3978c04b2f0b0c4@mail.gmail.com>
References: <9e4733910711110954m3ed3f9adtf19ca15dff61f0@mail.gmail.com>
	 <9e4733910711111002x2f8cabf7yce263faf7b33bde1@mail.gmail.com>
	 <A1B9CE91-15E0-4298-A606-68BB31541574@zib.de>
	 <9e4733910711111136s20616468sd70b4bb19e7f3d0c@mail.gmail.com>
	 <B5C127C0-04B8-4469-B6DD-C8B5335BBA88@zib.de>
	 <9e4733910711111320u1deafe69r96d64babbb893adf@mail.gmail.com>
	 <A7871D5B-9E05-4F9B-92AC-B74ECF35460B@zib.de>
	 <9e4733910711111446u3e19be7ch90cf79f1d3efc3ef@mail.gmail.com>
	 <1310ED7B-9DA5-47EC-8523-F609A1866384@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 14:53:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrZjd-0005at-WA
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 14:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758380AbXKLNxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 08:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758357AbXKLNxi
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 08:53:38 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:20795 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758167AbXKLNxh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 08:53:37 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1533022wah
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 05:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=n+XDfRZvsgvxOWlq19iX3Zf3e7VS8WvwbOMdgneTcDk=;
        b=bOrpViw07ST7hjRJDQNDJlrwxKhzXkxgEptrpzRGGZnsDNDjiLYVXb0a8uxbOZLpzMd+/swwPudfInwS5hBmS9PlZoPnXWCDnoO08llsj6dGFcuF1zY9fz7kMt2Qp6cAhd3H83eGPv5+jK8Nw+Yo73hLDjptadaDgrHGQ8TpUT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qq4Ej8ziHHorQPXbbJIM1s8yldm/IZuz5x0kr/dCjvewtipqgs+8n/4sWjms6XLkXLZpGiNn6+k4rCWoYVqVj3KqbnrVXKR3VMZm7Sw/Kpx1iUbspphd1HdYdlWUWBRrFkR07bprsno6vB9SyWUrc/Iy2iEtevT9X2JQTeZNFNs=
Received: by 10.114.53.1 with SMTP id b1mr37138waa.1194875614842;
        Mon, 12 Nov 2007 05:53:34 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Mon, 12 Nov 2007 05:53:34 -0800 (PST)
In-Reply-To: <1310ED7B-9DA5-47EC-8523-F609A1866384@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64620>

On 11/12/07, Steffen Prohaska <prohaska@zib.de> wrote:
>
> On Nov 11, 2007, at 11:46 PM, Jon Smirl wrote:
>
> > On 11/11/07, Steffen Prohaska <prohaska@zib.de> wrote:
> >>
> >> On Nov 11, 2007, at 10:20 PM, Jon Smirl wrote:
> >>
> >>> On 11/11/07, Steffen Prohaska <prohaska@zib.de> wrote:
> >>>>> jonsmirl@terra:~/mpc5200b$ git remote show linus
> >>>>> * remote linus
> >>>>>   URL: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/
> >>>>> linux-2.6.git
> >>>>>
> >>>>> How do I push the definition of the linus remote repo?
> >>>>
> >>>> You can't. Remotes are local to a repository. They cannot be
> >>>> "pushed" nor will they be "cloned" or "fetched".
> >>>
> >>> Dreamhost is way slow compared to kernel.org, so it is better to
> >>> clone
> >>> from kernel.org first and then pull from dreamhost. What is the
> >>> right
> >>> sequence of commands so that a new user will end up with a kernel
> >>> they
> >>> can use 'git pull' on to get updates from dreamhost? I'll add
> >>> these to
> >>> the repo description page.
> >>>
> >>> I'm trying this locally and I can't figure out the right sequence of
> >>> git command to redirect origin from kernel.org to dreamhost.
> >>
> >> How about the following (untested sequence)
> >>
> >>         mkdir linux-2.6
> >>         cd linux-2.6
> >>         git init
> >>         git remote add linus git://git.kernel.org/pub/scm/linux/
> >> kernel/git/
> >> torvalds/linux-2.6.git
> >>         git remote add origin ssh://jonsmirl1@git.digispeaker.com/~/
> >> mpc5200b.git
> >>         git fetch linus
> >>         git fetch origin
> >>         git checkout -b master origin/master
> >>
> >> The general idea should be correct. You have a non-standard
> >> setup, so avoid git-clone.
> >
> > What should I do to standardize the setup so that 'clone/pull' will
> > work on it?
>
> Pull should work after you checked out origin/master. Pull should
> fetch from origin and merge to local master.
>
> But I don't see a way how you could use clone for your setup.
>
>
> > I created a master branch. I gave up on fighting with
> > gitweb and no branch named master.
>
> I don't understand your comment about gitweb.

At http://git.digispeaker.com/
The short log, log, tree links won't work unless master exists.
Once master is there, everything works.


>
>
> > I'd like to do this, but I can't figure out how.
> >
> > git clone linus
> > move origin to digispeaker
> > git pull
> >
> > There doesn't seem to be a simple way to redirect the origin.
>
> I don't know a simple way.
>
>         Steffen
>
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
