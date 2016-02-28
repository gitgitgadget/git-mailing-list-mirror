From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/22] builtin/clone.c: mark strings for translation
Date: Sun, 28 Feb 2016 11:05:11 -0800
Message-ID: <xmqqvb58ejvc.fsf@gitster.mtv.corp.google.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
	<1456555333-5853-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 20:05:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aa6ef-0001yX-Jj
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 20:05:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754337AbcB1TFP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Feb 2016 14:05:15 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62929 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754187AbcB1TFO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Feb 2016 14:05:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0770F472F4;
	Sun, 28 Feb 2016 14:05:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xwzddhBkqX/o
	575/aKByGsWIeX0=; b=igszgrT20YkN6ZrZD3kUKDHW/veJjFYt63VQNe5/Ag3Z
	zK69lHH0TTQFk0ZbhdQ6KEUjTL7dnW8OpuXkwqNd+1ecwUGd4bhJER0jqSUurdqA
	ILzrTm9DwSg4kV5tRAlTkY4JKhdU16Bo5HTn+skBCGIUfXd4JP2ME6mhaEvBDE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CXkW7z
	sc7T28THmcdzsnEnOq6Cz8k4w1jhAbX4bwItoI9vbdrRnY2o6xyg6B27Qecz9cb/
	wuirJTgxxh456Bydw5AepPYm4LKw34hUqtmU5b3wY87K5hzdMU0kAR296xoh+zML
	HfOM87GqKpj+9oB2FH9R7COYP115sCBZCnCDM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F3B69472F3;
	Sun, 28 Feb 2016 14:05:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5F992472F2;
	Sun, 28 Feb 2016 14:05:12 -0500 (EST)
In-Reply-To: <1456555333-5853-5-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 27
 Feb 2016 13:41:55 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3181927E-DE4E-11E5-B9FC-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287784>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/clone.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

The command otherwise has been i18n'ed and it is clear that the
patches that added these strings should have done the i18n marking
shown here from the beginning.  Let's take this.

>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 9ac6c01..6616392 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -236,8 +236,8 @@ static char *guess_dir_name(const char *repo, int=
 is_bundle, int is_bare)
>  	strip_suffix_mem(start, &len, is_bundle ? ".bundle" : ".git");
> =20
>  	if (!len || (len =3D=3D 1 && *start =3D=3D '/'))
> -	    die("No directory name could be guessed.\n"
> -		"Please specify a directory on the command line");
> +		die(_("No directory name could be guessed.\n"
> +		      "Please specify a directory on the command line"));
> =20
>  	if (is_bare)
>  		dir =3D xstrfmt("%.*s.git", (int)len, start);
> @@ -644,7 +644,7 @@ static void update_remote_refs(const struct ref *=
refs,
>  		if (create_symref(head_ref.buf,
>  				  remote_head_points_at->peer_ref->name,
>  				  msg) < 0)
> -			die("unable to update %s", head_ref.buf);
> +			die(_("unable to update %s"), head_ref.buf);
>  		strbuf_release(&head_ref);
>  	}
>  }
> @@ -656,7 +656,7 @@ static void update_head(const struct ref *our, co=
nst struct ref *remote,
>  	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
>  		/* Local default branch link */
>  		if (create_symref("HEAD", our->name, NULL) < 0)
> -			die("unable to update HEAD");
> +			die(_("unable to update HEAD"));
>  		if (!option_bare) {
>  			update_ref(msg, "HEAD", our->old_oid.hash, NULL, 0,
>  				   UPDATE_REFS_DIE_ON_ERR);
> @@ -750,7 +750,7 @@ static void write_config(struct string_list *conf=
ig)
>  	for (i =3D 0; i < config->nr; i++) {
>  		if (git_config_parse_parameter(config->items[i].string,
>  					       write_one_config, NULL) < 0)
> -			die("unable to write parameters to config file");
> +			die(_("unable to write parameters to config file"));
>  	}
>  }
