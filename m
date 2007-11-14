From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Grammar fixes for gitattributes documentation
Date: Wed, 14 Nov 2007 00:55:28 -0800
Message-ID: <7vfxz9kxz3.fsf@gitster.siamese.dyndns.org>
References: <33080F0B-80C0-4860-9A74-C6878EE3B2CD@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 09:56:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsE2I-00027a-Qs
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 09:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbXKNIze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 03:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbXKNIze
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 03:55:34 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:48877 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbXKNIzd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 03:55:33 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id D5BC52EF;
	Wed, 14 Nov 2007 03:55:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 574C0944C1;
	Wed, 14 Nov 2007 03:55:52 -0500 (EST)
In-Reply-To: <33080F0B-80C0-4860-9A74-C6878EE3B2CD@wincent.com> (Wincent
	Colaiuta's message of "Wed, 14 Nov 2007 08:51:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64963>

Wincent Colaiuta <win@wincent.com> writes:

> Tweak the "filter" section of the gitattributes documentation to add
> some missing articles and improve some word choices without changing
> the semantics of the section.
>
> Signed-off-by: Wincent Colaiuta <win@wincent.com>

Thanks.

> diff --git a/Documentation/gitattributes.txt b/Documentation/
> gitattributes.txt
> index 20cf8ff..b01786b 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -148,22 +148,23 @@ with `$Id$` upon check-in.
>  `filter`
>  ^^^^^^^^
>
> -A `filter` attribute can be set to a string value.  This names
> +A `filter` attribute can be set to a string value which names a
>  filter driver specified in the configuration.

Will we get the canned "which vs that" discussion on this change?

> -A filter driver consists of `clean` command and `smudge`
> +A filter driver consists of a `clean` command and a `smudge`
>  command, either of which can be left unspecified.  Upon
> -checkout, when `smudge` command is specified, the command is fed
> +checkout, when the `smudge` command is specified, the command is fed
> -the blob object from its standard input, and its standard output
> +the blob object from its standard input, and its standard output
> -is used to update the worktree file.  Similarly, `clean` command
> +is used to update the worktree file.  Similarly, the `clean` command
> -is used to convert the contents of worktree file upon checkin.
> +is used to convert the contents of worktree file upon checkin.

I do appreciate the grammar fixes, but I needed to re-wrap and
swap lines to see the real change.  Especially, after this
re-wrapping, the updated lines with missing "the" fixed still
fit nicely below 70 columns and the right edge is not too ragged
to be distractive even for people who read unformatted text.

Could you please avoid this kind of unnecessary re-wrapping in
the future patches?
