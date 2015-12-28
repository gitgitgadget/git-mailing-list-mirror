From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] user-manual: remove temporary branch entry from todo list
Date: Sun, 27 Dec 2015 18:41:09 -0800
Message-ID: <xmqqtwn39tx6.fsf@gitster.mtv.corp.google.com>
References: <1450918023-30309-1-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: "Stephen P. Smith" <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Mon Dec 28 03:42:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDNl9-0006XT-Tw
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 03:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbbL1Cla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Dec 2015 21:41:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65216 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750844AbbL1Cl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Dec 2015 21:41:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9BD8337F8E;
	Sun, 27 Dec 2015 21:41:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8NM31NpCZ9LuWh0uqSkQC2039WA=; b=GTEoyo
	SHSftR4EsJTCByAo6rgu0HYRZRTr1Z6eYHxol6JjPIBwxAvl8N1cBXC1W/jCMSyr
	GCkn8IcmojpfgtEwgfKp9Y6CxPs7WI1z1gWkvCwrBKszvLQus1QWMs/dvRLxqjaS
	WLA2tHKzulSdLX3y6ifjYlyD7oCiqDGDAfn60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jn9GHC0if6ww3nItRsMDaqGpJLtvAElU
	lLQ8n85N9vdmtAzK25EGiWD0Q255rCJLg8QilYC6qydVmle/z6+YBxW3L3QW/HrY
	AVpgifUcA7QkNrg4AlFTgpimab/iYN3iJLpliBuNvOB3+GrQnDNBJH03w+N1K9GT
	PRX8MqRGygQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 934E337F8D;
	Sun, 27 Dec 2015 21:41:27 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 183E137F8B;
	Sun, 27 Dec 2015 21:41:27 -0500 (EST)
In-Reply-To: <1450918023-30309-1-git-send-email-ischis2@cox.net> (Stephen
	P. Smith's message of "Wed, 23 Dec 2015 17:47:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7E13D70A-AD0C-11E5-9A19-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283026>

"Stephen P. Smith" <ischis2@cox.net> writes:

> Remove the suggestion for using a detached HEAD instead of a
> temporary branch.

That is something we can read from the patch text.  Please explain
why it is a good idea to remove it.

I can think of two completely different reasons:

 (1) Maybe the task was done some time ago, and we are seeing a
     stale todo item?

 (2) The task the todo item hints at was not done, but maybe it is
     not a good thing to do after all?

You seem to be hinting the former, but I do not think "the task was
done" is the case here.

> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> ---
>
> Notes:
>     A search of the user manual found only one location which refers to
>     temporary branches.  This has to do with how Tony Luck uses them.
>     
>     Even then there is a clarifying parenthetical noting that the
>     temporary branches are topic branches.
>     
>     A git blame showed that the last time that the entry was updated was
>     in 2007.
>
>  Documentation/user-manual.txt | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 1c790ac..18e2f1e 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -4636,9 +4636,6 @@ Scan email archives for other stuff left out
>  Scan man pages to see if any assume more background than this manual
>  provides.
>  
> -Simplify beginning by suggesting disconnected head instead of
> -temporary branch creation?
> -

What does "beginning" refer to in this sentence, though?

After a quick reading of the beginning part of the document, I am
getting the impression that it refers to the use of the 'new'
branch, which is initially created out of v2.6.13 and then later
reset to v2.6.17 while the user is in the sightseeing mode.  And
this way of working _is_ a remnant from the days back when detached
HEAD was not with us.

It is a completely separate matter if it is a good idea to teach
detached HEAD that early in the tutorial, though.  So "remove the
task because detached HEAD is a bit too weird thing to learn in that
early stage in the learning curve" (i.e. the latter reason) might
apply.
