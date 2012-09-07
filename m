From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ls-remote: document the '--get-url' option
Date: Fri, 07 Sep 2012 10:57:34 -0700
Message-ID: <7va9x1yaup.fsf@alter.siamese.dyndns.org>
References: <7v7gs63mio.fsf@alter.siamese.dyndns.org>
 <1347000079-7945-1-git-send-email-stefan.naewe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Naewe <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 19:57:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA2oO-0008VI-Qg
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 19:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754718Ab2IGR5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 13:57:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62696 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754629Ab2IGR5i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 13:57:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 792178875;
	Fri,  7 Sep 2012 13:57:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sp6msyQZtvRKNRm4VSco2+s+db4=; b=DonpVL
	KHTO+rgrwYYFEBNHkGVF5YmrBNWoU+KHHUJxFJ8k+YJweHkvSIH6DdR9W0jOk1Ut
	ekeetH369oZimpOS9jCjO760T2w4ju498J3nBISwum65HVRzv7XoEYgnU47JhAAp
	8quuVdgePtI5kGBPUsJCNJSWrXiKhreJngvhs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P25paq2YTEbhhP8TYT/Se7GCz1P69eo3
	eLjZfiAEBB8P/5bMqgE3/60ngZiZPEL6UfZPQfCprX71d+Jsv/l9s+oTHioeMgTh
	4FCb69cBPI7y6qF/Y1mQgUuaKfs1zl5qZwA/MFBoTMHSdT0v5krlVR0JNrHUKss1
	lDy1VwTViCg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 667248874;
	Fri,  7 Sep 2012 13:57:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CFB1D8871; Fri,  7 Sep 2012
 13:57:35 -0400 (EDT)
In-Reply-To: <1347000079-7945-1-git-send-email-stefan.naewe@gmail.com>
 (Stefan Naewe's message of "Fri, 7 Sep 2012 08:41:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8168C2A2-F915-11E1-AAB6-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204983>

Stefan Naewe <stefan.naewe@gmail.com> writes:

> While looking for a way to expand the URL of a remote
> that uses a 'url.<name>.insteadOf' config option I stumbled
> over the undocumented '--get-url' option of 'git ls-remote'.
> This adds some minimum documentation for that option.
>
> And while at it, also add that option to the '-h' output.
>
> Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
> ---
>  Documentation/git-ls-remote.txt | 4 ++++
>  builtin/ls-remote.c             | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
> index 7a9b86a..a2ebf1d 100644
> --- a/Documentation/git-ls-remote.txt
> +++ b/Documentation/git-ls-remote.txt
> @@ -42,6 +42,10 @@ OPTIONS
>  	it successfully talked with the remote repository, whether it
>  	found any matching refs.
>  
> +--get-url::
> +	Expand the URL of the given remote repository taking into account any
> +	"url.<base>.insteadOf" config setting (See linkgit:git-config[1]).
> +

I'll queue this, after adding "... and exit without talking to the remote."

Thanks.
