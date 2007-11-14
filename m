From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] user-manual.txt: fix a few mistakes
Date: Tue, 13 Nov 2007 23:19:41 -0800
Message-ID: <7vlk91mgz6.fsf@gitster.siamese.dyndns.org>
References: <87bq9x7w4d.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, J Bruce Fields <bfields@citi.umich.edu>
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 08:20:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsCXl-0007uG-On
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 08:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbXKNHT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 02:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbXKNHTz
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 02:19:55 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:58881 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbXKNHTy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 02:19:54 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 598FA2FA;
	Wed, 14 Nov 2007 02:20:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C65EA9438A;
	Wed, 14 Nov 2007 02:20:09 -0500 (EST)
In-Reply-To: <87bq9x7w4d.fsf@osv.gnss.ru> (Sergei Organov's message of "Tue,
	13 Nov 2007 21:19:39 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64955>

Sergei Organov <osv@javad.com> writes:

> Signed-off-by: Sergei Organov <osv@javad.com>
> ---
>  Documentation/user-manual.txt |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index d99adc6..a169ef0 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -475,7 +475,7 @@ Bisecting: 3537 revisions left to test after this
>  If you run "git branch" at this point, you'll see that git has
>  temporarily moved you to a new branch named "bisect".  This branch
>  points to a commit (with commit id 65934...) that is reachable from
> -v2.6.19 but not from v2.6.18.  Compile and test it, and see whether
> +"master" but not from v2.6.18.  Compile and test it, and see whether
>  it crashes.  Assume it does crash.  Then:
>  
>  -------------------------------------------------

Thanks.

This hunk and the last hunk I do not have any problem with.

> @@ -1367,7 +1367,7 @@ If you make a commit that you later wish you hadn't, there are two
>  fundamentally different ways to fix the problem:
>  
>  	1. You can create a new commit that undoes whatever was done
> -	by the previous commit.  This is the correct thing if your
> +	by the old commit.  This is the correct thing if your
>  	mistake has already been made public.
>  
>  	2. You can go back and modify the old commit.  You should

But is this an improvement or just a churn?

> @@ -1567,8 +1567,8 @@ old history using, for example,
>  $ git log master@{1}
>  -------------------------------------------------
>  
> -This lists the commits reachable from the previous version of the head.
> -This syntax can be used to with any git command that accepts a commit,
> +This lists the commits reachable from the previous version of the branch.
> +This syntax can be used with any git command that accepts a commit,
>  not just with git log.  Some other examples:
>  
>  -------------------------------------------------
