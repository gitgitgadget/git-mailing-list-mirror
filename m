From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase.txt: Mention that --whitespace cannot be used
 with interactive rebase.
Date: Thu, 12 Feb 2009 15:34:03 -0800
Message-ID: <7veiy3i61g.fsf@gitster.siamese.dyndns.org>
References: <20090212102119.1de19087@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Mark Burton <markb@ordern.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 00:36:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXl61-0006Ls-Ks
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 00:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318AbZBLXeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 18:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbZBLXeP
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 18:34:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbZBLXeO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 18:34:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F38E52B010;
	Thu, 12 Feb 2009 18:34:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 42B762B015; Thu,
 12 Feb 2009 18:34:10 -0500 (EST)
In-Reply-To: <20090212102119.1de19087@crow> (Mark Burton's message of "Thu,
 12 Feb 2009 10:21:19 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A794E2B4-F95D-11DD-ADCE-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109682>

Mark Burton <markb@ordern.com> writes:

> Signed-off-by: Mark Burton <markb@ordern.com>
> ---
>  Documentation/git-rebase.txt |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 3d6d429..60582a4 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -246,6 +246,7 @@ OPTIONS
>  --whitespace=<nowarn|warn|error|error-all|strip>::
>  	This flag is passed to the 'git-apply' program
>  	(see linkgit:git-apply[1]) that applies the patch.
> +	Not supported when using the --interactive option.

So is it "not supported when using", or "incompatible with"?

If the option is silently ignored, it is former, and we have a bug.  If
the program refuses to work then it is the latter.
