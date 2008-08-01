From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Add Pascal/Delphi (.pas file) funcname pattern.
Date: Fri, 1 Aug 2008 22:20:59 +0200
Message-ID: <20080801202059.GS32184@machine.or.cz>
References: <1217619915-9331-1-git-send-email-apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 22:22:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP18Z-0000Dd-22
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 22:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753618AbYHAUVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 16:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754199AbYHAUVF
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 16:21:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46542 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751043AbYHAUVE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 16:21:04 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id B99D1393A6C5; Fri,  1 Aug 2008 22:20:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1217619915-9331-1-git-send-email-apenwarr@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91090>

On Fri, Aug 01, 2008 at 03:45:15PM -0400, Avery Pennarun wrote:
> diff --git a/diff.c b/diff.c
> index cbf2547..c73ba69 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1380,6 +1380,10 @@ static struct builtin_funcname_pattern {
>  			"^[ 	]*\\(\\([ 	]*"
>  			"[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}"
>  			"[ 	]*([^;]*\\)$" },
> +	{ "pas", "\\(^\\(procedure\\|function\\|constructor\\|"
> +			"destructor\\|interface\\|implementation\\|"
> +			"type|initialization|finalization\\).*$\\)"
> +			"\\|\\(^.*=[ \t]*\\(class\\|record\\).*$\\)" },
>  	{ "tex", "^\\(\\\\\\(sub\\)*section{.*\\)$" },
>  };
>  

Wouldn't it be better to make the second pattern start on new line
instead of the outer \(\|\)?

Why "type"?

-- 
		Petr "Pasky, but not writing in Pascal anymore!" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
