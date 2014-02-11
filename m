From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] docs/git-blame: explain more clearly the example pickaxe use
Date: Mon, 10 Feb 2014 16:21:36 -0800
Message-ID: <xmqqiosmqz1r.fsf@gitster.dls.corp.google.com>
References: <1391892097-16169-1-git-send-email-alash3@bloomberg.net>
	<1391892097-16169-4-git-send-email-alash3@bloomberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Albert L. Lash\, IV" <alash3@bloomberg.net>
To: "Albert L. Lash\, IV" <albert.lash@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 11 01:21:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WD16f-0002hn-JD
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 01:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979AbaBKAVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 19:21:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51483 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752740AbaBKAVl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 19:21:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85E746BED4;
	Mon, 10 Feb 2014 19:21:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hsxto/syy8OJDK+rpbLqEDTF9cw=; b=v9gRu/
	8E6cW9eRvuf2GzZgLq8iJx5ls9Y9zFLQKqnAY5BrkqAvM9WsEbq5MQ7AWEtM8qMm
	vlqmR0MpNBp+HxJQRlJhq1i85LW47vqENlFig6R2RGkXPH/1BWRsYgTG4KRao3HZ
	797Db4o/N775EJ9bMRvmXMwr2JJxzmqVhVjxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MJLjuTMcK+ZJ4B35Sm9S+Y2hCBnZkvmp
	LskzK97QegIBW/S9I/JkKI+6oRy4sWVl0upJ+7i2yv90bsApIrCYnfRF/A16Woq9
	WT193EeuWJgENsBJH2xLk9EoEtCRyKRy8NZpHp3LrIDpftHPT3PgFa35WHJ/sdT4
	rEzWICe8BLM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DA906BED3;
	Mon, 10 Feb 2014 19:21:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACB0F6BECB;
	Mon, 10 Feb 2014 19:21:39 -0500 (EST)
In-Reply-To: <1391892097-16169-4-git-send-email-alash3@bloomberg.net> (Albert
	L. Lash, IV's message of "Sat, 8 Feb 2014 15:41:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 79D64996-92B2-11E3-86A9-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241936>

"Albert L. Lash, IV" <albert.lash@gmail.com> writes:

> We state that the following paragraph mentions the pickaxe
> interface, but the term pickaxe is not then used. This
> change clarifies that the example command uses the pickaxe
> interface and what it is searching for.
>
> Signed-off-by: Albert L. Lash, IV <alash3@bloomberg.net>
> ---
>  Documentation/git-blame.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
> index 8e70a61..ddb88d0 100644
> --- a/Documentation/git-blame.txt
> +++ b/Documentation/git-blame.txt
> @@ -35,7 +35,8 @@ Apart from supporting file annotation, Git also supports searching the
>  development history for when a code snippet occurred in a change. This makes it
>  possible to track when a code snippet was added to a file, moved or copied
>  between files, and eventually deleted or replaced. It works by searching for
> -a text string in the diff. A small example:
> +a text string in the diff. A small example of the pickaxe interface 
> +that searches for `blame_usage`:
>  
>  -----------------------------------------------------------------------------
>  $ git log --pretty=oneline -S'blame_usage'

Thanks.

I cannot shake this nagging feeling that this and the latter half of
the previous paragraph may not belong to this page, though.

Will queue.
