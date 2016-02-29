From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/22] builtin/update-index.c: mark strings for translation
Date: Mon, 29 Feb 2016 10:27:54 -0800
Message-ID: <xmqqa8mjcqxh.fsf@gitster.mtv.corp.google.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
	<1456555333-5853-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 19:28:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaSY6-0004vz-2w
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 19:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbcB2S16 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 13:27:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58565 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750860AbcB2S15 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Feb 2016 13:27:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 24F93471FE;
	Mon, 29 Feb 2016 13:27:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=I9G0Wo7fgDEO
	jzRLyByJscJbrZo=; b=jd+sVrOYVk9l2+a1uihFBrBGRuBC5zKL3r77AdyIXkat
	J/ZrRl+5z6Aq2eOk7eH5ykz+V0ApUXcE7zMD8c8hDcUBVwcjnXfcQWkPKFhSq/ZW
	0G+WbxDDW1rWuz97KWRWa3OAINKOcUM2ovG+412+ciRqA5zO3WMVpdd0VzBn3Fo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rfjTZN
	KFHd6tKioKnTH2m81yX9JXArMV/c1NiPBcT4mKc8OEtLuGVG71SZvI4eD5wUfcFA
	oQn+O21PdpU8LWwu6U6Fp9+J6kc76eorni39+q3MTvSzYT9hu6aockHtf4IF9Dqs
	JURq14QefLeYHySCM1UAhmFu8XMbQrGktW4hI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1D222471FD;
	Mon, 29 Feb 2016 13:27:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8607C471FC;
	Mon, 29 Feb 2016 13:27:55 -0500 (EST)
In-Reply-To: <1456555333-5853-8-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 27
 Feb 2016 13:41:58 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 26A7E000-DF12-11E5-89D3-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287859>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

This does look like a "new i18n bug" introduced in this cycle, but
given that this program does not have many _()s in the first place,
I'm inclined to say we should do the whole thing post 2.8.0 release
for this file, discarding this patch.

>  builtin/update-index.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 1c94ca5..21e38a8 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -1127,9 +1127,9 @@ int cmd_update_index(int argc, const char **arg=
v, const char *prefix)
>  		break;
>  	case UC_DISABLE:
>  		if (git_config_get_untracked_cache() =3D=3D 1)
> -			warning("core.untrackedCache is set to true; "
> -				"remove or change it, if you really want to "
> -				"disable the untracked cache");
> +			warning(_("core.untrackedCache is set to true; "
> +				  "remove or change it, if you really want to "
> +				  "disable the untracked cache"));
>  		remove_untracked_cache(&the_index);
>  		report(_("Untracked cache disabled"));
>  		break;
> @@ -1139,9 +1139,9 @@ int cmd_update_index(int argc, const char **arg=
v, const char *prefix)
>  	case UC_ENABLE:
>  	case UC_FORCE:
>  		if (git_config_get_untracked_cache() =3D=3D 0)
> -			warning("core.untrackedCache is set to false; "
> -				"remove or change it, if you really want to "
> -				"enable the untracked cache");
> +			warning(_("core.untrackedCache is set to false; "
> +				  "remove or change it, if you really want to "
> +				  "enable the untracked cache"));
>  		add_untracked_cache(&the_index);
>  		report(_("Untracked cache enabled for '%s'"), get_git_work_tree())=
;
>  		break;
> @@ -1156,7 +1156,7 @@ int cmd_update_index(int argc, const char **arg=
v, const char *prefix)
>  			unable_to_lock_die(get_index_file(), lock_error);
>  		}
>  		if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
> -			die("Unable to write new index file");
> +			die(_("Unable to write new index file"));
>  	}
> =20
>  	rollback_lock_file(lock_file);
