From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation gitk: Describe what --merge does
Date: Sun, 27 Apr 2008 13:37:31 -0700
Message-ID: <7vlk2zf304.fsf@gitster.siamese.dyndns.org>
References: <1209311469-7561-1-git-send-email-richard.quirk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Quirk <richard.quirk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 22:38:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqDe5-0001wG-RN
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 22:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762221AbYD0Uhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 16:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763743AbYD0Uhk
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 16:37:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63197 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbYD0Uhj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 16:37:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F1FC62682;
	Sun, 27 Apr 2008 16:37:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5D8D624DE; Sun, 27 Apr 2008 16:37:34 -0400 (EDT)
In-Reply-To: <1209311469-7561-1-git-send-email-richard.quirk@gmail.com>
 (Richard Quirk's message of "Sun, 27 Apr 2008 17:51:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80485>

Richard Quirk <richard.quirk@gmail.com> writes:

> Signed-off-by: Richard Quirk <richard.quirk@gmail.com>
> ---
>  Documentation/gitk.txt |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
> index ed3ba83..edd6547 100644
> --- a/Documentation/gitk.txt
> +++ b/Documentation/gitk.txt
> @@ -41,6 +41,11 @@ frequently used options.
>  
>  	Show all branches.
>  
> +--merge::
> +
> +	Show the differences between HEAD and MERGE_HEAD for files with
> +	conflicts after a merge.
> +

Hmm. "the differences" is technically correct in that it shows the
commits on the diverged histories, but I suspect it would be more
understandable if we used more explicit wording, like:

	After an attempt to merge stops with conflicts, show the commits
	on the history between two branches (i.e. the HEAD and the
	MERGE_HEAD) that modify the conflicted files.
