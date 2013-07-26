From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/4] document 'allow-tip-sha1-in-want' capability
Date: Fri, 26 Jul 2013 08:36:02 -0700
Message-ID: <7vsiz12v19.fsf@alter.siamese.dyndns.org>
References: <20130724080342.GD4425@sigill.intra.peff.net>
	<1374836514-17741-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 17:36:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2k3x-0001aN-SV
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 17:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757783Ab3GZPgK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jul 2013 11:36:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34414 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755643Ab3GZPgH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jul 2013 11:36:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF59B32765;
	Fri, 26 Jul 2013 15:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kp1pc56C7RV2
	AUwrYuc2UHWOh4A=; b=TMaZaZzpCwncww1SGFolWQWyQf4Z20EweR2m2tKslSo6
	/nUfdx61Q4HwZxbpOXh8O8p5ArqtmbdJ7CgDv66tH31DjI3D2uY2tFHA/pCs9lP9
	VYiA6rLRXx0t/oStYq7f/aUnVeYIZx591Uw7q2PWpaARV5Beahsd4f97fVFsDko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=S/HuCw
	k8bAYDXhNrivQgeHP+N8dzJmtXVRn9ZdQmki/RLz9UNA+b4PQLBMRKktEqk3R0Ce
	SL4+JP8NthmCqKvW8ULv7isatYhWClTYrimXkfEHg+nXEdZhTR4TiCuhSi4bsKmd
	Ahv5MlPqJBk6iw8W0pLC5s41duTV0YYXt5hWw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A619F32764;
	Fri, 26 Jul 2013 15:36:05 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED01832763;
	Fri, 26 Jul 2013 15:36:04 +0000 (UTC)
In-Reply-To: <1374836514-17741-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 26
 Jul 2013 18:01:54 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1577292A-F609-11E2-B9E5-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231188>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> See 390eb36 (upload-pack: optionally allow fetching from the tips of
> hidden refs - 2013-01-28) for more information.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Maybe this too for completeness..

You are absolutely right, and this exists only on the fetch vs
upload-pack side, so there is no need to update the introductory
text and the change in this patch is sufficient and complete.

Thanks.

>  Documentation/technical/protocol-capabilities.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/technical/protocol-capabilities.txt b/Docu=
mentation/technical/protocol-capabilities.txt
> index ec131b6..31cbe07 100644
> --- a/Documentation/technical/protocol-capabilities.txt
> +++ b/Documentation/technical/protocol-capabilities.txt
> @@ -210,3 +210,10 @@ be shown when processing the received pack. A se=
nd-pack client should
>  respond with the 'quiet' capability to suppress server-side progress
>  reporting if the local progress reporting is also being suppressed
>  (e.g., via `push -q`, or if stderr does not go to a tty).
> +
> +allow-tip-sha1-in-want
> +----------------------
> +
> +If the upload-pack server advertises this capability, fetch-pack may
> +send "want" lines with SHA-1s that exist at the server but are not
> +advertised by upload-pack.
