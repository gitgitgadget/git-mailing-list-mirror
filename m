From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-branch.txt: document -f correctly
Date: Tue, 17 Mar 2009 09:37:59 -0700
Message-ID: <7vy6v4qf4o.fsf@gitster.siamese.dyndns.org>
References: <7vtz5ssk0s.fsf@gitster.siamese.dyndns.org>
 <1237298780-11304-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:39:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjcKJ-0004lI-M9
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 17:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755469AbZCQQiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 12:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753672AbZCQQiK
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 12:38:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbZCQQiI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 12:38:08 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1039F7B0D;
	Tue, 17 Mar 2009 12:38:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6253C7B0C; Tue,
 17 Mar 2009 12:38:01 -0400 (EDT)
In-Reply-To: <1237298780-11304-1-git-send-email-git@drmicha.warpmail.net>
 (Michael J. Gruber's message of "Tue, 17 Mar 2009 15:06:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FC932C12-1311-11DE-895F-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113499>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> 'git branch -f a b' resets a to b when a exists, rather then deleting a.
> Say so in the documentation.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> Something like this?
>
> BTW, I noticed that 'git-subcmd' is used everywhere in here which does
> not feel right, but I followed the existing style, leaving a consistent
> clean-up for a later patch. Also, typesetting is inconsistent:
> We have <branch> as well as `<branch>` when the text talks about the
> options. Do we have a style guide or such?
>
>  Documentation/git-branch.txt |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 6103d62..27b73bc 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -76,8 +76,8 @@ OPTIONS
>  	based sha1 expressions such as "<branchname>@\{yesterday}".
>  
>  -f::
> -	Force the creation of a new branch even if it means deleting
> -	a branch that already exists with the same name.
> +	Reset <branchname> to <startpoint> if <branchname> exists
> +	already. Without `-f` 'git-branch' refuses to change an existing branch.

And what happens if the branchname does not exist?

>  
>  -m::
>  	Move/rename a branch and the corresponding reflog.
> -- 
> 1.6.2.149.g6462
