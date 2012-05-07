From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: remove lego in i18n string in gitdiff_verify_name
Date: Mon, 07 May 2012 11:00:44 -0700
Message-ID: <7vwr4n6fcj.fsf@alter.siamese.dyndns.org>
References: <xmqqehrbbf4s.fsf@junio.mtv.corp.google.com>
 <1336310002-3769-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 20:01:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRSEx-0000tm-80
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 20:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755250Ab2EGSAt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 14:00:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47502 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754518Ab2EGSAs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 14:00:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C63B69B3;
	Mon,  7 May 2012 14:00:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uNcEJA/AdezI
	N0HW2u/q2Q+nt/Q=; b=l88uurilzS4i6YBjG9qbMC9XOKATaPAW6Sy1OQZlz27o
	0FzmFpL6fcZEogbxL2uB9d2daNPJc7Pm3V3yLVsylBu3bA8cghVeKTdkGsGpm/EW
	kBL2tBQyRk3064RJtpOZbiReCT2ofq8V+2dMGI8kt3zlV1RETmZ25l3HLdCneyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Xqz3YW
	WeqJ+pURarEVYBj/gMGC0VRxrlwPjJpfTwHva4QCBZoRD1FfQCpWQ+vsIGp3xkEy
	Z67bBKmFEDr2WUa8ikq/Jxvbbq4jCoOzxbj7x1KM4R4YEpvBO2MXDSV/OFqcqBDW
	m8kZWSYn5p2Jl1UcGZ4NIiZfysy1SsQ87NVPY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72D3069B2;
	Mon,  7 May 2012 14:00:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0081069B0; Mon,  7 May 2012
 14:00:46 -0400 (EDT)
In-Reply-To: <1336310002-3769-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 6 May
 2012 20:13:22 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9289AA68-986E-11E1-B0E8-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197288>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Currently it marks the string "...inconsistent %s filename..." where
> %s is either "old" or "new" from caller. Make it two strings
> "...inconsistent new filename..." and "...inconsistent old filename..=
=2E"
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  On Thu, Apr 26, 2012 at 5:50 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>  > In this function, the parameter oldnew has "old" or "new" and the
>  > callers (gitdiff_oldname() and gitdiff_newname()) do not have it m=
arked
>  > for translation.  Even if they did, it would result in a lego
>  > composition, so you may have to switch between two translatable me=
ssages
>  > here.
>
>  Makes sense.
>
>  builtin/apply.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 725712d..1edd3f7 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -919,7 +919,7 @@ static int gitdiff_hdrend(const char *line, struc=
t patch *patch)
>   * their names against any previous information, just
>   * to make sure..
>   */
> -static char *gitdiff_verify_name(const char *line, int isnull, char =
*orig_name, const char *oldnew)
> +static char *gitdiff_verify_name(const char *line, int isnull, char =
*orig_name, int new)
>  {

This change is unwarranted, though.  The callers were much clearer when
they passed "old" vs "new"; now they pass an unexplained 0 vs 1.
