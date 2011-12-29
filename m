From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add MYMETA.json to perl/.gitignore
Date: Wed, 28 Dec 2011 21:34:18 -0800
Message-ID: <7vty4kx7ol.fsf@alter.siamese.dyndns.org>
References: <1325133725-20671-1-git-send-email-jacknagel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jack Nagel <jacknagel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 29 06:34:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rg8dF-0004im-IQ
	for gcvg-git-2@lo.gmane.org; Thu, 29 Dec 2011 06:34:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092Ab1L2FeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Dec 2011 00:34:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57447 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929Ab1L2FeU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Dec 2011 00:34:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43F8E7261;
	Thu, 29 Dec 2011 00:34:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AcG9PNOa0G/CplpvrRaXjw8Bdow=; b=Bi163Y
	IgdTL4zXjHfLglzIdxm9lpPaHQekFXMUFdaCJWuIN0yMD+PpaYdDEyUWUroIvlpo
	arOUO1juAkm1hiBTy/+ZmmbNnIix3oGS4mVM2Q+qo5cYug4XrEtr8JPpi/zHOiDs
	jl12GQyJ/9VUl4hiAhMDAagwpBS8AekpYonyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XvIUiUkCVPqVhQC2q8CWeHUOZWdjM8am
	Z0ibxaQLUuU3yWTf143D5Kb+d6X1Y508AVoz8n/1q4w6dnaL3GgzRV+7j9EHGesS
	/zb+meHTWF/Dg8oEyVPed3vwBNy6u+XFH59uqh36M0KfQ+ZtNdW2FX9mLk687XEM
	yKnbjRyZGII=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AF347260;
	Thu, 29 Dec 2011 00:34:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C29A8725F; Thu, 29 Dec 2011
 00:34:19 -0500 (EST)
In-Reply-To: <1325133725-20671-1-git-send-email-jacknagel@gmail.com> (Jack
 Nagel's message of "Wed, 28 Dec 2011 22:42:05 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C194A7D2-31DE-11E1-81D5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187773>

Jack Nagel <jacknagel@gmail.com> writes:

> ExtUtils::MakeMaker generates MYMETA.json in addition to MYMETA.yml
> since version 6.57_07. As it suggests, it is just meta information about

Are we better off ignoring MYMETA.* instead, so that we won't get affected
when they start dropping new cruft with the same information in yet more
different formats?

> the build and is cleaned up with 'make clean', so it should be ignored.
>
> Signed-off-by: Jack Nagel <jacknagel@gmail.com>
> ---
>  perl/.gitignore |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/perl/.gitignore b/perl/.gitignore
> index 9235e73..d5c6e22 100644
> --- a/perl/.gitignore
> +++ b/perl/.gitignore
> @@ -1,5 +1,6 @@
>  perl.mak
>  perl.mak.old
> +MYMETA.json
>  MYMETA.yml
>  blib
>  blibdirs
