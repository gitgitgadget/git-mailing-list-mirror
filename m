From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] for-each-ref: fix description of '--contains' in manpage
Date: Wed, 30 Mar 2016 13:59:17 -0700
Message-ID: <xmqqlh4zsmvu.fsf@gitster.mtv.corp.google.com>
References: <1459345710-8088-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Mar 30 22:59:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alND3-0002RF-RG
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 22:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695AbcC3U7V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Mar 2016 16:59:21 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55897 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751394AbcC3U7U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Mar 2016 16:59:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5FB8451614;
	Wed, 30 Mar 2016 16:59:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=SzrB9i1hGOyf
	YdepHmEZtlsD7IA=; b=UfX1KdnBncOL1j78BnM5xUXo9QOSJdj+3t4nwzbnJS2s
	9d8z33GwXkPDN9Jb5RF7Q2dmxHGZ6veAv4bKQdUcZ8fyPVEa3ZsfqtRxe5mVcead
	259KREKZv/M9Z0gnZKw5heLES0e46OsmI79ULK4D//dp8YK0Yv1u3CxkqLG9C74=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gm/juf
	HB1HoEIS6WNm8HIdOa5/zsGsjiN+p+2fBPngArH2iUzywkWFsGuEMlnGU4kSxYlA
	eXfYs087AZvu5dYsFS89S0caWLIIhZPvpjr/50aGAK67TPZs38gL2HarQrGdnccL
	mH5sQUp3rrHwInwwHdXk4EsD+jfCelD6fOmyI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5655C51613;
	Wed, 30 Mar 2016 16:59:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C137F51611;
	Wed, 30 Mar 2016 16:59:18 -0400 (EDT)
In-Reply-To: <1459345710-8088-1-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Wed, 30 Mar 2016 15:48:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4515E4A0-F6BA-11E5-8337-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290347>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> 'git for-each-ref's manpage says that '--contains' only lists tags,
> but it lists all kinds of refs.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---

Thanks; will apply on top of 4a71109a (for-each-ref: add
'--contains' option, 2015-07-07) so that we can eventually
include it in 2.7.x maintenance track.

>  Documentation/git-for-each-ref.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-f=
or-each-ref.txt
> index 012e8f9a080d..c52578bb87cc 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -76,7 +76,7 @@ OPTIONS
>  	specified commit (HEAD if not specified).
> =20
>  --contains [<object>]::
> -	Only list tags which contain the specified commit (HEAD if not
> +	Only list refs which contain the specified commit (HEAD if not
>  	specified).
> =20
>  FIELD NAMES
