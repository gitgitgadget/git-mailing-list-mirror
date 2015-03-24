From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.txt: list index versions in plain English
Date: Tue, 24 Mar 2015 08:06:30 -0700
Message-ID: <xmqqd23y8mfd.fsf@gitster.dls.corp.google.com>
References: <1427156913-4491-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 16:06:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaQPf-0005f8-3o
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 16:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbbCXPGf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2015 11:06:35 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52093 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752580AbbCXPGe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2015 11:06:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 43E5D3F58A;
	Tue, 24 Mar 2015 11:06:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aqxgpnNtqjP8
	PiA4gWrd/fMsD+8=; b=qsDhIElK4/OT30qFqLTMC2PaI4xgVxn78h1EzYtoVb6E
	pEL0WH8yc9ADPEkfcVMuJMOrkMkFJnxCsB3ZZHbddz2/p9GWIH4TP2Gbvx92mdZi
	wYUFAn6icchF3PBWbuCelf6lC2uQtvyXcnuYAx/fN1e0iopG+lmBd9Yl0hR+UlA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WsIzlV
	Nq+hlhIzIhGsDWPyaENL1bRDJtIJeGcECflt0d4XaUCCUpLpLpun9fWAHRxQlJ6z
	RRHwSVqJ+RPaTnR7Np6Rj+9nvSmDL301Emx0XnV82gZIaFEKD9MlsUx1aDXBSoMI
	majzc2T8G632Kp+JL+LY6BHLkYslFh9rrLxUA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CE383F589;
	Tue, 24 Mar 2015 11:06:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 931FC3F588;
	Tue, 24 Mar 2015 11:06:32 -0400 (EDT)
In-Reply-To: <1427156913-4491-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 24
 Mar 2015 07:28:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5B62827A-D237-11E4-9616-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266190>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> At the first look, a user may think the default version is "23". Even
> with UNIX background, there's no reference anywhere close that may
> indicate this is glob or regex.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Thanks.

>  Documentation/git.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index b37f1ab..29d9257 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -766,7 +766,8 @@ Git so take care if using Cogito etc.
>  'GIT_INDEX_VERSION'::
>  	This environment variable allows the specification of an index
>  	version for new repositories.  It won't affect existing index
> -	files.  By default index file version [23] is used.
> +	files.  By default index file version 2 or 3 is used. See
> +	linkgit:git-update-index[1] for more information.
> =20
>  'GIT_OBJECT_DIRECTORY'::
>  	If the object storage directory is specified via this
