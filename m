From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: irc usage..
Date: Wed, 31 May 2006 13:04:46 +1200
Message-ID: <46a038f90605301804u3beabf4ct97c8a0ea6ef7b995@mail.gmail.com>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>
	 <Pine.LNX.4.64.0605221234430.3697@g5.osdl.org>
	 <447215D4.5020403@gentoo.org>
	 <Pine.LNX.4.64.0605221312380.3697@g5.osdl.org>
	 <447231C4.2030508@gentoo.org> <447B6D85.4050601@gentoo.org>
	 <46a038f90605291521q37f34209wd923608bdebb9084@mail.gmail.com>
	 <447B7669.8050805@gentoo.org>
	 <46a038f90605301531g4f8b37c7qab9a717833c64ebc@mail.gmail.com>
	 <Pine.LNX.4.64.0605301604130.24646@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Donnie Berkholz" <spyderous@gentoo.org>,
	"Yann Dirson" <ydirson@altern.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Matthias Urlichs" <smurf@smurf.noris.de>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 31 03:04:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlF8l-0006aw-1Y
	for gcvg-git@gmane.org; Wed, 31 May 2006 03:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbWEaBEr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 21:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbWEaBEr
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 21:04:47 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:58674 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932551AbWEaBEq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 21:04:46 -0400
Received: by wr-out-0506.google.com with SMTP id 37so122448wra
        for <git@vger.kernel.org>; Tue, 30 May 2006 18:04:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OzPE4EWjgKgHvvOQSwNucgX/Mi2mjHGeO6q+KJSP4mIqJObb3ARR6ut7Mom54zGPbNzPKdoOhxy+qePyXl7t9i0p7jg35PeWw8/4SfCkhjmZEIJr0IvBL8v9iECzS9niyp5G6OAipdDLFDBMeC34gU2AiZB7UCw2uwTC9MJNRaY=
Received: by 10.54.135.7 with SMTP id i7mr957632wrd;
        Tue, 30 May 2006 18:04:46 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Tue, 30 May 2006 18:04:46 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605301604130.24646@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21052>

On 5/31/06, Linus Torvalds <torvalds@osdl.org> wrote:
> On Wed, 31 May 2006, Martin Langhoff wrote:
> >
> >  gitview
> >  http://git.catalyst.net.nz/gitweb?p=gentoo.git;a=summary
>
> Heh. I think you should enable caching in your apache config.

I know I should -- but I'm hoping to find the time to rework gitweb a
bit to actually work fast instead. It bothers me that it is so slow on
a basically idle machine, and where I can perform the corresponding
git operations in the commandline in a blink.

And caching is great for really busy sites (aka kernel.org) but
git.catalyst.net.nz only serves a handful of small repos for a small
group of people, and is 99% idle. Should blaze through this stuff.

> That gentoo repo has a lot of "duplicate" commits that cvsps will mark as
> two separate commits because there's one commit for the files, and one
> commit for whatever the "Manifest" file is. I wonder if those commits
> should generally be merged or something.
>
> That said, things like that are most easily fixed as a git->git update
> (along with adding name translation), which can avoid re-writing the
> trees.

Yep, large projects often have good reasons to run custom imports,
merging certain commits, rewriting log messages (like the X.org guys
were doing). It can be done at the cvsimport stage or later -- I think
Pasky has a rewritehistory tool hidden somewhere in Cogito, but I
haven't used it.

cheers,


martin
