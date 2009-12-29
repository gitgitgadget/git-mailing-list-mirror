From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: commit: explain the non-meaning of S-o-b
Date: Mon, 28 Dec 2009 23:54:15 -0800
Message-ID: <7voclimd08.fsf@alter.siamese.dyndns.org>
References: <20091228194001.7b4c68f4@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Tue Dec 29 08:54:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPWuS-0000Ng-Ut
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 08:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbZL2HyY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2009 02:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbZL2HyY
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 02:54:24 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41239 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbZL2HyX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Dec 2009 02:54:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 79FD5AA853;
	Tue, 29 Dec 2009 02:54:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=K4kZRBtw8js0
	Q0C5WdM5XnTONQo=; b=OzPw6COeSd+VyiDP1ZCaCZzaIFjPy3/goWAxW1Xp87m9
	cONjfW9aSmonHceeV/5mLg/EBAcViAa0aCx3aNBQIoLWiIXk2D/g7+0Ten2+g/6D
	IPwLcIDLZNfQW0GZ1zuX+WrCcVNTb70+sGHkwGaEMn5QHTZGqKLiMP4zw6k6jlw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=s++UT9
	RvfDMtdIrQD9H2h1QXPsNm0B3K8bHgHZM8jeiv9hrfAd6c4U4iFrBXCx16hJ16ZT
	j6wvKN/tZJQ3WR03nPxOcAgLKjmKJ8m4xxDeowE0uXZhp3ngQllBpKHY8Ah2SJKf
	D/AUFEas1BZ2eNqPOV1Aox1j9inLZ+IHMpjG4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 58D71AA852;
	Tue, 29 Dec 2009 02:54:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6593BAA851; Tue, 29 Dec 2009
 02:54:17 -0500 (EST)
In-Reply-To: <20091228194001.7b4c68f4@perceptron> ("Jan =?utf-8?Q?Kr=C3=BC?=
 =?utf-8?Q?ger=22's?= message of "Mon\, 28 Dec 2009 19\:40\:01 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5F207366-F44F-11DE-8CBC-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135781>

Jan Kr=C3=BCger <jk@jk.gs> writes:

> In the manpage for git commit, the option --signoff is mentioned but
> there is no explanation of what it actually means. Add a brief hint t=
hat
> S-o-b doesn't have a pre-defined meaning.

The commands am, cherry-pick, commit, format-patch, and revert all shar=
e
the "sign-off" and they more or less deliberately refused to define wha=
t
it means to sign-off a patch; as your patch says, it is up to the proje=
ct
policy.

config.txt gives a description for format.signoff option that is too
specific to git and the kernel, which I think is a mistake given the mu=
ch
wider audience we have these days.

How similar should the document for the "sign-off" options to these
commands be?  I am wondering if we should have the same description cop=
ied
and pasted to all of them, or avoid repeating ourselves and instead hav=
e
them refer to a central place, perhaps somewhere in the Tutorial or the
Workflow document.


> Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
> ---
> Semi-resend. Nobody commented on this when I first sent it in early
> December, so here it is again, with a slightly more verbose
> explanation. The repetition is intentional.
>
>  Documentation/git-commit.txt |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.=
txt
> index d227cec..cae510b 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -114,7 +114,10 @@ OPTIONS
>  -s::
>  --signoff::
>  	Add Signed-off-by line by the committer at the end of the commit
> -	log message.
> +	log message. This line has no inherent meaning; it is up to the
> +	potential recipient of the commit to decide what it stands for.
> +	It is typically understood as an assurance by the committer that
> +	the commit conforms to the receiving project's commit guidelines.
> =20
>  -n::
>  --no-verify::
> --=20
> 1.6.5.3.171.ge36e
