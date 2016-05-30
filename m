From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: GPG capitalization
Date: Mon, 30 May 2016 11:02:01 -0700
Message-ID: <xmqqvb1vo25i.fsf@gitster.mtv.corp.google.com>
References: <01020154fd9dec3d-61772857-8b92-4505-ac0f-5058d490f7dc-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dave Nicolson <david.nicolson@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 20:02:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7RVz-0005R2-RW
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 20:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161685AbcE3SCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 14:02:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57861 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161330AbcE3SCG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 14:02:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DFA8620712;
	Mon, 30 May 2016 14:02:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H8YWRVhC24pCxYSX+QyNxAuUMyw=; b=YfmAwq
	hmUcljows/MD6ybYUpw+Q8jG7+khnTrj4i+djrTBFn/8YHBXry0yO0vPjRzYoRjM
	IQ6iZD+Dyj7l2krJarHzfaVuHCKPUoL4i3f9PG68AQXINM0nnpBYqGgRJiHr46+7
	cFI7J7hQDJCVPsChcjG7UvSxGVxRj73ku7BQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qYrF4Uc5lVZDyj7cRO7QmvEX2FD2kDzj
	/xoSMob6qMrZswEBWcpDPNFk7FJG+MSJQ4BJs7Iaxnz49Kgu7xNZJNaVqqGz9aPi
	ZEeiJuLHQyFDTNAXfnkM3K8SGsIVid2ioNLRdfnpmOA5+mNmVtlWvnsyaC25lpzM
	nrLvQHPmf5U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D74FA20711;
	Mon, 30 May 2016 14:02:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 59C7020710;
	Mon, 30 May 2016 14:02:03 -0400 (EDT)
In-Reply-To: <01020154fd9dec3d-61772857-8b92-4505-ac0f-5058d490f7dc-000000@eu-west-1.amazonses.com>
	(Dave Nicolson's message of "Sun, 29 May 2016 17:44:25 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9D1390DE-2690-11E6-88BA-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295915>

Dave Nicolson <david.nicolson@gmail.com> writes:

> When "GPG" is used in a sentence it is now consistently capitalized. When referring to the binary it is left as "gpg".
>
> Signed-off-by: David Nicolson <david.nicolson@gmail.com>
> ---
>  Documentation/git-mktag.txt         | 2 +-
>  Documentation/git-tag.txt           | 2 +-
>  Documentation/git-verify-commit.txt | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
> index fa6a756..724408d 100644
> --- a/Documentation/git-mktag.txt
> +++ b/Documentation/git-mktag.txt
> @@ -32,7 +32,7 @@ followed by some 'optional' free-form message (some tags created
>  by older Git may not have `tagger` line).  The message, when
>  exists, is separated by a blank line from the header.  The
>  message part may contain a signature that Git itself doesn't
> -care about, but that can be verified with gpg.
> +care about, but that can be verified with GPG.

Isn't this a name of the program, though?  Other two hunks in your
patch clearly refer to the concept and not to a particular program,
and they are good changes, I think.

>  
>  GIT
>  ---
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index abab481..32bc4aa 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -78,7 +78,7 @@ OPTIONS
>  
>  -v::
>  --verify::
> -	Verify the gpg signature of the given tag names.
> +	Verify the GPG signature of the given tag names.
>  
>  -n<num>::
>  	<num> specifies how many lines from the annotation, if any,
> diff --git a/Documentation/git-verify-commit.txt b/Documentation/git-verify-commit.txt
> index ecf4da1..0101f0f 100644
> --- a/Documentation/git-verify-commit.txt
> +++ b/Documentation/git-verify-commit.txt
> @@ -12,12 +12,12 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> -Validates the gpg signature created by 'git commit -S'.
> +Validates the GPG signature created by 'git commit -S'.
>  
>  OPTIONS
>  -------
>  --raw::
> -	Print the raw gpg status output to standard error instead of the normal
> +	Print the raw GPG status output to standard error instead of the normal
>  	human-readable output.
>  
>  -v::
>
> --
> https://github.com/git/git/pull/246
