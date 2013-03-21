From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff.c: diff.renamelimit => diff.renameLimit in message
Date: Thu, 21 Mar 2013 13:43:14 -0700
Message-ID: <7va9pwa3h9.fsf@alter.siamese.dyndns.org>
References: <CAM998vHDay2o55Q3v4tfh=tvcmpOHHCPX-Ya5KxVxsn3=jzs3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Nanasy <max.nanasy@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 21:43:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UImKu-0006Vl-QI
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 21:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965Ab3CUUnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 16:43:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43438 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752746Ab3CUUnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 16:43:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B842B8C9;
	Thu, 21 Mar 2013 16:43:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EgbxhJNu5V4Q290VkfUvtNVueo0=; b=VKBrJp
	XRrz2jyNUhCHHCnXTPkRCFCDrjE98fHk36hrGW39xycRaekyMUYnKuaOLp/QxBBg
	uYQSKXjfnH2gK/pJosvTXpaHJkIyN+FGgN7Tnb8NdI9j0HCiHwzoQpc8VGkP6n8J
	6gr+rwvVtQL6Qwbfq2GnLndBzKcjMOO5U8V9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eauNRMk0fTKJAPT9gnlR/JOQ+TJS4v6F
	11F8jcvBaRMWJ6MTXPLHvOPe31VUMsitxQpppRRiz1p1Sok2oeNvHnPj9uYvZ9hR
	Q16HYBM8SAL1TcSJnr8Wqw611Buw3VAmmj6dWAvkmT1c6CvPy5mh9dIQAlzV+wFU
	He0v67bAiSQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1022BB8C8;
	Thu, 21 Mar 2013 16:43:16 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 775E9B8C4; Thu, 21 Mar 2013
 16:43:15 -0400 (EDT)
In-Reply-To: <CAM998vHDay2o55Q3v4tfh=tvcmpOHHCPX-Ya5KxVxsn3=jzs3A@mail.gmail.com> (Max
 Nanasy's message of "Thu, 21 Mar 2013 12:53:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F472A56A-9267-11E2-B46D-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218757>

Max Nanasy <max.nanasy@gmail.com> writes:

> In the warning message printed when rename or unmodified copy
> detection was skipped due to too many files, change "diff.renamelimit"
> to "diff.renameLimit", in order to make it consistent with git
> documentation, which consistently uses "diff.renameLimit".
>
> Signed-off-by: Max Nanasy <max.nanasy@gmail.com>
> ---

I "git grep"ed around and it tells me that this is the only such
place.  Thanks.

The patch is severely whitespace damaged.  If you plan to keep
contributing to Git, I'd like to make sure that your mail toolchain
is sane, so that we do not have to keep hand-adjusting patches
submitted by you before applying.

>  diff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/diff.c b/diff.c
> index 156fec4..052974e 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4662,7 +4662,7 @@ int diff_result_code(struct diff_options *opt, int status)
>  {
>   int result = 0;
>
> - diff_warn_rename_limit("diff.renamelimit",
> + diff_warn_rename_limit("diff.renameLimit",
>         opt->needed_rename_limit,
>         opt->degraded_cc_to_c);
>   if (!DIFF_OPT_TST(opt, EXIT_WITH_STATUS) &&
> --
> 1.8.1.3
