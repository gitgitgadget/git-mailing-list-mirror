From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] pack-protocol.txt: clarify 'obj-id' in the last ACK after 'done'
Date: Thu, 06 Feb 2014 10:54:31 -0800
Message-ID: <xmqqlhxoysuw.fsf@gitster.dls.corp.google.com>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
	<1391699439-22781-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 19:54:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBU63-00041P-BM
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 19:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778AbaBFSyn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Feb 2014 13:54:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59152 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751715AbaBFSym convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Feb 2014 13:54:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04BC668D6E;
	Thu,  6 Feb 2014 13:54:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wLP9aUqDDXPn
	F+TtLgPxEKpFg5M=; b=dZj+CoqFINCdBc55n2eYyddg4TSJPN99/ntFh+S4PWMt
	0WF0HOhlSDRLsCcD5d0OPXa3nM7ZPjYvdMts2yrUvYBeCX0Bv+bAPLJIvyMrllo2
	wO2N0ipG9wZijHODdMg/V2tl8t68GNhFpgPJp6asz/fehxPg0lXAM6u/CWx1wUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aWGy5G
	czSKW6mZLKRLuUFObyoAzFPUC6U14J08LbqfAoaOreR3MLDJjXjGCnDMlMXTzCqi
	GkbZv+EW6r/WKY2Yjvntcczc5z+srFuhakn75yTs5btUMF3hQ7OgmssOMrFQ8px0
	FXeeDAEI2MPtEK2o6TF5ftxXEA2fQigRvqzoM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0DEC68D6D;
	Thu,  6 Feb 2014 13:54:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA6E068D67;
	Thu,  6 Feb 2014 13:54:34 -0500 (EST)
In-Reply-To: <1391699439-22781-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 6 Feb
 2014 22:10:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1EC4D216-8F60-11E3-8E1A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241710>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> It's introduced in 1bd8c8f (git-upload-pack: Support the multi_ack
> protocol - 2005-10-28) but probably better documented in the commit
> message of 78affc4 (Add multi_ack_detailed capability to
> fetch-pack/upload-pack - 2009-10-30)
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/technical/pack-protocol.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/technical/pack-protocol.txt b/Documentatio=
n/technical/pack-protocol.txt
> index c73b62f..eb0b8a1 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -338,7 +338,8 @@ during a prior round.  This helps to ensure that =
at least one common
>  ancestor is found before we give up entirely.
> =20
>  Once the 'done' line is read from the client, the server will either
> -send a final 'ACK obj-id' or it will send a 'NAK'. The server only s=
ends
> +send a final 'ACK obj-id' or it will send a 'NAK'. 'obj-id' is the
> +last SHA-1 determined to be common. The server only sends

I'd suggest rewording it to:

    'obj-is' is the object name of the last commit determined to be com=
mon

I do not mind too much if it used colloquial "SHA-1" in place of
"object name", but what is common is not the name but the object the
name refers to, so "the last commit" part is a moderately strong
suggestion.

Thanks.
