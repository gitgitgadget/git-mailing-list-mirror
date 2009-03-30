From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: fix deleting from the context menu with empty
	selection
Date: Mon, 30 Mar 2009 07:07:50 -0700
Message-ID: <20090330140750.GU23521@spearce.org>
References: <200903291629.23736.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 30 16:10:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoIBS-0007zl-Hn
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 16:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499AbZC3OHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 10:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754175AbZC3OHw
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 10:07:52 -0400
Received: from george.spearce.org ([209.20.77.23]:46709 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbZC3OHw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 10:07:52 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4B45D38211; Mon, 30 Mar 2009 14:07:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200903291629.23736.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115151>

Markus Heidelberg <markus.heidelberg@web.de> wrote:
> An "Application Error" was raised when trying to delete text from the
> commit message field when no text was selected.

Thanks.

> diff --git a/git-gui.sh b/git-gui.sh
> index 2f1f305..b3aa732 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -2944,7 +2944,7 @@ $ctxm add command \
>  	-command {tk_textPaste $ui_comm}
>  $ctxm add command \
>  	-label [mc Delete] \
> -	-command {$ui_comm delete sel.first sel.last}
> +	-command {catch {$ui_comm delete sel.first sel.last}}
>  $ctxm add separator
>  $ctxm add command \
>  	-label [mc "Select All"] \

-- 
Shawn.
