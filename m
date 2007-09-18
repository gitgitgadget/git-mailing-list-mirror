From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Mention the parameters that git-pull would need to be equivalent to a --track in the git-checkout docs
Date: Tue, 18 Sep 2007 15:38:27 -0700
Message-ID: <7v3axbvbto.fsf@gitster.siamese.dyndns.org>
References: <1190077493.22387.54.camel@cacharro.xalalinux.org>
	<1190077881.22387.63.camel@cacharro.xalalinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Federico Mena Quintero <federico@novell.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 00:38:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXliK-0006oQ-Qb
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 00:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754400AbXIRWid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 18:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755625AbXIRWic
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 18:38:32 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:37241 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbXIRWic (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 18:38:32 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D9C0B137A23;
	Tue, 18 Sep 2007 18:38:50 -0400 (EDT)
In-Reply-To: <1190077881.22387.63.camel@cacharro.xalalinux.org> (Federico Mena
	Quintero's message of "Mon, 17 Sep 2007 20:11:21 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58645>

Federico Mena Quintero <federico@novell.com> writes:

> To be consistent with the git-branch docs.
>
> Signed-off-by: Federico Mena Quintero <federico@gnu.org>
> ---
>  Documentation/git-checkout.txt |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index 734928b..6f22626 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -50,7 +50,8 @@ OPTIONS
>  --track::
>  	When -b is given and a branch is created off a remote branch,
>  	set up configuration so that git-pull will automatically
> -	retrieve data from the remote branch.  Set the
> +	retrieve data from the remote branch, otherwise you'll have to
> +	use "git pull <url>" explicitly.  Set the
>  	branch.autosetupmerge configuration variable to true if you
>  	want git-checkout and git-branch to always behave as if
>  	'--track' were given.

Hmph.

I'd rather make them consistent by dropping the not-so-correct
"otherwise" phrase from all three copies.  It is not "otherwise
you'll have to", but "instead you can".
