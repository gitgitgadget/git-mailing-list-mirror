From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/13] Remove unnecessary historical note from "Object storage format"
Date: Sat, 24 Aug 2013 20:28:30 -0700
Message-ID: <xmqqeh9imotd.fsf@gitster.dls.corp.google.com>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
	<1339924016.1091137.1377329596491.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, wking@tremily.us
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Aug 25 05:28:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDR0H-0005jN-Pa
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 05:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755509Ab3HYD2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 23:28:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61249 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754939Ab3HYD2c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 23:28:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 428E42AF9B;
	Sun, 25 Aug 2013 03:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mWeKyiW//SwY30mKIZIQLCEKD+0=; b=vclseg
	aAUSmuMbK1NK3gmi2uVqFvfXrMd7LpPiLp8SH9t3pFbGkCOzMTxvx6yiyTN3LbB3
	N4N3pOTRBlxEOuxXvu/FqaKAUpUxCE2BtByWzBgeoiUuL88KtSYnctwSwa3/8IJf
	S7rYsgUA3QSMyU5n19mNqtuJRbk3fnMtcgfBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GS8zdtIZKnlp3I2tHRzIDv8A9mejRI6k
	UatYG/UV6s2BwS+anzqjkG9wVs/+JLNbyPmOF9wLDObsvLjBUhrzow6Vq3qnAbFg
	cixhFkRZkXKSYYCaaMVq1R9u962IJgDEjoo0TEobYTOgVIoVSnHHKU5jZJcDGs5/
	e3cSKRs88bg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36B642AF99;
	Sun, 25 Aug 2013 03:28:32 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A6072AF97;
	Sun, 25 Aug 2013 03:28:31 +0000 (UTC)
In-Reply-To: <1339924016.1091137.1377329596491.JavaMail.ngmail@webmail08.arcor-online.net>
	(Thomas Ackermann's message of "Sat, 24 Aug 2013 09:33:16 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6A707280-0D36-11E3-A029-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232902>

Thomas Ackermann <th.acker@arcor.de> writes:

> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/user-manual.txt | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index f713f26..aa6bfab 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -4132,8 +4132,6 @@ about the data in the object.  It's worth noting that the SHA-1 hash
>  that is used to name the object is the hash of the original data
>  plus this header, so `sha1sum` 'file' does not match the object name
>  for 'file'.
> -(Historical note: in the dawn of the age of Git the hash
> -was the SHA-1 of the 'compressed' object.)

As we no longer are able to read such a historical object, I think
it is OK to drop the historical note in this particular case.

Thanks.

>  
>  As a result, the general consistency of an object can always be tested
>  independently of the contents or the type of the object: all objects can
