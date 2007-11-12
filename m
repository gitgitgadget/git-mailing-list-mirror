From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Cloning from kernel.org, then switching to another repo
Date: Mon, 12 Nov 2007 10:36:42 -0500
Message-ID: <9e4733910711120736g31e3e84cx5a213afc4b889de7@mail.gmail.com>
References: <9e4733910711120557w62a9966bvb61a02a2bf9b99e9@mail.gmail.com>
	 <Pine.LNX.4.64.0711121412410.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 16:37:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrbLQ-0007kR-RP
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 16:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193AbXKLPgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 10:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbXKLPgp
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 10:36:45 -0500
Received: from nz-out-0506.google.com ([64.233.162.231]:38969 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbXKLPgo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 10:36:44 -0500
Received: by nz-out-0506.google.com with SMTP id s18so981530nze
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 07:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=WngfOmN0qILscSBno5JpIH6I9iVEkpdNxdx00A4X8iI=;
        b=Md3+p/7IEMcwYpiGMJdj8l7pKn0iZmLr8//9a4s1IefQejdalMDjsntAnUXEYj4lmXpcu3WDvw+5Vsv2Q8oIFPRIEz5ay8erwoGzccYgE6IYJx0EY+C+k2guI8KJvIMr3ERa0lqXS6l31EKpL1eIXRPkPvVRtnciavYOc87LztQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JtjInmKp/50LLisO/JnPLWcrQZPCHPLoNONlcjo2a7ssO3f9uFPxg/dYSxPlwjs+fZ0JIUa/frWvWy+PF836q8eWmxTHXMIqeBVvOyQlhJxTwHNTUh7cSLbSM6BbcVYybkwdVmedmsd34TFwJandNSjltXRBKXBOIDFy6wXskm4=
Received: by 10.115.90.1 with SMTP id s1mr181158wal.1194881802876;
        Mon, 12 Nov 2007 07:36:42 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Mon, 12 Nov 2007 07:36:42 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711121412410.4362@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64638>

On 11/12/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 12 Nov 2007, Jon Smirl wrote:
>
> > I'd like to do this sequence, but I can't figure out how without editing
> > the config file. There doesn't seem to be a simple command to move the
> > origin.
> >
> > git clone linus
> > move origin to digispeaker.git
>
> AKA "git config remote.origin.url <your-digispeaker-url-here>"

There is more to this:

jonsmirl@terra:~/foo$ git clone
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
ds
clone.....
jonsmirl@terra:~/foo/ds$ git config remote.origin.url
http://git.digispeaker.com/projects/digispeaker-kernel.git
jonsmirl@terra:~/foo/ds$ git pull
You asked me to pull without telling me which branch you
want to merge with, and 'branch.master.merge' in
your configuration file does not tell me either.  Please
name which branch you want to merge on the command line and
try again (e.g. 'git pull <repository> <refspec>').
See git-pull(1) for details on the refspec.

If you often merge with the same branch, you may want to
configure the following variables in your configuration
file:

    branch.master.remote = <nickname>
    branch.master.merge = <remote-ref>
    remote.<nickname>.url = <url>
    remote.<nickname>.fetch = <refspec>

See git-config(1) for details.
jonsmirl@terra:~/foo/ds$

>
> > git pull
>
> Hth,
> Dscho
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
