From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Consistent usage of working tree in the git-add help
Date: Wed, 20 Jan 2016 16:24:53 -0800
Message-ID: <xmqqr3hb22zu.fsf@gitster.mtv.corp.google.com>
References: <1453229636-16269-1-git-send-email-Lars.Vogel@vogella.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Lars Vogel <Lars.Vogel@vogella.com>
To: Lars Vogel <lars.vogel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 01:25:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM33c-0004Ew-Gz
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 01:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbcAUAY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 19:24:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54560 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750894AbcAUAY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 19:24:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A7B4E3E0C9;
	Wed, 20 Jan 2016 19:24:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ScNE67gvfv79pdjtdwbvKO9TgrU=; b=UzOflx
	IF8R59UTz3PJJFu1ulhXQS4Zdf1R2vVc+ldG9+2lRxzWuPFbtzckKy6/MsMwzTEz
	KjiFn+1e5fhgELdyMG6iCsEy3klnymoLhqr+nB2Wa3PXgKywWcYcC9EOGysoxOaa
	Fo9lv05tcIgFCDvgnt1FGsawjWy44v1V7tk5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Eb7/U40cjcdc0pJIYWGcOJrAvVXSADkc
	oiiXpXV5xX5L/DWcj4WEPytUg/AM1i/XoBuqrksNka0p2b4dgypbIzpqtqBji4KP
	n7SQqNQdnvz7yGkLpbo0UjNk3u+1pijPTbUZytjes9FtsVZSUUMmhDquxq+ZokPq
	mTGJ60ha3fg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9E9323E0C8;
	Wed, 20 Jan 2016 19:24:55 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 24ED43E0C7;
	Wed, 20 Jan 2016 19:24:55 -0500 (EST)
In-Reply-To: <1453229636-16269-1-git-send-email-Lars.Vogel@vogella.com> (Lars
	Vogel's message of "Tue, 19 Jan 2016 19:53:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6535C172-BFD5-11E5-93D6-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284493>

Lars Vogel <lars.vogel@gmail.com> writes:

> The usage of working directory is inconsistent in the git add help.
> Also http://git-scm.com/docs/giit-clone speaks only about working tree.
> Remaining entry found by "git grep -B1 '^directory' git-add.txt" really
> relates to a directory.
>
> Signed-off-by: Lars Vogel <Lars.Vogel@vogella.com>
> ---
>  Documentation/git-add.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index fe5282f..cfef77b 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -24,7 +24,7 @@ remove paths that do not exist in the working tree anymore.
>  
>  The "index" holds a snapshot of the content of the working tree, and it
>  is this snapshot that is taken as the contents of the next commit.  Thus
> -after making any changes to the working directory, and before running
> +after making any changes to the working tree, and before running
>  the commit command, you must use the `add` command to add any new or
>  modified files to the index.
>  
> @@ -85,7 +85,7 @@ OPTIONS
>  -p::
>  --patch::
>  	Interactively choose hunks of patch between the index and the
> -	work tree and add them to the index. This gives the user a chance
> +	working tree and add them to the index. This gives the user a chance
>  	to review the difference before adding modified contents to the
>  	index.
>  +

Thanks.  While the first hunk looks to me a definite improvement, I
am lukewarm about s/work tree/working tree/ change.  Both terms are
used fairly commonly in our documentation set.  "Work tree" has ~70
hits vs ~350 for "working tree" (ignoring the case where these words
are split across lines, i.e. "work/working" at the end of the line
followed by a line that begins with "tree").
