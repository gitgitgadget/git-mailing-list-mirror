From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-tag.txt: <commit> for --contains is optional
Date: Tue, 04 Feb 2014 10:36:07 -0800
Message-ID: <xmqq8utqafoo.fsf@gitster.dls.corp.google.com>
References: <1391482586-26444-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 19:36:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAkr2-0005zz-P2
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 19:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505AbaBDSgN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Feb 2014 13:36:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50525 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753487AbaBDSgM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Feb 2014 13:36:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B92AA6837F;
	Tue,  4 Feb 2014 13:36:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=p+4/UzpMzuav
	eNvn5Y5kVovfmi0=; b=mLSmlvLL2NixjlRTxkGAkUbumDyaLnXCQxJIsWPu05o/
	xWERNm7xb91ivhivjv6Blb9OFpdfQkz00M1pb2t/yubX7RuUXBRVBA9iL/Oio6MK
	MK7hpDYUNZ4dAFhoDqm/a5EbXbTsvsKIsw4hUD45Jiq5ipr+bAKmhGPzE9ED/Mw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sprNFP
	y+3/DqWvHFuv0Nds1ip1dEfaD+UtOOMBFhNpnyd6nbx5CUISr+PkSxikx31G2BG1
	9vyEIXV2SaKzMMC5fL5Tm5TwHxDvLBbU1Hs7ELgbQrEU4u/cyYXThbGAVImBdeUi
	N4P56uOwvXrxYqM+FEMb/ZNTPlgcwOi7Rrhe4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E9006837C;
	Tue,  4 Feb 2014 13:36:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AC4E68379;
	Tue,  4 Feb 2014 13:36:09 -0500 (EST)
In-Reply-To: <1391482586-26444-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 4 Feb
 2014 09:56:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 37314096-8DCB-11E3-8416-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241537>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This goes far back to e84fb2f (branch --contains: default to HEAD -
> 2008-07-08) where the same parsing code is shared with
> builtin/tag.c. git-branch.txt correctly states that <commit> for
> --contains is optional while git-tag.txt does not. Correct it.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/git-tag.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index c418c44..404257d 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -103,8 +103,9 @@ OPTIONS
>  +
>  This option is only applicable when listing tags without annotation =
lines.
> =20
> ---contains <commit>::
> -	Only list tags which contain the specified commit.
> +--contains [<commit>]::
> +	Only list tags which contain the specified commit (HEAD if not
> +	specified).

Thanks.

> =20
>  --points-at <object>::
>  	Only list tags of the given object.
