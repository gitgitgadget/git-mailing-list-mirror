From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: don't link to example mail addresses
Date: Sun, 16 Dec 2012 21:29:24 -0800
Message-ID: <7vobhtnt57.fsf@alter.siamese.dyndns.org>
References: <20121215150314.GC2725@river.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Dec 17 06:29:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkTGt-0002ts-Q4
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 06:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785Ab2LQF3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 00:29:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39601 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711Ab2LQF33 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 00:29:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30F8A64B8;
	Mon, 17 Dec 2012 00:29:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J+626evmG3jLhVChz8atMQ7tbqg=; b=DlP02N
	rCboe9DgTCl40gLmqQbVWH3bxuV5ITtrbU3rQV1w6YzjV1x+K+WA1rSSW9TaJssf
	JFqrF+037Aipd+gvjrOVwoTo3+qYYCqhe+KsxzbzbvKBvgSwdjaz5UjdliBfm6p8
	ebqkF7TZ3n2e5sEG9nx+Vq9dnGelK5q3kizw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N2BVjXEsDCnPU+6PJe9aPg5rqvZbDAP1
	lxHfafnsLIUoB1rb5T/uqbqxL1rhJmDlr1mcXRu+Pa+gf5AJB6S+WL9wC/afF+Gd
	/tZY+QojwJauqrKki1g/5vioOkaFiqZyczumIDkEv5tfmuIgFl9Wegby363hyuLs
	I8rVuw+MXsY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1ACC364B7;
	Mon, 17 Dec 2012 00:29:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20BCB64B6; Mon, 17 Dec 2012
 00:29:27 -0500 (EST)
In-Reply-To: <20121215150314.GC2725@river.lan> (John Keeping's message of
 "Sat, 15 Dec 2012 15:03:15 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B95EF084-480A-11E2-A21E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211632>

John Keeping <john@keeping.me.uk> writes:

> I can't see any other uses of the "$$" quote in the documentation, so
> it's probably worth noting that I've tested this with Asciidoc 8.6.8,
> although I can't see anything in the changelog to indicate that
> Asciidoc's treatment of it has changed recently.

Thanks.

>  Documentation/git-fast-import.txt | 2 +-
>  Documentation/git-tag.txt         | 2 +-
>  Documentation/mailmap.txt         | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index d1844ea..05913cc 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -427,7 +427,7 @@ they made it.
>  
>  Here `<name>` is the person's display name (for example
>  ``Com M Itter'') and `<email>` is the person's email address
> -(``cm@example.com'').  `LT` and `GT` are the literal less-than (\x3c)
> +(``$$cm@example.com$$'').  `LT` and `GT` are the literal less-than (\x3c)
>  and greater-than (\x3e) symbols.  These are required to delimit
>  the email address from the other fields in the line.  Note that
>  `<name>` and `<email>` are free-form and may contain any sequence

AsciiDoc 8.5.2 gives this:   

    asciidoc: WARNING: git-fast-import.txt: line 434: nested inline passthrough

Also in git-fast-import.1, there is this line:

    ... person\(cqs display name (for example `Com M Itter\(aq\(aq) and `<ema...

(notice two leftover `s); not that this is a new issue with this patch.

Which is puzzling, because the next input line formats better:

    ...  email address (\(lqcm@example\&.com\(rq)\&. ...

Other two hunks for git-tag and mailmap seem to give us a better
results.
