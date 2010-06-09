From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/ PATCH 4/5] t3030: update porcelain expected message
Date: Wed, 09 Jun 2010 09:51:21 -0700
Message-ID: <7vvd9sno8m.fsf@alter.siamese.dyndns.org>
References: <1276087446-25112-1-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-2-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-3-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-4-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-5-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-6-git-send-email-diane.gasselin@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
To: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 09 18:51:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMOV8-0001ep-QI
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 18:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757989Ab0FIQvd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 12:51:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55077 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242Ab0FIQvc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 12:51:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 838CEBA7C4;
	Wed,  9 Jun 2010 12:51:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=KywM+5BLrGM3PpblKh3drQs+c
	F8=; b=FjXnH9V1F1a8j2tysItC7/rFIA/AvnagWTz4dsaP7iGo10GsT3e36oWgz
	TH2CGo//7/Ysw8s7H0lG0Xd8PC9H8unLZPPNMuH++N7yVvYs6mQgxNoMu14WNvx8
	zwehBmwI4AZJaf+efeNIOajeuUXT8wyNUSMVvzO55/UMzHPSYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=i4LBdedQiiE79uQ6CmS
	1q06QhonkICOm6SO2vOhffkk+X6liJ8NQxnise1IvVEf5lsBDmYclNC/CEspz9nl
	f8sdkK9HndCLPygP71onjw0oav1zQxAJdOskjVpltsXB2iRdcWQzgJbm2AQvWSyO
	Y4OH5O+7Zriq4UFe1SIOrFTs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BD14BA7C0;
	Wed,  9 Jun 2010 12:51:28 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A555BA7AF; Wed,  9 Jun
 2010 12:51:23 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3F5DD8EE-73E7-11DF-9E06-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148793>

Diane Gasselin <diane.gasselin@ensimag.imag.fr> writes:

> From: Diane <diane.gasselin@ensimag.imag.fr>
>
> As porcelain messages have been changed, the expected porcelain messa=
ge
> tested in this test needs to be changed.
>
> Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
> Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
> Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
> ---
>  t/t3030-merge-recursive.sh |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
> index 9929f82..9ac5df8 100755
> --- a/t/t3030-merge-recursive.sh
> +++ b/t/t3030-merge-recursive.sh
> @@ -268,6 +268,11 @@ test_expect_success 'merge-recursive result' '
>  	test_cmp expected actual
> =20
>  '
> +cat> expected2 <<EOF

Style:

 (1) redirection ">" and "<" stick to the target file and have a SP on =
the
     other end.

 (2) if you are not actively $substituting inside here document,
     quote EOF to assure readers that nothing funny is going on.

i.e.

	cat >expected2 <<\EOF
        ... your HERE document here ...
	EOF

The same comment applies to [PATCH 5/5].  Also when you want to create =
an
empty file, don't use "touch F"; say ">F" instead.

> -	grep "Your local changes to .* would be overwritten by merge." out
> +	grep -A 2 "Your local changes to" out > tmp &&

I think "grep -A $n" is a GNUism, not even in POSIX.  Avoid it.

Perhaps

	sed -n "/^Your local changes to/,\$p" out >tmp &&
