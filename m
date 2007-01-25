From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] Hash name is SHA-1
Date: Fri, 26 Jan 2007 00:03:02 +0100
Message-ID: <20070125230302.GB13677@moooo.ath.cx>
References: <11697294071178-git-send-email-vonbrand@inf.utfsm.cl> <1169729410294-git-send-email-vonbrand@inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Fri Jan 26 00:05:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HADes-0003zM-NG
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 00:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbXAYXF1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 18:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbXAYXF1
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 18:05:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:49748 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030316AbXAYXF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 18:05:27 -0500
Received: (qmail invoked by alias); 25 Jan 2007 23:03:04 -0000
Received: from pD9EB9DDE.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.157.222]
  by mail.gmx.net (mp017) with SMTP; 26 Jan 2007 00:03:04 +0100
X-Authenticated: #5358227
Mail-Followup-To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1169729410294-git-send-email-vonbrand@inf.utfsm.cl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37775>

The patch should probably only change sha1 to SHA-1 and not reformat
the initialisation of _usage arrays or the comments (new line before
first line of comment).  If the reformatting is desired it should be a
separate patch imho.  Here is what I found:

Horst H. von Brand <vonbrand@inf.utfsm.cl> wrote:
> +head this is "refs/heads/master".  The two sha1 are the object names
> +called before the refname is updated, so either sha1-old is 0{40}
> +(meaning there is no such ref yet), or it should match what is
> +recorded in refname.
sha1 -> SHA-1?

> -static const char commit_tree_usage[] = "git-commit-tree <sha1> [-p <sha1>]* < changelog";
> +static const char commit_tree_usage[] = 
> +       "git-commit-tree <sha1> [-p <sha1>]* < changelog";
sha1 -> SHA-1?

> -static const char read_tree_usage[] = "git-read-tree (<sha> | [[-m [--aggressive] | --reset | --prefix=<prefix>] [-u | -i]] [--exclude-per-directory=<gitignore>] <sha1> [<sha2> [<sha3>]])";
> +static const char read_tree_usage[] = 
> +       "git-read-tree (<sha> | "
> +       "[[-m [--aggressive] | --reset | --prefix=<prefix>] "
> +       "[-u | -i]] [--exclude-per-directory=<gitignore>] "
> +       "<sha1> [<sha2> [<sha3>]])";
sha1 -> SHA-1, dunno what to do about the sha2 and sha3 :)
There is also a space at eol.

The following have a space at eol and/or spaces instead of tabs for
indenting.
> -	/* New file in the index: it might actually be different in
> +	/* 
> +         * New file in the index: it might actually be different in

> -	/* dst is recorded as a modification of src.  Are they so
> +	/* 
> +         * dst is recorded as a modification of src.  Are they so

> -/* We internally use unsigned short as the score value,
> +/* 
> + * We internally use unsigned short as the score value,

>   * and rely on an int capable to hold 32-bits.  -B can take
> -			/* When cloning, it is not unusual to have
> +			/* 
> +                         * When cloning, it is not unusual to have

> -	/* If there is data present from a previous transfer attempt,
> -	   resume where it left off */
> +	/* 
> +         * If there is data present from a previous transfer attempt,
> +         * resume where it left off 
> +         */

> -		/* Input is non-recursive ls-tree output format
> -		 * mode SP type SP sha1 TAB name
> +		/* 
> +                 * Input is non-recursive ls-tree output format
> +		 * mode SP type SP SHA-1 TAB name
