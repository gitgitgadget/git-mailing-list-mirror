From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] blame: remove obsolete comment
Date: Mon, 28 Dec 2015 09:35:53 -0800
Message-ID: <xmqqmvsulbly.fsf@gitster.mtv.corp.google.com>
References: <1451181092-26054-1-git-send-email-pclouds@gmail.com>
	<1451181092-26054-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 18:36:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDbiD-00016x-9F
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 18:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbbL1Rf5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Dec 2015 12:35:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751371AbbL1Rf4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Dec 2015 12:35:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 961713481A;
	Mon, 28 Dec 2015 12:35:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9gzyXmmJqzgQ
	Hg3aOyz08ukeBQc=; b=KFWF57DhVk5VKeaccFW0ZLS6q2DRHO+WLLQb6MF00jEO
	cCIi+fxnQWNOqRmlWLiA+K4vkq/Gyp9LDKQm50b+RpS55Nq0+IVb5sGkRKkgD7De
	W42OWW2WCzK79Mn1s9grFVUGlEBIUgD/U6YE2SHJgTKmcTPJTfnY9R5mFI6QMWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jucWOs
	VU9zlm2zpynaU9W/SZjftfXOWBCmJNBANM7fPWLFWSp7wBekA7BPRUr+PpG1n9af
	juV4QRvoYb6sBj6g35PCIsSH65weGyBth45UpJLmZdTi8Dvsxa0tTWwbwhy/3G/u
	tpMvVqXXjm3Z4HW7Q15QfL9XJtKHq/DN4g5Kw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8DBA634819;
	Mon, 28 Dec 2015 12:35:55 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 12E7934818;
	Mon, 28 Dec 2015 12:35:55 -0500 (EST)
In-Reply-To: <1451181092-26054-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 27
 Dec 2015 08:51:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 72B002C6-AD89-11E5-A64F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283039>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> That "someday" in the comment happened two years later in
> b65982b (Optimize "diff-index --cached" using cache-tree - 2009-05-20=
)
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Thanks.

>  builtin/blame.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 06484c2..9a0df92 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2379,11 +2379,6 @@ static struct commit *fake_working_tree_commit=
(struct diff_options *opt,
>  	ce->ce_mode =3D create_ce_mode(mode);
>  	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
> =20
> -	/*
> -	 * We are not going to write this out, so this does not matter
> -	 * right now, but someday we might optimize diff-index --cached
> -	 * with cache-tree information.
> -	 */
>  	cache_tree_invalidate_path(&the_index, path);
> =20
>  	return commit;
