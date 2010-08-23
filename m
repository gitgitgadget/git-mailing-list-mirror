From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 13/17] Documentation: remove stray backslash in show-branch discussion
Date: Mon, 23 Aug 2010 13:18:30 +0200
Message-ID: <201008231318.30768.trast@student.ethz.ch>
References: <20100820101902.GA10356@burratino> <20100820103706.GM10407@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Ramkumar Ramachandra <artagnon@gmail.com>,
	=?iso-8859-1?q?Fr=E9d=E9ric_Bri=E8re?= <fbriere@fbriere.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 13:18:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnV34-000105-6U
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 13:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869Ab0HWLSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 07:18:36 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:57949 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751666Ab0HWLSe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 07:18:34 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 23 Aug
 2010 13:18:34 +0200
Received: from thomas.site (129.132.246.171) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.0.702.0; Mon, 23 Aug
 2010 13:18:32 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <20100820103706.GM10407@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154215>

Jonathan Nieder wrote:
> diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
> index 81ba296..01fc157 100644
> --- a/Documentation/git-show-branch.txt
> +++ b/Documentation/git-show-branch.txt
> @@ -168,7 +168,7 @@ $ git show-branch master fixes mhf
>  ------------------------------------------------
>  
>  These three branches all forked from a common commit, [master],
> -whose commit message is "Add \'git show-branch\'". The "fixes"
> -branch adds one commit "Introduce "reset type" flag to "git reset"".
> -The "mhf" branch adds many other commits. The current branch
> -is "master".
> +whose commit message is "Add {apostrophe}git show-branch{apostrophe}".
> +The "fixes" branch adds one commit "Introduce "reset type" flag to
> +"git reset"". The "mhf" branch adds many other commits.
> +The current branch is "master".

What does this apply on?  I tried 'git am -3' but it says

  Applying: Documentation: remove stray backslash in show-branch discussion
  Using index info to reconstruct a base tree...
  error: patch failed: Documentation/git-show-branch.txt:168
  error: Documentation/git-show-branch.txt: patch does not apply
  Did you hand edit your patch?
  It does not apply to blobs recorded in its index.
  Cannot fall back to three-way merge.
  Patch failed at 0013 Documentation: remove stray backslash in show-branch discussion

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
