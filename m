From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation - pt-BR.
Date: Sun, 04 Oct 2009 18:53:49 -0700
Message-ID: <7vhbuek3ma.fsf@alter.siamese.dyndns.org>
References: <1253730339-11146-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 03:57:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mucpc-00077R-2V
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 03:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758286AbZJEByk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Oct 2009 21:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758279AbZJEByk
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 21:54:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36778 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758275AbZJEByj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Oct 2009 21:54:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9ED0E6AB2C;
	Sun,  4 Oct 2009 21:53:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xULNDfKM6aO4
	25+MIWVib7C/WJI=; b=tykzfnFKuGfic5E78OxZteiiw/yGsv5ZKDbkavUMwn/x
	6Mupc6tQkCpUs6xj7qTKbuaNetk50s02oA8iBv2E2rARKLeQP7fDdndD6GqVvXmS
	2nFxTiP4GzUw2M3Bm/O9Fpov4f4Hhps4DMURuJ5aFI89RXxrjB/ra146NYGNxcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QDLYqk
	mqDIwjFwlK1vYL/YNjOZ6kYNg30rnTlx9hTbIxWRZD03YBe/CN+XRZSy+RNE2o+K
	x/WfjEWUcaR/hXLxqB1MfoXHZpG9wCopm4KRivcnMQVdZaDw1LFGM4AasSAm+Q8/
	aQbtZ2htWOgB83nqeob6XvNJGoqu9hhQrqWsw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8115B6AB2B;
	Sun,  4 Oct 2009 21:53:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7155A6AB2A; Sun,  4 Oct 2009
 21:53:51 -0400 (EDT)
In-Reply-To: <1253730339-11146-1-git-send-email-tfransosi@gmail.com> (Thiago
 Farina's message of "Wed\, 23 Sep 2009 14\:25\:39 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F0020610-B151-11DE-AF7D-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129524>

Thiago Farina <tfransosi@gmail.com> writes:

> diff --git a/Documentation/pt_BR/gittutorial.txt b/Documentation/pt_B=
R/gittutorial.txt
> index 81e7ad7..beba065 100644
> --- a/Documentation/pt_BR/gittutorial.txt
> +++ b/Documentation/pt_BR/gittutorial.txt
> @@ -1,15 +1,15 @@
>  gittutorial(7)
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -NAME
> +NOME
>  ----
>  gittutorial - Um tutorial de introdu=C3=A7=C3=A3o ao git (para vers=C3=
=A3o 1.5.1 ou mais nova)
> =20
> -SYNOPSIS
> +SINOPSE
>  --------
>  git *
> =20
> -DESCRIPTION
> +DESCRI=C3=87=C3=83O
>  -----------

Not reading Portuguese, I have two comments.

 - How well does AsciiDoc and its manpage backend work with these stand=
ard
   section names localized?

 - The length of the underline must match the section header word it
   underlines.

Has anybody actually tried to format this document, either before or af=
ter
your patch?
