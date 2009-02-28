From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] added missing backtick in git-apply.txt
Date: Sat, 28 Feb 2009 13:10:05 -0800
Message-ID: <7vy6vqe09e.fsf@gitster.siamese.dyndns.org>
References: <1235851434-16950-1-git-send-email-dt@korn.shell.la>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@uchicago.edu>
To: dt@korn.shell.la
X-From: git-owner@vger.kernel.org Sat Feb 28 22:11:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdWTM-0008JT-1l
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 22:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878AbZB1VKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 16:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752814AbZB1VKP
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 16:10:15 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39316 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718AbZB1VKO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 16:10:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 717059EA54;
	Sat, 28 Feb 2009 16:10:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2B5D39EA52; Sat,
 28 Feb 2009 16:10:06 -0500 (EST)
In-Reply-To: <1235851434-16950-1-git-send-email-dt@korn.shell.la>
 (dt@korn.shell.la's message of "Sat, 28 Feb 2009 21:03:54 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2F6E591A-05DC-11DE-8C33-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111791>

dt@korn.shell.la writes:

> From: Danijel Tasov <dt@korn.shell.la>
>
> Signed-off-by: Danijel Tasov <dt@korn.shell.la>
> ---
>  Documentation/git-apply.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> index 9400f6a..0566376 100644
> --- a/Documentation/git-apply.txt
> +++ b/Documentation/git-apply.txt
> @@ -159,7 +159,7 @@ on the command line, and ignored if there is any include pattern.
>  	considered whitespace errors.
>  +
>  By default, the command outputs warning messages but applies the patch.
> -When `git-apply is used for statistics and not applying a
> +When `git-apply` is used for statistics and not applying a
>  patch, it defaults to `nowarn`.
>  +
>  You can use different `<action>` to control this

Thanks.

This was caused by the large documentation churn 483bc4f (Documentation
formatting and cleanup, 2008-06-30) that was supposed to be a clean-up.
Can people lend eyeballs to see if there isn't any other such typo
remaining?  I briefly looked at the commit again and I think it is Ok now,
but I obviously missed this when I first applied the patch, so...
