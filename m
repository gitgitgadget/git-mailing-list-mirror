From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/65] i18n: archive: mark parseopt strings for
 translation
Date: Tue, 29 May 2012 13:31:57 -0700
Message-ID: <7vr4u23f0i.fsf@alter.siamese.dyndns.org>
References: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
 <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 29 22:32:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZT5L-0001Rj-9V
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 22:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791Ab2E2UcB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 May 2012 16:32:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61452 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753719Ab2E2UcA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 May 2012 16:32:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 608079C48;
	Tue, 29 May 2012 16:31:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=b9X7iVOz1DKu
	LStBDAV325v5iwA=; b=fSoiWUrCDV1Uik6nKJ6E0cTVBkP79bP44HjLeyILuqSi
	398iDOpRA9qJ3O1W2kS45PU1N8Kktpv/FtshSy27Ia0muC4JYsLXpeLG9jh2LtCu
	WmZg45DHJKcRw7JgDf8nd5xcCOVp73wDvAr6vgcdaLwaZM3QuHRsVeLPnEie8Kc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=d4EMkZ
	JEYvXhGXaAHX9bUAcmY40y3JKTwhC5Byz9t0rBLm272LuKnptTPsflrWq8+Tte88
	Sm3YS7/3ds+rNn2tHRrj/hd8XKJzh7kP8naJR2lUYoEAXmKx5nnQAH6ULrEgbV7T
	fM+1RuBN+PrNRcJV2YZs1MpeqC59DffUGbS1g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56DA29C47;
	Tue, 29 May 2012 16:31:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA0369C46; Tue, 29 May 2012
 16:31:58 -0400 (EDT)
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 28 May
 2012 18:13:15 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56D0AC0E-A9CD-11E1-BB09-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198757>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  rc times are usually more quiet times, let's slip the series in..
>  minor conflict with revert topic in pu, but should be easy to
>  resolve.

"Yes", "no", and "does not matter".  I can buy this, though:

    Let's show this early, so that others are aware of this effort,
    and if they happen to be touching strings in the affected files,
    they can take one of these patches and roll it in their series
    when post 1.7.11 window opens.

> diff --git a/archive.c b/archive.c
> index a484433..2584324 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -7,10 +7,10 @@
>  #include "unpack-trees.h"
> =20
>  static char const * const archive_usage[] =3D {
> -	"git archive [options] <tree-ish> [<path>...]",
> -	"git archive --list",
> -	"git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [<=
path>...]",
> -	"git archive --remote <repo> [--exec <cmd>] --list",
> +	N_("git archive [options] <tree-ish> [<path>...]"),
> +	N_("git archive --list"),
> +	N_("git archive --remote <repo> [--exec <cmd>] [options] <tree-ish>=
 [<path>...]"),
> +	N_("git archive --remote <repo> [--exec <cmd>] --list"),
>  	NULL
>  };

I can understand the "help" text member of OPT_BLAH() construct, but
do we really want to translate the above?
