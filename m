From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Clean: Remove unnecessary `\' (line continuation)
Date: Wed, 30 Mar 2011 12:21:21 -0700
Message-ID: <7v8vvwo1n2.fsf@alter.siamese.dyndns.org>
References: <1fbceaa8-398c-44ec-8833-a03e4cca6805-mfwitten@gmail.com>
 <ca8eabbf-ed1b-4b46-a7f7-4b068a2de5b7-mfwitten@gmail.com>
 <5bddd028-bf38-46b9-a189-bdb09038dfdd-mfwitten@gmail.com>
 <d92be3a1-6f30-4b04-ac38-39058e5a6959-mfwitten@gmail.com>
 <a59d19d0-f279-43fe-8ac6-06c4bd13c941-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 21:21:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q50xV-0000G9-MZ
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 21:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755792Ab1C3TVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 15:21:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42923 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754847Ab1C3TVc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 15:21:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 527024727;
	Wed, 30 Mar 2011 15:23:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nvxbXvPIGjtAlAkGMF3zN1F/Uz4=; b=xVZzhf
	nzXpzLnlv+uAShg5lVkuGmBtJyOzcqhA9S5ptd1aM5QGrcW+yqIF0JbzyIBMNoa+
	Xmybp0kHNaxyFzbdKKkzUqlazm+4vB3kT3w68wpHjrXcG01fUOAiew9r/VpODn5K
	4CF9q8eWdwzlnjb7Ar2HTj856xmxuBkeYywjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HU6W0ALfajituHFD4n/aiaga4kmTDnmy
	8YEbfUd3ynNkw6gJQ7xgY27kFaRvi44CRSJQvRo+EZuxsq+v7CcoHkR6z6D64CrO
	BbllFCpPO7EEuc+DT7PwFvwo/UiInAoe/NAYmlDl8UHnWkitbK6qKVgEw3EDscHM
	LZwKPPT+TZU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2F0034726;
	Wed, 30 Mar 2011 15:23:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E62224720; Wed, 30 Mar 2011
 15:23:10 -0400 (EDT)
In-Reply-To: <a59d19d0-f279-43fe-8ac6-06c4bd13c941-mfwitten@gmail.com>
 (Michael Witten's message of "Wed, 2 Mar 2011 15:25:23 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2859E3AA-5B03-11E0-8EAF-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170409>

Michael Witten <mfwitten@gmail.com> writes:

> Signed-off-by: Michael Witten <mfwitten@gmail.com>
> ---
>  t/t8001-annotate.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/t/t8001-annotate.sh b/t/t8001-annotate.sh
> index 45cb60e..68ac828 100755
> --- a/t/t8001-annotate.sh
> +++ b/t/t8001-annotate.sh
> @@ -8,7 +8,7 @@ PROG='git annotate'
>  
>  test_expect_success \
>      'Annotating an old revision works' \
> -    '[ $(git annotate file master | awk "{print \$3}" | grep -c "^A$") -eq 2 ] && \
> +    '[ $(git annotate file master | awk "{print \$3}" | grep -c "^A$") -eq 2 ] &&
>       [ $(git annotate file master | awk "{print \$3}" | grep -c "^B$") -eq 2 ]'

While this is not wrong per-se, I don't want to take too much half-way
churning.

If we were to properly do this, we should first rewrite it to use the more
modern style:

	test_expect_success 'Annotating an old revision works' '
		... test script comes here ...
        '

and just run annotate once without having any downstream pipe, i.e.

	git annotate file master >result &&
	awk "{ print \$3; }" <result >authors &&
	test 2 = $(grep A <authors | wc -l) &&
	test 2 = $(grep B <authors | wc -l)

so that we can catch breakage in "git annotate" itself more reliably
(e.g. even if the command showed two lines for each author, it is a
failure if the command itself did not exit with status 0).
