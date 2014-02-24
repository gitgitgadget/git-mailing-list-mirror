From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash doc: mention short form -k in save description
Date: Mon, 24 Feb 2014 09:57:27 -0800
Message-ID: <xmqqeh2s9ywo.fsf@gitster.dls.corp.google.com>
References: <20140221172524.GA18357@sanger.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Marshall <jm18@sanger.ac.uk>
X-From: git-owner@vger.kernel.org Mon Feb 24 18:57:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHzmb-0007Fg-Px
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 18:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbaBXR5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 12:57:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57270 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752985AbaBXR5a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 12:57:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B38AD6BD11;
	Mon, 24 Feb 2014 12:57:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hxmda/eWQUijHqfgbtjoQIlsZ8c=; b=IkhMsT
	fSxQv3wTa5PKsCD6Xb9fVPm+ZBT2fxRzFLhmDKuvickXSqKGc55ucaPBRDtWNI3k
	gkv0+EkHWN69DTW9jzrO8pZeFDa5dCdnNbGW3uUZoKGXmybyOnHWkrQuIWOdxHSO
	hfD2LG3vxU3h0pcnakzdovBu0T9bHlqUxo7sM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pkmfuTOSNnWIQLDcL14JtFRomG8RGOKR
	exfn4/C6OQlCOL347q5LCLHuE5psNPTFJDTx9Kj3tSwZwt35WBoh8UTgR4QXC5IK
	V6weRTLQJ8VLfFS6KGdS8wEeUxK+ieWmO1qEVpqS2dx5GN6xc2menuwZ5CIw19EA
	zI9NK8vDjpg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B1076BD10;
	Mon, 24 Feb 2014 12:57:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C097C6BD07;
	Mon, 24 Feb 2014 12:57:28 -0500 (EST)
In-Reply-To: <20140221172524.GA18357@sanger.ac.uk> (John Marshall's message of
	"Fri, 21 Feb 2014 17:25:24 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 20338DD8-9D7D-11E3-A44A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242625>

John Marshall <jm18@sanger.ac.uk> writes:

> Document --keep-index's short form -k in both main synopsis and
> the save synopsis in the Options section.
>
> Signed-off-by: John Marshall <jm18@sanger.ac.uk>
> ---

Looks good; thanks.

> A very small documentation patch: I'd not read the main synopsis
> carefully (just skipped to the save details!) and didn't realise 
> that --keep-index had a short form...
>
>  Documentation/git-stash.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index db7e803..375213f 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -44,7 +44,7 @@ is also possible).
>  OPTIONS
>  -------
>  
> -save [-p|--patch] [--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
> +save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
>  
>  	Save your local modifications to a new 'stash', and run `git reset
>  	--hard` to revert them.  The <message> part is optional and gives
> -- 
> 1.8.3.4 (Apple Git-47)
