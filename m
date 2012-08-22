From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: quote string for translation before passing to
 eval_gettextln
Date: Wed, 22 Aug 2012 12:38:29 -0700
Message-ID: <7vipca7m4q.fsf@alter.siamese.dyndns.org>
References: <20120822141726.GA674@mannheim-rule.local>
 <1345646883-18746-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 21:38:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4GlG-0006pc-IH
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 21:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688Ab2HVTih convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Aug 2012 15:38:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47896 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817Ab2HVTif convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2012 15:38:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1230392DF;
	Wed, 22 Aug 2012 15:38:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Tm31020uY0bo
	mNRHDh/kFeTMsqM=; b=hdU7GsN94mTgJM8zOJ95sVnUXK6WlOGXlGFlEKmDTfID
	secShPUpopfRXIxntHexIDX7yxFuJaA86zJvv++3QFmSTslwgRXneX+K3gSIfkiC
	XIjbRkR4FmEq7oMzmzujdmzKBzvcGBgBQipNZcxCFZryPKa4cAaPe6jr2iboT4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mWbPh9
	TAgagMfeDEyA46p8A+W7KOToeQZ/8YRNiUjo0S6Bb96xW4BjHYtX79OIjk7sDc/3
	NAX3bI0J1jqn10tODCoYp+MV68UgGLvnv86mOLkdrrbYWE+h0fgGb6bqUAJmqwSP
	ukHaO/4J+DO/zD1lDvYGXhP6zN0nnaYfTFp0s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0092592DE;
	Wed, 22 Aug 2012 15:38:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5973492DD; Wed, 22 Aug 2012
 15:38:31 -0400 (EDT)
In-Reply-To: <1345646883-18746-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 22 Aug
 2012 21:48:03 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F42B5098-EC90-11E1-8975-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204085>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> If it's not quoted, the string is expanded before it gets looked up i=
n
> gettext database and obviously nothing is returned.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> ...
>  Yep. Verified. Also checked that no other places have this problem.
>  xgettext probably detects this too. Without this patch it does not
>  collect this string. With this patch, it does.

Will queue; thanks.

>
>  git-am.sh | 4 ++--
>  1 t=E1=BA=ADp tin =C4=91=C3=A3 b=E1=BB=8B thay =C4=91=E1=BB=95i, 2 =C4=
=91=C6=B0=E1=BB=A3c th=C3=AAm v=C3=A0o(+), 2 b=E1=BB=8B x=C3=B3a(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index bd9620c..c682d34 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -855,8 +855,8 @@ did you forget to use 'git add'?"
>  		eval_gettextln 'Patch failed at $msgnum $FIRSTLINE'
>  		if test "$(git config --bool advice.amworkdir)" !=3D false
>  		then
> -			eval_gettextln "The copy of the patch that failed is found in:
> -   $dotest/patch"
> +			eval_gettextln 'The copy of the patch that failed is found in:
> +   $dotest/patch'
>  		fi
>  		stop_here_user_resolve $this
>  	fi
