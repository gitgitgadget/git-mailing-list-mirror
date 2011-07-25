From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/submodule: add command references and
 update options
Date: Mon, 25 Jul 2011 13:30:52 -0700
Message-ID: <7vmxg2qf0j.fsf@alter.siamese.dyndns.org>
References: <4E2B1A54.2000605@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nikolai Weibull <now@bitwi.se>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 25 22:31:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlRnp-0006Bl-Ej
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 22:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972Ab1GYUa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 16:30:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64709 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507Ab1GYUaz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 16:30:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C29D4D80;
	Mon, 25 Jul 2011 16:30:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yX74R9tQYE4pLK9IUj2TXLGs0Q4=; b=ERSY9H
	EyiTN4RtCgzMb2HfHqyo9vpfetPwxjbdXNJgENJ00Cp0Wa1VNEb3WJ1ubaSD2OzM
	SPuCp5Ro0SczlPDiMqodP09caywp10srwkFCzosx+25f+Ddsh2zcLBR9WfYWnbSh
	xkiUGnEmWsRoE8rvfIRzdEGuwg0w5UXQ9uS/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a03cCQNV+y/4gLE63nAwa5TplCCXfO4P
	a0tFyCd8xjI/laAs/+x6E7M3LkIq+UnPIBVT9VGxKuKgqZwQyNfem0eBpG1etlKk
	/TC5oao1SWd/A3iNIN3OZraHvco/ZsmPkC38DU5QZkaPBdY91vNvrYffJpxlsYSH
	I+WX3CfRa30=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5454B4D7F;
	Mon, 25 Jul 2011 16:30:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C99AC4D7D; Mon, 25 Jul 2011
 16:30:53 -0400 (EDT)
In-Reply-To: <4E2B1A54.2000605@web.de> (Jens Lehmann's message of "Sat, 23
 Jul 2011 21:00:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE776F52-B6FC-11E0-B88A-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177814>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> @@ -131,7 +137,7 @@ update::
>  +
>  If the submodule is not yet initialized, and you just want to use the
>  setting as stored in .gitmodules, you can automatically initialize the
> -submodule with the --init option.
> +submodule with the '--init' option.

Don't we want to use

	the `--init` option

instead for consistency? After all, that is what the users actually type.

	$ git grep -e "\`--[a-z]" Documentation/ | wc -l
        287
        $ git grep -e "'--[a-z]" Documentation/ | wc -l
        132

> @@ -140,11 +146,14 @@ summary::
>  	Show commit summary between the given commit (defaults to HEAD) and
>  	working tree/index. For a submodule in question, a series of commits
>  	in the submodule between the given super project commit and the
> -	index or working tree (switched by --cached) are shown. If the option
> -	--files is given, show the series of commits in the submodule between
> +	index or working tree (switched by '--cached') are shown. If the option
> +	'--files' is given, show the series of commits in the submodule between
>  	the index of the super project and the working tree of the submodule
> -	(this option doesn't allow to use the --cached option or to provide an
> +	(this option doesn't allow to use the '--cached' option or to provide an
>  	explicit commit).
> ++
> +Using the '--submodule=log' option with linkgit:git-diff[1] will provide the
> +same information.

I am not a huge fan of these extra paragraphs, especially in reality it is
not "provide the same" but "the same and a lot of other".

I dunno.
