From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: Add completion for git diff --base --ours --theirs
Date: Mon, 21 Apr 2008 20:04:26 -0400
Message-ID: <20080422000426.GR29771@spearce.org>
References: <20080420193247.GA21023@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Apr 22 02:06:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo61C-0000H3-3W
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 02:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756515AbYDVAEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 20:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756579AbYDVAEb
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 20:04:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60413 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756515AbYDVAEa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 20:04:30 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jo5zd-0005M6-1Q; Mon, 21 Apr 2008 20:04:17 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 18DBA20FBAE; Mon, 21 Apr 2008 20:04:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080420193247.GA21023@mithlond.arda.local>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80045>

Teemu Likonen <tlikonen@iki.fi> wrote:
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 4d81963..6949cac 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -641,6 +641,7 @@ _git_diff ()
>  			--ignore-all-space --exit-code --quiet --ext-diff
>  			--no-ext-diff
>  			--no-prefix --src-prefix= --dst-prefix=
> +			--base --ours --theirs
>  			"
>  		return
>  		;;

Hmmph.  I must not be paying enough attention to the mailing list.
I didn't know these were supported on git-diff.  Oh, wow, Linus
added these, and he never documents things.  No wonder they are
undocumented.  :)

Anyway.  Acked-by: Shawn O. Pearce <spearce@spearce.org>

But documentation would be nice too.  However I can see why you
wouldn't want to contribute that; its easy enough to insert these
flags into the completion, but its another matter to explain what
they are actually doing for you.

-- 
Shawn.
