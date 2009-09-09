From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] INSTALL: Reorder dependencies, split shell and
 Perl
Date: Tue, 08 Sep 2009 23:01:46 -0700
Message-ID: <7vws48hd11.fsf@alter.siamese.dyndns.org>
References: <1252461061-75840-1-git-send-email-brian@gernhardtsoftware.com>
 <1252461061-75840-3-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 08:02:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlGFn-0006kc-VT
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 08:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbZIIGBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 02:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbZIIGBx
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 02:01:53 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbZIIGBx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 02:01:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 843732B32A;
	Wed,  9 Sep 2009 02:01:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F+ngZyORTA2ytmlR0UgjATyKRSs=; b=BEbc6r
	0BlE83zRO11IZOJ/f4s4BM+xktqDqMjPp172wNJSOabVto+xan+ieuGbtE2nIKDc
	KTTfSjBKLN188Jv1h4hPN5LuFQS/3TzkorR/PuloyCJ0gvn66fpIZmShnf6qd1rV
	eQZDb7sORTfmeWnyYYWCbUx3M+dKa3Fc0QuMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=djNTamvVztqIqVYt3x2P9N7lHe9MYr6b
	ZxhAYRzyl8vTU1bICqtzHbl6uerrlmBltzGDTnCTG8eivdkSx2xtyjGyMTgVN87g
	VZlHNFrzq7ynLFKCooEKojIMbzbz4gH3d4dH2aTxrvR4kOYHWthfQbsPlgrEZ9aU
	ze8LD/ZH2eI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 67D0C2B329;
	Wed,  9 Sep 2009 02:01:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9CA722B323; Wed,  9 Sep
 2009 02:01:47 -0400 (EDT)
In-Reply-To: <1252461061-75840-3-git-send-email-brian@gernhardtsoftware.com>
 (Brian Gernhardt's message of "Tue\,  8 Sep 2009 21\:51\:00 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4498E46A-9D06-11DE-AC33-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128056>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> The most important and non-optional dependencies should go first, so put
> them there.  While we're moving them, the descriptions for shell and perl
> were archaic, referring to "bare-bones Porcelainish scripts" that have
> become powerful and essential.
>
> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
> ---
>
>  Split from v1's 2/2 so the changes don't get confused with the re-order.
>
>  I kept the shell and perl re-wordings here since they're also somewhat of
>  a factual error instead of 3/3's additions.
>
>  INSTALL |   14 +++++++++-----
>  1 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/INSTALL b/INSTALL
> index 5267468..7ab2580 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -52,6 +52,15 @@ Issues of note:
>  
>  	- "zlib", the compression library. Git won't build without it.
>  
> +	- "ssh" is used to push and pull over the net.
> +
> +	- A POSIX-compliant shell is required to run many scripts needed
> +	  for everyday use (e.g. "bisect", "pull").
>
> +	- "Perl" is needed to use some of the features (e.g. preparing a
> +	  partial commit using "git add -i/-p", interacting with svn
> +	  repositories with "git svn").
> +

This is a very minor point, but should we even make a distinction between
"scripts" vs "features" here?  It is a minor detail that "bisect" and
"pull" are implemented as scripts after all.  I dunno.
