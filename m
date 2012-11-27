From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] Fix grammar
Date: Tue, 27 Nov 2012 12:39:53 -0800
Message-ID: <7v8v9mn5k6.fsf@alter.siamese.dyndns.org>
References: <1354038279-76475-1-git-send-email-max@quendi.de>
 <1354038279-76475-4-git-send-email-max@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Tue Nov 27 21:40:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdRwz-0003pc-5B
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 21:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755333Ab2K0Uj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 15:39:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50091 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754338Ab2K0Uj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 15:39:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 470D8A714;
	Tue, 27 Nov 2012 15:39:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aRVAbc8TheOe3E51n+TdAhihZk4=; b=XYF7RS
	R8pnXmGSlbKEc3iLRtiQzupwaK73e/WFzlayytlZTu2YfsYejvO0tOqZSIVtsPEr
	x1h5gZQsKY9VYGTN4qJx2UzYp/w2qebGdbTdARrmgQHlxty6KzmgV/mMgHWDo5TC
	THP1qiwcvht+usyQy4iYITNb3GtYINwejdD+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZId6jHZZfWt9tscmX8mBSf1qxcnGsmKS
	2FLMj5GNViJQJ2GaOG/1ozjlxNGk+Axa3oMLSeBylqE0G9XlJD1GjhqnYJGnphcl
	ZpZTvYTxy23INMQ3QR95xbyPtRhg38R7c/8qghY5ktCH0FmPIElvibTc77cmy4UP
	ebqaBE13/wg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FF1CA713;
	Tue, 27 Nov 2012 15:39:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85833A70F; Tue, 27 Nov 2012
 15:39:55 -0500 (EST)
In-Reply-To: <1354038279-76475-4-git-send-email-max@quendi.de> (Max Horn's
 message of "Tue, 27 Nov 2012 18:44:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9A2E6448-38D2-11E2-A3F0-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210594>

Max Horn <max@quendi.de> writes:

> Subject: Re: [PATCH 3/6] Fix grammar

Please run "git shortlog -200 --no-merges" from the tip of your
topic branch before sending a series out, and see if you can
immediately identify what area each of your patches affects.

> Signed-off-by: Max Horn <max@quendi.de>
> ---
>  Documentation/git-remote-helpers.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
> index db63541..7eb43d7 100644
> --- a/Documentation/git-remote-helpers.txt
> +++ b/Documentation/git-remote-helpers.txt
> @@ -235,9 +235,9 @@ Commands are given by the caller on the helper's standard input, one per line.
>  'capabilities'::
>  	Lists the capabilities of the helper, one per line, ending
>  	with a blank line. Each capability may be preceded with '*',
> -	which marks them mandatory for git version using the remote
> -	helper to understand (unknown mandatory capability is fatal
> -	error).
> +	which marks them mandatory for git versions using the remote
> +	helper to understand. Any unknown mandatory capability is a
> +	fatal error.
>  
>  'list'::
>  	Lists the refs, one per line, in the format "<value> <name>
