From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/8] t/README: Tests are all +x, ./test, not sh ./test
Date: Thu, 01 Jul 2010 16:54:14 -0700
Message-ID: <7v7hle3gih.fsf@alter.siamese.dyndns.org>
References: <1278015478-6920-1-git-send-email-avarab@gmail.com>
 <1278015478-6920-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 01:54:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUTaP-0001Nr-CN
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 01:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613Ab0GAXyY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 19:54:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51297 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab0GAXyX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jul 2010 19:54:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CAD1C0ECA;
	Thu,  1 Jul 2010 19:54:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bJpX784JuWVz
	EZ2j5Kd8Vt62ztA=; b=colQv5LAvcKQoKnJI81RFPOncAw5a34wZWqmYuRfGMzD
	bWxMsKMk0ILn3JeONoVmZIbGqOAkHA8ZoDWrRY/IBemyRwnz+wx4ziILLBWQ90IP
	NsaYi7Yw1V3siIQUQ0R04WdxZow9MlPIK2S9bnQtfG37C6dgg5fofuLPqUc1MgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=v/FNxq
	Pcz0MnGuw85W4AbC+C2IFiw6Azshcq+pCXqB2FnRy1WTaBoZw0s02/w90vZQt5iR
	Nf1juNtpmewptqVn0tWrpdowRO1sagZ/Gz06fGDzZSmuClwfWGE/m30/dmkgIA5O
	IdFJjJwoYj4mWRPbOon0A/ur8lM2ksBKMpKUk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BF37C0EC9;
	Thu,  1 Jul 2010 19:54:20 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E971DC0EC5; Thu,  1 Jul
 2010 19:54:15 -0400 (EDT)
In-Reply-To: <1278015478-6920-2-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu\,  1 Jul
 2010 20\:17\:51 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F762A04C-856B-11DF-8304-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150091>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> test-lib.sh runs tests with $SHELL_PATH or the #!/bin/sh shebang when
> run under prove. It's simpler to just show ./ as an example.

I don't think this is a good change at all.  If we spell "sh" out, peop=
le
with defective shell as the default shell on their system at least woul=
d
know that they need to substitute that with "ksh" or "bash" or whatever=
=2E

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> ---
>  t/README |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/t/README b/t/README
> index aa4ed28..b378ab1 100644
> --- a/t/README
> +++ b/t/README
> @@ -52,7 +52,7 @@ prove and other harnesses come with a lot of useful=
 options. The
> =20
>  You can also run each test individually from command line, like this=
:
> =20
> -    $ sh ./t3010-ls-files-killed-modified.sh
> +    $ ./t3010-ls-files-killed-modified.sh
>      ok 1 - git update-index --add to add various paths.
>      ok 2 - git ls-files -k to show killed files.
>      ok 3 - validate git ls-files -k output.
> --=20
> 1.7.1.251.g92a7
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
