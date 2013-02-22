From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] index-format.txt: mention of v4 is missing in some
 places
Date: Fri, 22 Feb 2013 12:46:44 -0800
Message-ID: <7vr4k8cc0b.fsf@alter.siamese.dyndns.org>
References: <1361534964-4232-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 21:47:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8zWW-0007aF-DM
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 21:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757138Ab3BVUqv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2013 15:46:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51049 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756998Ab3BVUqv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Feb 2013 15:46:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A77AB5F9;
	Fri, 22 Feb 2013 15:46:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VfMJ3QBd4p8J
	XZWVUbC7NCrBd7I=; b=HQhcp8Fu2rvJe3tkBYx/Gz/QMl4fpXFc2IFipn15e+E2
	KMVsNXdFam90QmfelVN5aL4G4B4Lz6oC4G6C2c3ZsRcnyhNa0ZS1qq3RZNpuVQh2
	/tzcWbDLUHTwSnlSwcnIXRFWSW7xZAkDcdStugk1Oj7E6CJv3280twjgg2wp0gw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TgY/mo
	JD3zS0JiTUewWfaMrlHdnLXn/UAw4g2+HDZntglq6IPcqz3ezhJaQS3GemS5FCdM
	O2RfZa2fOSeSlW7l6prwZg2JhwOI+e9mf1bQCBgSHBTj0Pttcnx0Iq6Qa+AADYPH
	zo59WHp1TZXxu0/gRYX3A7FdX098Fe3E9B+zM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8654FB5F8;
	Fri, 22 Feb 2013 15:46:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 048BEB5F7; Fri, 22 Feb 2013
 15:46:49 -0500 (EST)
In-Reply-To: <1361534964-4232-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 22 Feb
 2013 19:09:23 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB2A0430-7D30-11E2-B22B-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216859>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/technical/index-format.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/technical/index-format.txt b/Documentation=
/technical/index-format.txt
> index 27c716b..0810251 100644
> --- a/Documentation/technical/index-format.txt
> +++ b/Documentation/technical/index-format.txt
> @@ -12,7 +12,7 @@ Git index format
>         The signature is { 'D', 'I', 'R', 'C' } (stands for "dircache=
")
> =20
>       4-byte version number:
> -       The current supported versions are 2 and 3.
> +       The current supported versions are 2, 3 and 4.
> =20
>       32-bit number of index entries.
> =20
> @@ -93,8 +93,8 @@ Git index format
>      12-bit name length if the length is less than 0xFFF; otherwise 0=
xFFF
>      is stored in this field.
> =20
> -  (Version 3) A 16-bit field, only applicable if the "extended flag"
> -  above is 1, split into (high to low bits).
> +  (Version 3 or later) A 16-bit field, only applicable if the
> +  "extended flag" above is 1, split into (high to low bits).
> =20
>      1-bit reserved for future

Depending on how the first later version decides to encode the
additional flag information, "or later" may need to be changed to
"and 4" when it happens.  As we cannot predict the future, I think
"or later" is just as good as "add 4" for now.

Thanks.
