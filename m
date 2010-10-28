From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 08/10] user-manual.txt: explain better the
 remote(-tracking) branch terms
Date: Thu, 28 Oct 2010 14:42:52 -0500
Message-ID: <20101028194252.GF14212@burratino>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <1288290117-6734-9-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Oct 28 21:43:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBYNp-00067l-J7
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 21:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759621Ab0J1TnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 15:43:01 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61894 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673Ab0J1TnA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 15:43:00 -0400
Received: by eye27 with SMTP id 27so1773945eye.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 12:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=GrHmC4uumzfi/kCyXBCoPnmns9x1x2hqSj6NlYPwIeU=;
        b=Oy+PLgHJfBP4u15ZsWHLsyjfrhFzQmmwV29X17CTJDsJu2WLs1H/G+n7QH/J1n99dK
         Csnlr4oBWR8q+uZqyQLmVztPRau2yRb/rHB09hIHUQ0T3DXXvKhHS5t5Of1uRAINLngk
         DxxKg6ZW/D2cIXwsAAzY15xMbgv8B/qkKrydE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QwGOPgO+M0VCI/z+731Fg+iW1q42HthXxSnO0ba5WEa74kLdSFT2LbrmPf4XVWlasc
         g2JZv/NnQ/A9Wm8u798s/eaqcKvEvxguoFn2tAuvAHl9hkpNypE3US/Ot9qQhaO6AjtN
         xAyxwkIEINRY3INrBKShBsTidKVbkIY3ummFM=
Received: by 10.213.29.145 with SMTP id q17mr9998292ebc.27.1288294978651;
        Thu, 28 Oct 2010 12:42:58 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id w20sm1069951eeh.0.2010.10.28.12.42.56
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 12:42:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1288290117-6734-9-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160215>

Matthieu Moy wrote:

> Now that the documentation is mostly consistant in the use of "remote
> branch" Vs "remote-tracking branch"

In fact, I think this patch would be useful even before the
documentation is perfectly consistent.

> , let's make this distinction explicit
> early in the user-manual.

Thanks.  It is good to maintain a clear vocabulary.

All that follows are nitpicks.

> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -341,30 +342,38 @@ $ git branch -r
>  Examining branches from a remote repository
>  -------------------------------------------
>
>  The "master" branch that was created at the time you cloned is a copy
>  of the HEAD in the repository that you cloned from.  That repository
>  may also have had other branches, though, and your local repository
>  keeps branches which track each of those remote branches, which you
>  can view using the "-r" option to linkgit:git-branch[1]:
>
>  ------------------------------------------------
>  $ git branch -r
>    origin/HEAD
>    origin/html
>    origin/maint
>    origin/man
>    origin/master
>    origin/next
>    origin/pu
>    origin/todo
>  ------------------------------------------------
>
> +In this case, "origin" is called a remote repository, or "remote" for
> +short.

"In this case" seems redundant (since we did not explain what other
case it is being opposed to).  "origin" has not been explained yet.
Maybe something along these lines (sorry for my poor wording)

 The repository of origin is called a remote repository, or a "remote" for
 short.

would improve it?

>         The branches of this repository are called "remote branches"
> +from our point of view. The remote-tracking branches are created in
> +the local repository at clone time, as a copy of the remote branches.

Sentence structure.  Maybe

          The branches of this repository are called "remote branches"
  from our point of view. The remote-tracking branches listed above
  were created based on the remote branches at clone time and will be
  updated by "git fetch" and "git push".
  See <<Updating -a-repository-With-git-fetch>> for details.

> +They are references that will be updated by "git fetch" (hence by "git
> +pull"), and by "git push". See
> +<<Updating-a-repository-With-git-fetch>> for details.
> +
>  You cannot check out these remote-tracking branches, but you can
>  examine them on a branch of your own, just as you would a tag:
>
>  ------------------------------------------------
>  $ git checkout -b my-todo-copy origin/todo
>  ------------------------------------------------
>
>  Note that the name "origin" is just the name that git uses by default
>  to refer to the repository that you cloned from.
> @@ -1716,14 +1725,19 @@ one step:
[...]
>  -------------------------------------------------
>  $ git pull
>  -------------------------------------------------
>  
> +This command will fetch the changes from the remote branches to your
> +remote-tracking branches `origin/*`, and merge default branch in the
> +current branch.
> +

Article use.  Probably something like

	s/the changes/changes/
	s/merge default branch in/merge the default branch into/

would do.
