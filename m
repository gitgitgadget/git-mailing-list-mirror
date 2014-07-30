From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] imap-send: clarify CRAM-MD5 vs LOGIN documentation
Date: Wed, 30 Jul 2014 12:28:40 -0700
Message-ID: <xmqqzjfqy7br.fsf@gitster.dls.corp.google.com>
References: <alpine.LSU.2.00.1407281138100.13901@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Wed Jul 30 21:28:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCZYU-0001qX-C5
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 21:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755623AbaG3T2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 15:28:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52708 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369AbaG3T2t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 15:28:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B52342C91E;
	Wed, 30 Jul 2014 15:28:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hrs0nOhADD/XF5wxhoLHqsscewc=; b=aJXpHl
	iQqD7UWSQjHpprTumV7pjtnfbjXwtMKLYVtES4ArC+Jtpwm8IXWr4t+Hc0ydGPEE
	3LgJDJ4Kj4wb2AoHkAxoB3xjlQHYWqBm+eSGgn03BYoCeCIhbdTBBNGGjOpt4RTS
	pKURK7Kbv/7aBlFZfggOvYWlhQfmuP4wtHr20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lCkkOoSdZPSP0RaOqQuGKKeTDDw03q33
	YznAfn/BSIoUv+ri6i84Amukq1BJQCIK1sQiSnOQ3UvtyDv7u1ICrhSb5ID7oR53
	eyUgua/yL14LRtWSa4KlPtQZEXmpjx97HnXhUGVXb8eJUp1r+7xuZL9gyq029fQj
	nZg055ojXmA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ACA862C91C;
	Wed, 30 Jul 2014 15:28:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5ACAF2C916;
	Wed, 30 Jul 2014 15:28:42 -0400 (EDT)
In-Reply-To: <alpine.LSU.2.00.1407281138100.13901@hermes-1.csi.cam.ac.uk>
	(Tony Finch's message of "Mon, 28 Jul 2014 11:38:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B72746FE-181F-11E4-A95F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254513>

Tony Finch <dot@dotat.at> writes:

> Explicitly mention that leaving imap.authMethod unset makes
> git imap-send use the basic IMAP plaintext LOGIN command.
> ---
>  Documentation/git-imap-send.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
> index 875d283..770cbe8 100644
> --- a/Documentation/git-imap-send.txt
> +++ b/Documentation/git-imap-send.txt
> @@ -76,7 +76,8 @@ imap.preformattedHTML::
>
>  imap.authMethod::
>  	Specify authenticate method for authentication with IMAP server.
> -	Current supported method is 'CRAM-MD5' only.
> +	Current supported method is 'CRAM-MD5' only. If this is not set
> +	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
>
>  Examples
>  ~~~~~~~~

Both patches make sense to me, but can you please sign-off your
patches?  See Documentation/SubmittingPatches for details.

Thanks.
