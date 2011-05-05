From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove duplicated "is a"
Date: Thu, 05 May 2011 11:46:30 -0700
Message-ID: <7voc3h6l4p.fsf@alter.siamese.dyndns.org>
References: <1304614634-46181-1-git-send-email-jabcalves@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Britto <jabcalves@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 20:46:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI3ZT-0003oo-JZ
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 20:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121Ab1EESqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 14:46:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51792 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072Ab1EESqi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 14:46:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EAEF94370;
	Thu,  5 May 2011 14:48:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CMgbsF34T9rrCUXVmdwxYZy7mHw=; b=EpK4Rn
	sBR0YLn3DeyimgpatWRwuMT4hWyX1U3w5995WRpuFb76rLcmeQpM1L4dcE7tv/cu
	xHWz42oZozJCb4S2gm+ou22rrheKxUm0u8cY+XwyVCWUCGDJ6Y13nDke4Tqs349q
	xGOlf8a+OvZ5qNUMVfYIQVfwkr1mHA7u+Gc6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w3Gzi06p5ndupgqULQqf2+qmgd5SmldT
	KYLd1nn27Q1TegCx6XusC6qy+iroBn1XDKBcgdSNTpXTmAok/MVgYpbtZmt8PiX+
	8/u1Hk9XKqY0fGPTaSfxwqetjujcParVg8cgweC5m06Maz93oOJ0KmzpDbcIWz00
	ys6C6zhPCXo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BABBE436F;
	Thu,  5 May 2011 14:48:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C62D6436E; Thu,  5 May 2011
 14:48:36 -0400 (EDT)
In-Reply-To: <1304614634-46181-1-git-send-email-jabcalves@gmail.com>
 (Britto's message of "Thu, 5 May 2011 13:57:14 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4AC4B210-7748-11E0-8D8F-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172868>

Britto <jabcalves@gmail.com> writes:

> Signed-off-by: Britto <jabcalves@gmail.com>

Care to identify Britto Who?

> ---
>  Documentation/diff-options.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 34f0145..23b605f 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -243,7 +243,7 @@ ifdef::git-log[]
>  	For following files across renames while traversing history, see
>  	`--follow`.
>  endif::git-log[]
> -	If `n` is specified, it is a is a threshold on the similarity
> +	If `n` is specified, it is a threshold on the similarity
>  	index (i.e. amount of addition/deletions compared to the
>  	file's size). For example, `-M90%` means git should consider a
>  	delete/add pair to be a rename if more than 90% of the file
