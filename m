From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 05/13] Fix some typos
Date: Sat, 24 Aug 2013 22:01:59 -0700
Message-ID: <20130825050159.GH2882@elie.Belkin>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
 <1171853844.1090991.1377329328622.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, wking@tremily.us
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Aug 25 07:05:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDSWH-0000gR-Qu
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 07:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755482Ab3HYFCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 01:02:08 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:59409 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984Ab3HYFCG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 01:02:06 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so2163945pab.25
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 22:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qkpfTEYD+eMH/P0OMIfIcZu6USxw4ehEjFPCWpV5o3U=;
        b=Cthz/V4N81n8QAqXYCnEmegNvdipfg12rXEzO4EboPB+GQO+81NnexO0FJxZCaH3TL
         /8lCRAlqZd8Z9GRf1+qLS4/j84qF2b/juzTdUC0Wz9wzuM+UEBbQXdFg7ShxaJ6Dn6lU
         jHBrE0lwvQpFGG8rAI16rsCYZrIcNqQ9Opv7VLRZz/c82AOt4FCvuAG5LBGLL5mTKHhz
         1yNEeysXPNcfJ/0iRadm1tY9WmtgGAR/F674XnRRXVoSA9SH7p43GZhZ5mEqiqpInPVy
         b7Ys0dPfG2DwxXWpE02/CxiNlmP9L17ZBuMn3404El/XiCvBIBzIxoEeoAn/UzVtoS2E
         ELJA==
X-Received: by 10.66.252.129 with SMTP id zs1mr7416774pac.113.1377406924244;
        Sat, 24 Aug 2013 22:02:04 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id sb9sm179851pbb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 22:02:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1171853844.1090991.1377329328622.JavaMail.ngmail@webmail08.arcor-online.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232916>

Thomas Ackermann wrote:

> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -219,7 +219,7 @@ of development leading to that point.
>  
>  The best way to see how this works is using the linkgit:gitk[1]
>  command; running gitk now on a Git repository and looking for merge
> -commits will help understand how the Git organizes history.
> +commits will help understand how Git organizes history.

Heh.  Sure.

[...]
> @@ -793,7 +793,7 @@ e05db0fd4f31dde7005f075a84f96b360d05984b
>  -------------------------------------------------
>  
>  Or you could recall that the `...` operator selects all commits
> -contained reachable from either one reference or the other but not
> +reachable from either one reference or the other but not
>  both; so

Yes.  Here one of the references is the nickname of a remote and not a
branch, so "reachable from" reads better than "contained in" would.

> @@ -820,7 +820,7 @@ You could just visually inspect the commits since e05db0fd:
>  $ gitk e05db0fd..
>  -------------------------------------------------
>  
> -Or you can use linkgit:git-name-rev[1], which will give the commit a
> +or you can use linkgit:git-name-rev[1], which will give the commit a

I think this reads better with a capital 'O'.  (The pedant in me
likes it, too, since a colon ends a sentence.)

The lowercase 'but' later in this section should perhaps also be
capitalized, since it also starts an independent thought.

	But that may sometimes help you guess which tags come after the
	given commit.

The sentence "So, you can run something like ... then search for a
line that looks like ..." is a sequence of incomplete thoughts.  It
could be paraphrased a little to scan better:

	So, if you run something like "git show-branch e05db0fd
	v1.5.0-rc0 v1.5.0-rc1 v1.5.0-rc2"

		$ git show-branch e05db0fd v1.5.0-rc0 v1.5.0-rc1 v1.5.0-rc2
		! [e05db...

	then a line like

		+ ++ [e05db0fd] Fix warnings in ...

	shows that e05db0fd is reachable from itself, from v1.5.0-rc1,
	and from v1.5.0-rc2, and not from v1.5.0-rc0.

[...]
> @@ -3525,7 +3525,7 @@ with Git 1.5.2 can look up the submodule commits in the repository and
>  manually check them out; earlier versions won't recognize the submodules at
>  all.
>  
> -To see how submodule support works, create (for example) four example
> +To see how submodule support works, create four example

I'd keep the joke.

[...]
> @@ -3897,7 +3897,7 @@ fact that such a commit brings together ("merges") two or more
>  previous states represented by other commits.
>  
>  In other words, while a "tree" represents a particular directory state
> -of a working directory, a "commit" represents that state in "time",
> +of a working directory, a "commit" represents that state in time,
>  and explains how we got there.

It's not really about time but about (hypothetical, possibly branched)
history, but I think your change makes it about as clear as it can be.

Thanks, and hope that helps,
Jonathan
