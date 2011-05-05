From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/5] git-reset.txt: better docs for '--patch'
Date: Thu, 05 May 2011 12:22:15 -0700
Message-ID: <7v7ha56jh4.fsf@alter.siamese.dyndns.org>
References: <1304621271-17107-1-git-send-email-valentin.haenel@gmx.de>
 <1304621328-17184-3-git-send-email-valentin.haenel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git-List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Valentin Haenel <valentin.haenel@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 05 21:22:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI48B-00087D-0e
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 21:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab1EETW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 15:22:29 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37314 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079Ab1EETW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 15:22:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2ED02475A;
	Thu,  5 May 2011 15:24:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M2c9dJ9iXeJZRZAjFO966c4m2sA=; b=J2cb96
	Cq6ChojGZoqJ/5sbvqnFoO6tfyMrfnTMtxHUy9UdzkaEOuvPlQwQK5CYbASj8A1F
	6Uge0PKZHl5oXv0CHyPMkiTcQ3CX9majoNwnjDKHFi7cVetzB6LJucpR6dg7eo4w
	UMPekeVGmpfy47I2ZWCMNHxvzy/6A4ctjc+aA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j5sv+/CKHMd9b0EcRL23BGKISm72S5Xx
	CaMLY6LDW2bsmDd4tOZDuYXS7LyDZY1fx62KNU+4clfz3D0t4yvz2KSO2+UOCHHe
	shI7yTHUMox2KeUkkEVX1WaYxe/t2PFXNXXC/vYoQ11dICY6LQsqeDLuKuBq6VbZ
	2h0RYTTgn9E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DB05B4757;
	Thu,  5 May 2011 15:24:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 253A84755; Thu,  5 May 2011
 15:24:20 -0400 (EDT)
In-Reply-To: <1304621328-17184-3-git-send-email-valentin.haenel@gmx.de>
 (Valentin Haenel's message of "Thu, 5 May 2011 20:48:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B2726A2-774D-11E0-875C-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172886>

Valentin Haenel <valentin.haenel@gmx.de> writes:

> * Include '-p' in the synopsis.
> * Include a better wording for what 'git reset -p' does.
>   (interactively unstage hunks)
> * Include a link to the git-add manpage for a description of the patch-mode.

Yuck (just a style).

> Signed-off-by: Valentin Haenel <valentin.haenel@gmx.de>
> Helped-by: Jeff King <peff@peff.net>
> Mentored-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-reset.txt |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index 8481f9d..b6ed0c7 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -9,7 +9,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git reset' [-q] [<commit>] [--] <paths>...
> -'git reset' --patch [<commit>] [--] [<paths>...]
> +'git reset' --patch|-p [<commit>] [--] [<paths>...]

We don't say [--quiet|-q], so I am not sure if we care.  If we do, these
alternative spellings of the same thing should be marked as alternatives.

> @@ -39,8 +39,9 @@ working tree in one go.
>  	and <commit> (defaults to HEAD).  The chosen hunks are applied
>  	in reverse to the index.
>  +
> -This means that `git reset -p` is the opposite of `git add -p` (see
> -linkgit:git-add[1]).
> +This means that `git reset -p` is the opposite of `git add -p`, i.e.
> +you can use it to selectively unstage hunks. See the ``Interactive Mode''
> +section of linkgit:git-add[1] to learn how to operate the `\--patch` mode.

I would rather say "selectively reset hunks".  The reader should not have
to learn an alternative terminology to understand what it does, and in
this particular sentence, "reset a hunk" is just as understandable and
correct.  After all, you are resetting some hunks but not others to the
original state specified by the <commit>.  If <commit> happens to be HEAD,
that may be equivalent to "unstage", but otherwise it is not even a
correct description.
