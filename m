From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule recursion in git-archive
Date: Wed, 27 Nov 2013 11:05:29 -0800
Message-ID: <xmqq61rdu0li.fsf@gitster.dls.corp.google.com>
References: <2E636B58-47EB-4712-93CA-39E8D1BA3DB9@mac.com>
	<5294BB97.7010707@web.de>
	<xmqqmwkqvmck.fsf@gitster.dls.corp.google.com>
	<52953CB7.8020300@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Nick Townsend <nick.townsend@mac.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Nov 27 20:05:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlkQb-0007R0-0z
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 20:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754969Ab3K0TFd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Nov 2013 14:05:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46593 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754622Ab3K0TFc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Nov 2013 14:05:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22311558E7;
	Wed, 27 Nov 2013 14:05:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0sMJmATqyOFQ
	lv0TpdYDam/uOfY=; b=jKJuUjwJ/QwdJ6mlTFkTcjiBVbZ1WoGEqOz8MXQZi/Cd
	Vz8kuulQQ+xl7uOcXJ06ixEt4mJbcCcJ2hGi/2eekDQ+HT9RPwK/1PwnySk5t6EV
	QMLm5coo+IcvkDD6fdg+p0bgWaDfgUnSeV0pC3vSseaTMAmnAs0tgsF+JNKos24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Z+UsUp
	GEkTFUEgdapwyJhUgFGNFH4DkkD/Ys5h47ZceSe+yo/BUIW9e36gjzuUvEkUcN+K
	tx4PC42JS7wVUp+TQYRnDgHcoioH2ezZ9rgdnSpQruza6L3NoTCyjGCp1UnSQzeg
	msIEGik4NEf4v1Y6yz3H2MxR3+KnZsEtV95P4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EDAB558E6;
	Wed, 27 Nov 2013 14:05:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49E75558E3;
	Wed, 27 Nov 2013 14:05:31 -0500 (EST)
In-Reply-To: <52953CB7.8020300@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Wed, 27
	Nov 2013 01:28:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E2CE3000-5796-11E3-BD79-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238454>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> OK, but the repetition of "cover letter" and "e-mail messages"
> irritates me slightly for some reason.  What about the following?

Looks good to me; will queue, thanks.

> -- >8 --
> Subject: [PATCH] SubmittingPatches: document how to handle multiple p=
atches
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  Documentation/SubmittingPatches |   11 +++++++++--
>  1 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/Submitti=
ngPatches
> index 7055576..e6d46ed 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -139,8 +139,15 @@ People on the Git mailing list need to be able t=
o read and
>  comment on the changes you are submitting.  It is important for
>  a developer to be able to "quote" your changes, using standard
>  e-mail tools, so that they may comment on specific portions of
> -your code.  For this reason, all patches should be submitted
> -"inline".  If your log message (including your name on the
> +your code.  For this reason, each patch should be submitted
> +"inline" in a separate message.
> +
> +Multiple related patches should be grouped into their own e-mail
> +thread to help readers find all parts of the series.  To that end,
> +send them as replies to either an additional "cover letter" message
> +(see below), the first patch, or the respective preceding patch.
> +
> +If your log message (including your name on the
>  Signed-off-by line) is not writable in ASCII, make sure that
>  you send off a message in the correct encoding.
