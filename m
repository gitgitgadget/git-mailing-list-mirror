From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 09/15] t5602 (clone-remote-exec): add missing &&
Date: Wed, 29 Sep 2010 12:09:50 -0700
Message-ID: <7vzkv0mkn5.fsf@alter.siamese.dyndns.org>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
 <1285542879-16381-10-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 21:10:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P122W-0000w5-6N
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 21:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642Ab0I2TJ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 15:09:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47872 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528Ab0I2TJ5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 15:09:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 608DBDA3C4;
	Wed, 29 Sep 2010 15:09:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=99q7BxX/N0sW
	tUjWk0pS7f7bjpA=; b=mt0TlRAC4k0C6A7ZauGcz8n7EgPRwPBfyNhbaWbkke6m
	wCacx4EsanXGApXEEO5o073mW/QXW/tMvR9jXq8pxfpXW/FgGTdM4eSp9rRjm+9t
	072dJ2YFasclLy693Nit+LXQI3H3hpjKQKS9p8rBKyirMG8pdn+dN6ubfp+ZELs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LsXkdM
	0vjLIbS2SJsekb8vT6xWY/E4N68QDLpf58UT8KJrSh74rgqj6M18m/qPBBKDHlbC
	ARIDJcMGtllNULG6NzCE1aN5LjVtHYwlgdauNgEEsUqKpqRUzRgAOIOXRKQkOy7F
	obQzcCjSMYetDl42KKA+TS3NGXuuarlj9f8cw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C354DA3C3;
	Wed, 29 Sep 2010 15:09:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E45F6DA3C2; Wed, 29 Sep
 2010 15:09:51 -0400 (EDT)
In-Reply-To: <1285542879-16381-10-git-send-email-newren@gmail.com> (Elijah
 Newren's message of "Sun\, 26 Sep 2010 17\:14\:33 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 24FE00BE-CBFD-11DF-8943-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157590>

Elijah Newren <newren@gmail.com> writes:

> Also add a couple test_must_fail invocations where needed.
>
> Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t5602-clone-remote-exec.sh |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/t/t5602-clone-remote-exec.sh b/t/t5602-clone-remote-exec=
=2Esh
> index deffdae..6aa6e0d 100755
> --- a/t/t5602-clone-remote-exec.sh
> +++ b/t/t5602-clone-remote-exec.sh
> @@ -5,21 +5,21 @@ test_description=3Dclone
>  . ./test-lib.sh
> =20
>  test_expect_success setup '
> -	echo "#!/bin/sh" > not_ssh
> -	echo "echo \"\$*\" > not_ssh_output" >> not_ssh
> -	echo "exit 1" >> not_ssh
> +	echo "#!/bin/sh" > not_ssh &&
> +	echo "echo \"\$*\" > not_ssh_output" >> not_ssh &&
> +	echo "exit 1" >> not_ssh &&
>  	chmod +x not_ssh
>  '
> =20
>  test_expect_success 'clone calls git upload-pack unqualified with no=
 -u option' '
> -	GIT_SSH=3D./not_ssh git clone localhost:/path/to/repo junk
> -	echo "localhost git-upload-pack '\''/path/to/repo'\''" >expected
> +	GIT_SSH=3D./not_ssh test_must_fail git clone localhost:/path/to/rep=
o junk &&

I think this suffers from the same issue that have been fixed with 09b7=
8bc
(t7502-commit.sh: rearrange test to make more portable, 2008-07-22) and
2d60615 (tests: Avoid single-shot environment export for shell function
invocation, 2009-01-26).

> +	echo "localhost git-upload-pack '\''/path/to/repo'\''" >expected &&
>  	test_cmp expected not_ssh_output
>  '
> =20
>  test_expect_success 'clone calls specified git upload-pack with -u o=
ption' '
> -	GIT_SSH=3D./not_ssh git clone -u ./something/bin/git-upload-pack lo=
calhost:/path/to/repo junk
> -	echo "localhost ./something/bin/git-upload-pack '\''/path/to/repo'\=
''" >expected
> +	GIT_SSH=3D./not_ssh test_must_fail git clone -u ./something/bin/git=
-upload-pack localhost:/path/to/repo junk &&

So does this.

> +	echo "localhost ./something/bin/git-upload-pack '\''/path/to/repo'\=
''" >expected &&
>  	test_cmp expected not_ssh_output
>  '
> =20
> --=20
> 1.7.3.95.g14291
