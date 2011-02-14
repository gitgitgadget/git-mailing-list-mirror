From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] commit,status: describe -u likewise
Date: Mon, 14 Feb 2011 11:57:20 -0800
Message-ID: <7vei7as82n.fsf@alter.siamese.dyndns.org>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
 <959cfaee441413401ddb7ad7fd29f4a98f668bec.1297695910.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 20:57:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp4Y8-0003dI-Kl
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 20:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680Ab1BNT52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 14:57:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab1BNT51 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 14:57:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 976974622;
	Mon, 14 Feb 2011 14:58:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lN4vuwyQ0fj1cgyrAl+dmjK4u0Y=; b=tSyYVN
	UGVwyCiq9kOaWjlyiSw1fWbHLNJyfm6k1DtcaQqv7DO25bXQZkmwskezA+cgHLC9
	7azea7XmHhcKXwymNLc3OlzPmYfUjAHEU+eIWAkpZZb9iMUI3uUIW0c0WDVv2Rsq
	rj44T1VQWbxU0r+/io0zL1fzj5M2zGG2nFFLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pSXk+x6rXfWHdb0Gxg2LeyU2r59ssHLE
	D3KNL0/JWQp19ja/CKfylFTUbate4G0Y6kZojgyR8kcEu5w6FnfDcNDObLU7ckzn
	lZs6AhCqAkg/5oeYlLgkZbsMHGp0ZnlKdZPyZPH6m50y1ahM7Ggsb23qFyz0170B
	IQlIyjGrOY0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 74B7C4621;
	Mon, 14 Feb 2011 14:58:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 988424620; Mon, 14 Feb 2011
 14:58:26 -0500 (EST)
In-Reply-To: <959cfaee441413401ddb7ad7fd29f4a98f668bec.1297695910.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Mon\, 14 Feb 2011 16\:10\:34 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CB0231E0-3874-11E0-8E2A-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166762>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> They differ by one character only. Being exactly equal should help
> translations.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 8a534de..ef2114b 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -150,7 +150,7 @@ static struct option builtin_commit_options[] = {
> ...
> -	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal, no (Default: all)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
> +	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal, no. (Default: all)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },

Makes sense; thanks.

I however wonder if we have an opportunity for even more unifying these
two arrays, typing the same thing only once.
