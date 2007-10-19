From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] git-cherry-pick: improve description of -x.
Date: Fri, 19 Oct 2007 23:11:52 +0200
Message-ID: <20071019211152.GN3917@planck.djpig.de>
References: <20071019174134.GD9906@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 23:12:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iiz93-00038u-Lm
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 23:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965565AbXJSVMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 17:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbXJSVMN
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 17:12:13 -0400
Received: from planck.djpig.de ([85.10.192.180]:2798 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935337AbXJSVML (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 17:12:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id DD66688231;
	Fri, 19 Oct 2007 23:12:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dJTzjEUfapbq; Fri, 19 Oct 2007 23:12:00 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id EC7B688232; Fri, 19 Oct 2007 23:11:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071019174134.GD9906@ins.uni-bonn.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61764>

On Fri, Oct 19, 2007 at 07:41:34PM +0200, Ralf Wildenhues wrote:
> Further, I am surprised that -x seems to be nonfunctional when the
> cherry pick introduces a conflict.  Example:
[...]
> The prototype commit message now does not contain the
> | (cherry picked from commit ...).
> 
> Is that by design (because there were conflicts) or an omission?
> In case of the former, maybe the description of -x should mention this.

git commit currently doesn't know that you commit a cherry-pick. The -c
only says to use the commit message of the original commit. So this is
currently by design.

> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> index 47b1e8c..c7d83ce 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -27,10 +27,10 @@ OPTIONS
>  	message prior committing.
>  
>  -x::
> -	Cause the command to append which commit was
> -	cherry-picked after the original commit message when
> -	making a commit.  Do not use this option if you are
> -	cherry-picking from your private branch because the
> +	When recording the commit, the original commit message will
> +	be appended with a note that indicates which commit this
> +	change was cherry-picked from.  Do not use this option if
> +	you are cherry-picking from your private branch because the

Is "will be appended with" correct English? Sounds odd to me (but I'm no
native speaker, so it might be perfectly fine).

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
