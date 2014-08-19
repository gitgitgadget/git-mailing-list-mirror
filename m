From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH] Documentation/git-rebase.txt: fix -f description to match actual git behavior.
Date: Tue, 19 Aug 2014 14:05:06 +0400
Message-ID: <87oavg6bhp.fsf@osv.gnss.ru>
References: <87bnrq22uf.fsf@osv.gnss.ru>
	<xmqq4mxh5w34.fsf@gitster.dls.corp.google.com>
	<xmqqzjf94f5n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 12:05:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJgI2-0008Iz-1M
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 12:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbaHSKFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 06:05:09 -0400
Received: from mail.javad.com ([54.86.164.124]:55876 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752217AbaHSKFI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 06:05:08 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id E50A261856;
	Tue, 19 Aug 2014 10:05:07 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1XJgHq-0001lM-7n; Tue, 19 Aug 2014 14:05:06 +0400
In-Reply-To: <xmqqzjf94f5n.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 12 Aug 2014 13:38:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255451>

Junio C Hamano <gitster@pobox.com> writes:
> Junio C Hamano <gitster@pobox.com> writes:
[...]
> How about doing it this way, perhaps?

Could you please apply this your suggestion, as we seem not to agree
on anything better?

> -- >8 --
> From: Sergey Organov <sorganov@gmail.com>
> Date: Tue, 12 Aug 2014 00:22:48 +0400
> Subject: [PATCH] Documentation/git-rebase.txt: -f forces a rebase that would otherwise be a no-op
>
> "Current branch is a descendant of the commit you are rebasing onto"
> does not necessarily mean "rebase" requires "--force".  For a plain
> vanilla "history flattening" rebase, the rebase can be done without
> forcing if there is a merge between the tip of the branch being
> rebased and the commit you are rebasing onto, even if the tip is
> descendant of the other.
>
> [jc: reworded both the text and the log description]
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-rebase.txt | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 2a93c64..f14100a 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -316,11 +316,8 @@ which makes little sense.
>  
>  -f::
>  --force-rebase::
> -	Force the rebase even if the current branch is a descendant
> -	of the commit you are rebasing onto.  Normally non-interactive rebase will
> -	exit with the message "Current branch is up to date" in such a
> -	situation.
> -	Incompatible with the --interactive option.
> +	Force a rebase even if the current branch is up-to-date and
> +	the command without `--force` would return without doing anything.
>  +
>  You may find this (or --no-ff with an interactive rebase) helpful after
>  reverting a topic branch merge, as this option recreates the topic branch with

--  
Sergey.
