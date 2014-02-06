From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] protocol-capabilities.txt: document no-done
Date: Thu, 06 Feb 2014 10:55:58 -0800
Message-ID: <xmqqha8cyssh.fsf@gitster.dls.corp.google.com>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
	<1391699439-22781-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 19:56:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBU7M-0005Dw-Uw
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 19:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756655AbaBFS4D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Feb 2014 13:56:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41467 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753808AbaBFS4C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Feb 2014 13:56:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B22A568E4E;
	Thu,  6 Feb 2014 13:56:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=e8rRYTR1mJX/
	bqp2MSdrgwsGlxk=; b=URd4RRXt1SAMxb84kjMzuwTNBtRrabza77ysPKfn24G0
	eu2ObVSjGDdKAq2vVvzbJGms9aHkuyrOZh9Xg/iTLxd2b6Dv+DjDVTjJLxOB9Fde
	cx7NJBwE3T3sJEl0i80GB4VEJHOk0FSz4crBBhXhWpdzk5OUmlR/pIknaHkKp68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GYiBdA
	EyiLcij2atRMcb2Tb/vVeIOfFvbovbk0NX7uT73vNC4QHOkBM0oXqFcJq6Dn1j+g
	vj446iNECoYfcQ63M+bK1Gvz2uN28uWFuGdzWsfv93Wtyqp3fe3Rv2378pWWN6+g
	Z7kS/ZX11inMDfS37J9PQfYZlmhKMIsYTVSBE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 635B168E4D;
	Thu,  6 Feb 2014 13:56:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8DEFC68E49;
	Thu,  6 Feb 2014 13:55:59 -0500 (EST)
In-Reply-To: <1391699439-22781-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 6 Feb
 2014 22:10:38 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 515C7A8A-8F60-11E3-81E5-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241711>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> See 3e63b21 (upload-pack: Implement no-done capability - 2011-03-14)
> and 761ecf0 (fetch-pack: Implement no-done capability - 2011-03-14)
> for more information.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/technical/protocol-capabilities.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/technical/protocol-capabilities.txt b/Docu=
mentation/technical/protocol-capabilities.txt
> index cb40ebb..cb2f5eb 100644
> --- a/Documentation/technical/protocol-capabilities.txt
> +++ b/Documentation/technical/protocol-capabilities.txt
> @@ -75,6 +75,18 @@ This is an extension of multi_ack that permits cli=
ent to better
>  understand the server's in-memory state. See pack-protocol.txt,
>  section "Packfile Negotiation" for more information.
> =20
> +no-done
> +-------
> +This capability should be only used with smart HTTP protocol. If
> +multi_ack_detailed and no-done are both present, then the sender is
> +free to immediately send a pack following its first "ACK obj-id read=
y"
> +message.
> +
> +Without no-done in smart HTTP protocol, the server session would end
> +and the client has to make another trip to send "done" and the serve=
r
> +can send the pack. no-done removes the last round and thus slightly
> +reduces latency.
> +
>  thin-pack
>  ---------

Looks good; thanks.
