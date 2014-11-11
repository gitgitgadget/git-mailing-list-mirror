From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gittutorial.txt: remove reference to ancient Git version
Date: Tue, 11 Nov 2014 14:51:41 -0800
Message-ID: <xmqqioil5p1e.fsf@gitster.dls.corp.google.com>
References: <1409592246.526697.1415733216505.JavaMail.ngmail@webmail12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Tue Nov 11 23:51:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoKHs-00019O-Bo
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 23:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453AbaKKWvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 17:51:44 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52117 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752359AbaKKWvn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2014 17:51:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A3021DA01;
	Tue, 11 Nov 2014 17:51:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=qzRm51qDp3qL18CmHD3dmNzdG/E=; b=UklBizaln848tKn+kyht
	7LzKMqdH4eoUtrgjeWgxhw9+5ufYbtgzYYdrffP+65QZeJyEwvHqlFcmtUE4PcZb
	mZh8GQwYm3Oum4qzfllzvUkeZc3XkH5BRTNZK5Jnt7iT/on1XFT12BO5q1JLfQt+
	r+61IeVgEAa0vEo54we9huM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=obb2loqkQOA6IWow5w8yYAkM3K+iSw4aKkB7+r0jug6VFZ
	Tt6xCPvoSzw9K6X8wgEL4tHgETrmyTYdMyV6kxkTWP88Fa4lM7Z4k+2ETuSt741K
	rBhkVay1p6UYHgf3lIjYVEM5vaXnSsIAe4b9emQPTDXUKJ5xpKvZ3kkWdx4hE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 609D41DA00;
	Tue, 11 Nov 2014 17:51:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB82C1D9FF;
	Tue, 11 Nov 2014 17:51:42 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4E3243D8-69F5-11E4-A612-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Ackermann <th.acker@arcor.de> writes:

> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/gittutorial.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
> index af9f709..710e636 100644
> --- a/Documentation/gittutorial.txt
> +++ b/Documentation/gittutorial.txt
> @@ -3,7 +3,7 @@ gittutorial(7)
>  
>  NAME
>  ----
> -gittutorial - A tutorial introduction to Git (for version 1.5.1 or newer)
> +gittutorial - A tutorial introduction to Git
>  
>  SYNOPSIS
>  --------

Yeah, sounds like going in the right direction.

Perhaps we should start doing a serious re-reading of this document
and update the contents to suggest better ways that were invented
to solve common problems since this document was written.
