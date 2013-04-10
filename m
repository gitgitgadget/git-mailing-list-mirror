From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] archive: clarify explanation of --worktree-attributes
Date: Wed, 10 Apr 2013 11:56:21 -0700
Message-ID: <7vd2u2mcyy.fsf@alter.siamese.dyndns.org>
References: <CAFGOX=VXifkn4oNkqLLF_WG5Dzf4rjd15EV7C=9a_H9CTM+w2Q@mail.gmail.com>
 <7vk3obpfwc.fsf@alter.siamese.dyndns.org> <5165A645.9090300@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Amit Bakshi <ambakshi@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Apr 10 20:56:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ0C5-0003RA-1q
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 20:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847Ab3DJS4Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Apr 2013 14:56:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55569 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058Ab3DJS4Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Apr 2013 14:56:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7B6915C9D;
	Wed, 10 Apr 2013 18:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Idfhj9pzgPLC
	GDWE6psjRIUl1o0=; b=R6gwaAyZXck5eKPw2IbiVzm1hX4L6NfzifkcO6nmYYhl
	tJhQLttCWV88zH66terz6x/LCqsq4MhBxSTu87F1i47PoUOoDeZOciFzVgK8zJVs
	4lOEr9axhpuATB3mXhJ2m2VzUgwoiS+pasKavdHB6zM1ZAofH4S/agSJ+dZtM94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Fx8M5/
	sbg2MZlCIMgHvAzduyjRbxzPZXixuT+xqK2B08H9qTAZVF8BGFv9OGiqLRMwH0L0
	tuLpgtGzMkJzXCZNurlYTLmV57R1CM+3tek1NCZVgqG0iwQEKQL2UjWLb7YJOTwn
	Ce227Qs2iO/8DWuaH1wRz+SbJWMnkLoGoIglQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB62F15C9C;
	Wed, 10 Apr 2013 18:56:23 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCB9515C99; Wed, 10 Apr
 2013 18:56:22 +0000 (UTC)
In-Reply-To: <5165A645.9090300@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Wed, 10 Apr 2013 19:49:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56836764-A210-11E2-BDA5-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220721>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Make it a bit clearer that --worktree-attributes is about files in th=
e
> working tree (checked out files, possibly changed) and not the curren=
t
> working directory ($PDW).  Link to the ATTRIBUTES section, which has
> more details.
>
> Reported-by: Amit Bakshi <ambakshi@gmail.com>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
> Does this help a bit?

I personally thought that the original was already clear enough
(especially when taken in the context of Git), but the new wording
is not too verbose and should help avoiding misinterpretation.

Thanks.

>
>  Documentation/git-archive.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-archive.txt b/Documentation/git-archiv=
e.txt
> index b4c2e24..3dd3069 100644
> --- a/Documentation/git-archive.txt
> +++ b/Documentation/git-archive.txt
> @@ -56,7 +56,8 @@ OPTIONS
>  	Write the archive to <file> instead of stdout.
> =20
>  --worktree-attributes::
> -	Look for attributes in .gitattributes in working directory too.
> +	Look for attributes in .gitattributes files in the working tree
> +	as well (see <<ATTRIBUTES>>).
> =20
>  <extra>::
>  	This can be any options that the archiver backend understands.
