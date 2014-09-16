From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-rebase.txt: make it explicit in the syntax there is no way to specify <branch> without <upstream>.
Date: Tue, 16 Sep 2014 11:26:39 -0700
Message-ID: <xmqqiokn2zhc.fsf@gitster.dls.corp.google.com>
References: <87fvfrlg86.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 20:26:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTxSf-00029E-Tp
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 20:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778AbaIPS0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 14:26:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50101 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754323AbaIPS0l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 14:26:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 216F138A70;
	Tue, 16 Sep 2014 14:26:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qp0uQtF9OibeZvAAJXS2PN4/7s0=; b=HTD0z3
	kSFupLOOnlnDji7lYpKvlw4k4UOUU2XkWo6rDl3sARoH5Jkbslbp4Mx52LjY7PD9
	FCDSGjZ3zJLBH3ATGIXtpEe3/h7e/zAuh10ZZAAvNbKjznsKt2+25ytjUx2NtTrp
	sN1gMCHSHY4iYV5/irKtqd/vJZDpjhy4OpSyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rf7038MJ/T3UPAIPZEgQrhbbJNjdSAQx
	tbnE3M75Y8p/zpVbvnmYjjJPgmtDI4F5jBYEPh7aa8b0LNUBE9P0n9s2/x9O/k8z
	ozs5ncDccbzyPRerlABEYImPcfL+8vZJd3POab4Gtw0W0pZbv/nFXN/OetqfsjFP
	kr6hmOsXsKo=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 174A738A6F;
	Tue, 16 Sep 2014 14:26:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9321738A6E;
	Tue, 16 Sep 2014 14:26:40 -0400 (EDT)
In-Reply-To: <87fvfrlg86.fsf@osv.gnss.ru> (Sergey Organov's message of "Fri,
	29 Aug 2014 17:51:46 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 00A24B88-3DCF-11E4-9E2E-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257138>

Sergey Organov <sorganov@gmail.com> writes:

> Current syntax description makes one wonder if there is any syntactic way
> to distinguish between <branch> and <upstream> so that one can specify
> <branch> but not <upstream>. The change makes it explicit that these
> arguments are in fact positional.

Makes sense.
Thanks.


>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  Documentation/git-rebase.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index f14100a..4138554 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -9,7 +9,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
> -	[<upstream>] [<branch>]
> +	[<upstream> [<branch>]]
>  'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
>  	--root [<branch>]
>  'git rebase' --continue | --skip | --abort | --edit-todo
