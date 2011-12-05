From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: fix formatting error in merge-options.txt
Date: Mon, 05 Dec 2011 11:16:28 -0800
Message-ID: <7v4nxen81f.fsf@alter.siamese.dyndns.org>
References: <1323071607-29213-1-git-send-email-jacknagel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Jack Nagel <jacknagel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 05 20:17:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXe2M-0001fs-Gx
	for gcvg-git-2@lo.gmane.org; Mon, 05 Dec 2011 20:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325Ab1LETQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 14:16:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51945 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932161Ab1LETQa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 14:16:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 041926308;
	Mon,  5 Dec 2011 14:16:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XejDpapLi/1j9Mo0cjiFcNebrkc=; b=A3j5JN
	4A4DgX6TcCBl9xzBq+ZxRrY43SubatqI91WXU2kD2JEAPUX9oM7DbNaXjzob6q41
	OC+lrs5XITnrUE/oCHw8GPHnuRQ/ljkf15cuYCq+TlGUxfwOR+WnQFzWXK5aCFOo
	Gb8pxliCmFPZGrX0IQWpc/hUNGZ5qsYfouB50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WAeWvU1bQVy03xLv7osKTPDJWuKFb8sf
	ryR+gtEXvLoun5iAj4KE735t7joCtuSaCp3s4sasRqrmmGAfQ7rO+j2K60Eno6hf
	a4R8M3dBL/kqhS74gLiQCQMNxXU4TbImb+InLbwpc9rTEGxxVJorROjZ6fjunROS
	YrId/PjhNGg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEF346306;
	Mon,  5 Dec 2011 14:16:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 862296304; Mon,  5 Dec 2011
 14:16:29 -0500 (EST)
In-Reply-To: <1323071607-29213-1-git-send-email-jacknagel@gmail.com> (Jack
 Nagel's message of "Mon, 5 Dec 2011 01:53:27 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A27DB576-1F75-11E1-B095-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186285>

Jack Nagel <jacknagel@gmail.com> writes:

> The first paragraph inside of a list item does not need a preceding line
> consisting of a single '+', and in fact this causes the text to be
> misrendered. Fix it.

Thanks.

>
> Signed-off-by: Jack Nagel <jacknagel@gmail.com>
> ---
>  Documentation/merge-options.txt |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index 6bd0b04..1a5c12e 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -9,7 +9,6 @@ inspect and further tweak the merge result before committing.
>  
>  --edit::
>  -e::
> -+
>  	Invoke editor before committing successful merge to further
>  	edit the default merge message.
