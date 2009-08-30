From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-add.txt: Explain --patch option in
 layman terms
Date: Sun, 30 Aug 2009 13:14:24 -0700
Message-ID: <7vab1hdppb.fsf@alter.siamese.dyndns.org>
References: <87ocpxb46g.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sun Aug 30 22:14:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhqnR-0006BF-P6
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 22:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027AbZH3UOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 16:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754005AbZH3UOc
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 16:14:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57338 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753923AbZH3UOc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 16:14:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D3AD13D453;
	Sun, 30 Aug 2009 16:14:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=cQ/nvl7sC2fIZBBAoizWaO64u0w=; b=GuMyOsLSuaIS2zEMmEBJE8t
	abU3+vFcuFeCyib8iWPexrBGjtqAIGOAcwrg4dpd0FN2YZFcGCCBZ9GMWjqCY+do
	lUOPffSezfbqWCp+R8ERFd7WEz6vH/TDWJqZM09y0m3Y/TDHaqxsLpBptgOJDxVN
	Y+ZPkCO2rwfrlIA/iR5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=MMcMwj5UDn2OELRGdiMWZTtE1eiv5h5aJXyy9JA63NoTXOjc5
	BeabijJOSTzi7ONBW1vyOqf7v3e7nzXyDfD0vYMIFvSUGusscemwe0uklcJmmS/L
	P9nAkuAjrgviXP9hN7tGXu7SE6ziiDTJSTgF/KSkhXctpsZ4ekKyR+CRRE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B55213D452;
	Sun, 30 Aug 2009 16:14:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9E03A3D451; Sun, 30 Aug 2009
 16:14:27 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B9C9A808-95A1-11DE-BE99-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127426>

Jari Aalto <jari.aalto@cante.net> writes:

> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
> ---
>  Documentation/git-add.txt |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index e67b7e8..71990c2 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -67,14 +67,14 @@ OPTIONS
>  --interactive::
>  	Add modified contents in the working tree interactively to
>  	the index. Optional path arguments may be supplied to limit
> -	operation to a subset of the working tree. See ``Interactive
> -	mode'' for details.
> +	operation to a subset of the working tree. See section
> +	``INTERACTIVE MODE'' for details.

Sorry, the change in this hunk does not make *any* sense to me.

It is not justified with your commit log message, I do not see why you
have to shout in all CAPS, and there is no such section in the
documentation.  But the "Interactive mode" section exists and is referred
to by the original.

>  -p::
>  --patch::
> -	Similar to Interactive mode but the initial command loop is
> -	bypassed and the 'patch' subcommand is invoked using each of
> -	the specified filepatterns before exiting.
> +	Run interactive patch command for each file on command line.
> +	See section INTERACTIVE MODE and patch subcommand for more
> +	information.

I personally think fixing misworded phrase "initial command loop" would be
sufficient.  It should read "initial command menu".  Perhaps like this.

	Run ``add --interactive``, but bypass the initial command menu and
	directly jump to `patch` subcommand.  See ``Interactive mode'' for
	details.

If you assume that the reader is not familiar with "add -i", then the
above is not descriptive enough, but "Run interactive patch command" is
not an improvement either.  We would need a description of "what it is
used for" before "how it would look to you" (i.e.. my rewrite shown
above).

"What it is used for" would perhaps read like this.

	Review the difference between the index and the work tree, and add
	modified contents to the index interactively by choosing which
	patch hunks to use.
