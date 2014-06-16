From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: State coding guideline for error message punctuation
Date: Mon, 16 Jun 2014 11:52:13 -0700
Message-ID: <xmqq8uowr8ki.fsf@gitster.dls.corp.google.com>
References: <1402923357-3788-1-git-send-email-philipoakley@iee.org>
	<1402923357-3788-2-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Jun 16 20:52:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwc15-0000L9-0c
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbaFPSwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:52:23 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51433 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932251AbaFPSwU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:52:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8199D208A2;
	Mon, 16 Jun 2014 14:52:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zwy4cbknR6jGArLa5RUZ3J6sGBs=; b=Z7cSWg
	OBonUPtynqaSuJdtLmeTfg/56r567Td5SIYB1YBRkZ9f5CyTJbUgNabR3MALdtIw
	OaI0WPscCql7Q9n3rYEfyptszRxeioppLKggBMf6ink+KfkungOvP3+xZ9dy93d6
	6BDOKEb0/KG32Fw6J+guvoXY17yBqXETaYdmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tP64eMYAnqTAtqFDORmW9SaF6gPNp/X6
	hil3g+6tIxN+WoEYzPx9YVYt4JRwp449YpKhG8HeNUUWB9kiPRVwxs78gldX5cFL
	pkaT8G+fDS+NrHegLc75YaFoMlV00zjsDLxaM2KCNdBdAA6pNbLtRBleHSnUJqxM
	xzyj8x6oaYE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7827C208A1;
	Mon, 16 Jun 2014 14:52:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 464EC20897;
	Mon, 16 Jun 2014 14:52:13 -0400 (EDT)
In-Reply-To: <1402923357-3788-2-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Mon, 16 Jun 2014 13:55:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 542EB09C-F587-11E3-B2AA-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251798>

Philip Oakley <philipoakley@iee.org> writes:

> Clarify error message puntuation to reduce review workload [1].
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/251547
> (see trailing 'nit' item).
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---

Hmmm.  Do we really need to spell everything out?

I would rather hope that we can rely on our contributors to know Git
well enough to ask "git grep" after reading the "follow the style of
existing and surrounding code" rule that governs the overall
guideline.

>  Documentation/CodingGuidelines | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 4d90c77..b2f3442 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -404,6 +404,13 @@ For Python scripts:
>     documentation for version 2.6 does not mention this prefix, it has
>     been supported since version 2.6.0.
>  
> +Error Messages
> +
> + - We typically do not end error messages with a full stop. While
> +   we've been rather inconsistent in the past, these days we mostly
> +   settle on no punctuation.
> +
> +
>  Writing Documentation:
>  
>   Most (if not all) of the documentation pages are written in the
