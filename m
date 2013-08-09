From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] whatchanged: document its historical nature
Date: Fri, 9 Aug 2013 21:14:47 +0100
Message-ID: <20130809201447.GH2337@serenity.lan>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
 <52027B17.7040602@googlemail.com>
 <7vtxj1crv6.fsf@alter.siamese.dyndns.org>
 <CALkWK0kTfQYZG8R1EMuV37pdJ-aj9btXmfJ1Fb4QoMeZ1QucAw@mail.gmail.com>
 <vpqfvukdy39.fsf@anie.imag.fr>
 <CALkWK0kD=adWKVf+zb+Pnjz-HBkhks8ZvmQ3eYSpdXvahr=e4g@mail.gmail.com>
 <vpqvc3gcijh.fsf@anie.imag.fr>
 <7vwqnw9jv6.fsf@alter.siamese.dyndns.org>
 <7v38qi63bn.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 22:15:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7t5S-0007mk-Qy
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 22:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031011Ab3HIUO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 16:14:59 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:41253 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030954Ab3HIUO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 16:14:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 07C04198002;
	Fri,  9 Aug 2013 21:14:58 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qi4UpNLGBBXk; Fri,  9 Aug 2013 21:14:57 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id F23756064D7;
	Fri,  9 Aug 2013 21:14:49 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7v38qi63bn.fsf_-_@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232022>

On Fri, Aug 09, 2013 at 01:01:48PM -0700, Junio C Hamano wrote:
> After doing a bit of archaeology, I now know why "whatchanged" with
> an unwieldy long name persisted in the user's mindset for so long.
> 
> My conclusions are:
> 
>  - It is better to encourage new users to use `log` very early in
>    the document;
> 
>  - It is not sensible to remove the command at this point yet.
>    After having used to `log` that does not take diff options for
>    close to a year, it is understandable why there are many people
>    who are used to type `whatchanged`.
> 
> It could be argued that deprecation and retraining of fingers are
> doing favors to the long-time users.  But the presense of the
> command is not hurting anybody, other than the new people who may
> stumble upon both and wonder what their differences are.  By clearly
> indicating that these two are essentially the same, we would help
> the new people without harming anybody.
> 
> -- >8 --
> Subject: [PATCH] whatchanged: document its historical nature
> 
> Encourage new users to use 'log' instead.  These days, these
> commands are unified and just have different defaults.
> 
> 'git log' only allowed you to view the log messages and no diffs
> when it was added in early June 2005.  It was only in early April
> 2006 that the command learned to take diff options.  Because of
> this, power users tended to use 'whatchanged' that already existed
> since mid May 2005 and supported diff options.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  Documentation/git-whatchanged.txt | 41 ++++++++-------------------------------
>  1 file changed, 8 insertions(+), 33 deletions(-)
> 
> diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
> index c600b61..6faa200 100644
> --- a/Documentation/git-whatchanged.txt
> +++ b/Documentation/git-whatchanged.txt
> @@ -13,43 +13,18 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> -Shows commit logs and diff output each commit introduces.  The
> -command internally invokes 'git rev-list' piped to
> -'git diff-tree', and takes command line options for both of
> -these commands.
>  
> -This manual page describes only the most frequently used options.
> +Shows commit logs and diff output each commit introduces.
>  
> +New users are encouraged to use linkgit:git-log[1] instead.  The
> +`whatchanged` command is essentially the same as linkgit:git-log[1]
> +run with different defaults that shows a --raw diff outputat the

s/outputat/output at/

Although I wonder if it would be better to say

    New users are encouraged to use linkgit:git-log[1] instead.  The
    `whatchanged` command is essentially the same as linkgit:git-log[1]
    with the `--raw` option specified.

> +end.
>  
> -OPTIONS
> --------
> --p::
> -	Show textual diffs, instead of the Git internal diff
> -	output format that is useful only to tell the changed
> -	paths and their nature of changes.
> +The command is kept primarily for historical reasons; fingers of
> +many people who learned Git long before `git log` was invented by
> +reading Linux kernel mailing list are trained to type it.
>  
> --<n>::
> -	Limit output to <n> commits.
> -
> -<since>..<until>::
> -	Limit output to between the two named commits (bottom
> -	exclusive, top inclusive).
> -
> --r::
> -	Show Git internal diff output, but for the whole tree,
> -	not just the top level.
> -
> --m::
> -	By default, differences for merge commits are not shown.
> -	With this flag, show differences to that commit from all
> -	of its parents.
> -+
> -However, it is not very useful in general, although it
> -*is* useful on a file-by-file basis.
> -
> -include::pretty-options.txt[]
> -
> -include::pretty-formats.txt[]
>  
>  Examples
>  --------
> -- 
> 1.8.4-rc2-195-gb76a8e9
