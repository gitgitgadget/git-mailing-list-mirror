From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] contrib/subtree: Ignore testing directory
Date: Mon, 18 Feb 2013 14:51:02 -0800
Message-ID: <7v38wt9qy1.fsf@alter.siamese.dyndns.org>
References: <1361221013-12756-1-git-send-email-greened@obbligato.org>
 <1361221013-12756-4-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Techlive Zheng <techlivezheng@gmail.com>,
	James Nylen <jnylen@gmail.com>
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 23:51:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7ZYZ-0001pT-DE
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 23:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757534Ab3BRWvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 17:51:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59351 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757509Ab3BRWvE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 17:51:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32DCAB8AD;
	Mon, 18 Feb 2013 17:51:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QNKglMoDqA5Ea9jwKWHu56X4Xk0=; b=NeLyq0
	ZaJAU9WRxGkrmy7qorLyoH7Olrw4nm/LJPIaYI7Re0XIQvwArScB4ALd/6dQgqBB
	5gCLvhWxNJhHvS9+kUW6kv+6VDoJ4IfMsMpK6GnMUv4ytEZInIholGVslkJEygYC
	BKlGP0r7gM7SvtzIBtCbPjbu2iVxgJy86Ltmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rtW1FjhQ8U0mXFVPxbL0xN8FNpbSVwrP
	ePkIvG/e41vhLujpMK77DMVCCuxGClNgTz6rEFpuZgtBM+Ibe2MJXav+7nRVPW0n
	ANoZyqiXMxGTG2KG1yjSLzmbrvxvlDIQ/bGCh5Y+sHXr0mZrooPtEgfHWHuzhXxa
	u4ulX2Ca5bM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 277F5B8AC;
	Mon, 18 Feb 2013 17:51:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B617B8AA; Mon, 18 Feb 2013
 17:51:03 -0500 (EST)
In-Reply-To: <1361221013-12756-4-git-send-email-greened@obbligato.org> (David
 A. Greene's message of "Mon, 18 Feb 2013 14:56:48 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC2CDEF4-7A1D-11E2-83B3-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216543>

"David A. Greene" <greened@obbligato.org> writes:

> From: Techlive Zheng <techlivezheng@gmail.com>
>
> Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---
>  contrib/subtree/.gitignore |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/subtree/.gitignore b/contrib/subtree/.gitignore
> index 91360a3..59aeeb4 100644
> --- a/contrib/subtree/.gitignore
> +++ b/contrib/subtree/.gitignore
> @@ -1,6 +1,5 @@
>  *~
>  git-subtree
> -git-subtree.xml
>  git-subtree.1
> -mainline
> -subproj
> +git-subtree.xml
> +t/trash\ directory.*

The title explains t/trash* but not mainline/subproj lines.  Why can
they go now?

Also git-subtree.xml seems to be moved without justification
(perhaps making the list alphabetical)?
