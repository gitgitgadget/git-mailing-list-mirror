From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] README: use markdown syntax
Date: Tue, 23 Feb 2016 11:07:34 -0800
Message-ID: <xmqqoab71c09.fsf@gitster.mtv.corp.google.com>
References: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
	<1456249229-30454-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, emma.westby@gmail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Feb 23 20:07:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYIJE-0002L7-Qu
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 20:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535AbcBWTHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 14:07:39 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51025 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752099AbcBWTHh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 14:07:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C3A3844B5A;
	Tue, 23 Feb 2016 14:07:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YenZl2fxUUCxYiC4NryARBlEoY4=; b=KwRy46
	h8l7wa00XmN4qzckfLkSQAG8bR7H0xbH841X4+//Rz2MmL574DMTEViAeNKMRurE
	uIdwTlRZ21ko6Fyt5x+3t+gJZnNduy2aNIpf73jvFstg3qrGSSX6bECH1IeBLunG
	plZ0rOy0jzHjsYcp7wnxOIFnNkRBUZF0DZSts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=URI2KLiZsWUri9WGCR+TzCjF3hPij5aH
	q89It7LsCFEPQNIaCn0H7GQasSX2G17kSFg9qt3LNSihaakQO1LjmjU+Vhu0XVcy
	uBT2Qaa/4lvH28rQdH1lKbLAy1q3ICeM+alK7XMOWN0xzJBH5T0VUvyv1NaRXILn
	/bqfIW/enUg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BB58444B59;
	Tue, 23 Feb 2016 14:07:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 151C544B56;
	Tue, 23 Feb 2016 14:07:36 -0500 (EST)
In-Reply-To: <1456249229-30454-2-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Tue, 23 Feb 2016 18:40:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B316927C-DA60-11E5-8900-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287101>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> This allows repository browsers like GitHub to display the content of
> the file nicely formatted.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---

To be honest, I have the most problem with this step in the whole
series.

Markdown when rendered may be easier to read, but plain text is even
easier, and it somehow feels backward to cater to those who browse
at GitHub sacrificing those who use "less" in the source tree.

>  README => README.md | 6 +-----
>  t/t7001-mv.sh       | 2 +-
>  2 files changed, 2 insertions(+), 6 deletions(-)
>  rename README => README.md (93%)
>
> diff --git a/README b/README.md
> similarity index 93%
> rename from README
> rename to README.md
> index 1083735..907eb3b 100644
> --- a/README
> +++ b/README.md
> @@ -1,8 +1,4 @@
> -////////////////////////////////////////////////////////////////
> -
> -	Git - the stupid content tracker
> -
> -////////////////////////////////////////////////////////////////
> +# Git - the stupid content tracker
>  
>  "git" can mean anything, depending on your mood.
>  
> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> index 51dd2b4..4008fae 100755
> --- a/t/t7001-mv.sh
> +++ b/t/t7001-mv.sh
> @@ -102,7 +102,7 @@ test_expect_success \
>  
>  test_expect_success \
>      'adding another file' \
> -    'cp "$TEST_DIRECTORY"/../README path0/README &&
> +    'cp "$TEST_DIRECTORY"/../README.md path0/README &&
>       git add path0/README &&
>       git commit -m add2 -a'
