From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added documentation for few missing options.
Date: Mon, 05 Dec 2005 22:10:19 -0800
Message-ID: <7vd5ka7o38.fsf@assigned-by-dhcp.cox.net>
References: <E1EjV8R-00014y-Sg@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 07:11:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjW2L-0007FI-CS
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 07:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVLFGKX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 01:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbVLFGKW
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 01:10:22 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:60560 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750798AbVLFGKV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 01:10:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051206060906.XSWD17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Dec 2005 01:09:06 -0500
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <E1EjV8R-00014y-Sg@jdl.com> (Jon Loeliger's message of "Mon, 05
	Dec 2005 23:13:03 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13254>

Jon Loeliger <jdl@freescale.com> writes:

> More $ shell prompts in examples.
> Minor English grammar improvements.
> Added a few "See Also"s.
> Use back-ticks on more command examples.
>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>

Thanks.  You deserve to add your own name to the Documentation
section ;-).

Mostly note to myself...

> +EXAMPLES
> +--------
> +To update and refresh only the files already checked out::
> ++
> +----------------
> +$ git-checkout-index -n -f -a && git-update-index --ignore-missing --refresh
> +----------------

These days, "git-checkout-index -n -u -f -a" may a preferred
equivalent of the above.

> +OPTIONS
> +-------
> +--template=<template_directory>::
> +	Provide the directory in from which templates will be used.

? "use templates stored in the named directory" ?

> @@ -220,8 +222,8 @@ populated.  Here is an outline of how th
>      matching "stage1" entry if it exists too.  .. all the normal
>      trivial rules ..
>  
> -You would normally use "git-merge-index" with supplied
> -"git-merge-one-file" to do this last step.  The script
> +You would normally use `git-merge-index` with supplied
> +`git-merge-one-file` to do this last step.  The script
>  does not touch the files in the work tree, and the entire merge
>  happens in the index file.  In other words, there is no need to
>  worry about what is in the working directory, since it is never

The above paragraph is way out of date, as of beginning of June
2005.  The current merge-one-file does smudge the working tree
during the merge.  I'll rewrite it.
