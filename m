From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config.txt: fix placement of diff.noprefix
Date: Fri, 10 Sep 2010 09:32:59 -0700
Message-ID: <7vvd6dh83o.fsf@alter.siamese.dyndns.org>
References: <1284082777-18826-1-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eli Collins <eli@cloudera.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 18:33:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou6XN-0003TH-Dr
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 18:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755490Ab0IJQdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 12:33:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46617 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755159Ab0IJQdI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 12:33:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 314F1D5F14;
	Fri, 10 Sep 2010 12:33:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tatN1pzUcmf66AzTI2iLyNyUU0M=; b=jYAr4G
	BuRWlaRhFMkxdgM9Y+CLRbR5CvVgXmRge3W1mlc/oNrdQ3T8J7LpP2yYygAcWOip
	ORk5Dwiuo2iWSR1KkOCJbUq6NRVE4U5f7gElmY8o+zLConfAnHtgtPw52hBpbQwn
	G9vOdVujoy7hEsud4zQUTwNML12+b2zKIDNFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H1daMj7WyXU8a7aQT7eDL5yJXk6rjbir
	6b/0/TkzTo3J5yaH7dk1HB7DTwkqVnPaWkP2go9cRVIYX9mW33Hz7yuPvV+qmgaV
	YZWO81rRwPgUlvBj56Uz38ffAoyqn9JH3nCeC6aWRZHX/V/r0510fxlIEcz5iJ0l
	Vy1MNc5/aLc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EF34FD5F12;
	Fri, 10 Sep 2010 12:33:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 261C4D5F0E; Fri, 10 Sep
 2010 12:33:00 -0400 (EDT)
In-Reply-To: <1284082777-18826-1-git-send-email-lodatom@gmail.com> (Mark
 Lodato's message of "Thu\,  9 Sep 2010 21\:39\:37 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 162FFC12-BCF9-11DF-8F1C-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155944>

Mark Lodato <lodatom@gmail.com> writes:

> In git-config(1), diff.noprefix was placed in between
> diff.mnemonicprefix and the list of mnemonic prefixes, which is
> obviously incorrect and very confusing to readers.  Now, it is located
> after the end of the explanation of mnemonicprefix, which makes much
> more sense.
>
> Signed-off-by: Mark Lodato <lodatom@gmail.com>
> ---
>  Documentation/config.txt |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index d294dd6..d82c0da 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -813,8 +813,6 @@ diff.mnemonicprefix::
>  	standard "a/" and "b/" depending on what is being compared.  When
>  	this configuration is in effect, reverse diff output also swaps
>  	the order of the prefixes:
> -diff.noprefix::
> -	If set, 'git diff' does not show any source or destination prefix.
>  `git diff`;;
>  	compares the (i)ndex and the (w)ork tree;
>  `git diff HEAD`;;
> @@ -826,6 +824,9 @@ diff.noprefix::
>  `git diff --no-index a b`;;
>  	compares two non-git things (1) and (2).
>  
> +diff.noprefix::
> +	If set, 'git diff' does not show any source or destination prefix.
> +
>  diff.renameLimit::
>  	The number of files to consider when performing the copy/rename
>  	detection; equivalent to the 'git diff' option '-l'.

Good eyes, thanks.  How did that happen I wonder...
