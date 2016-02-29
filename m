From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/22] notes.c: mark strings for translation
Date: Mon, 29 Feb 2016 10:36:05 -0800
Message-ID: <xmqqoaazbbze.fsf@gitster.mtv.corp.google.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
	<1456555333-5853-13-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 19:36:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaSg2-0000rE-OH
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 19:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbcB2SgL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 13:36:11 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51206 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750860AbcB2SgI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Feb 2016 13:36:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC6DD474A8;
	Mon, 29 Feb 2016 13:36:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ES9UBXi90SD2
	LxKWi3LJ+zXz3d8=; b=lp22QxN60POmF5CSMveMmxIKxO9n685LWO61vs/Y3/vY
	48jXPNLg7A/R0X1AetJ7OKcrmk/cNVcbxTQy50Sg6FW2V9Px7zTmDk6Cn4yjq8Ep
	Lvl3ujrBXtnh4z0iyo9Y5iOVFNme4WRZkYXupSS+iDN1idslbAecemXeGyFSbxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=p9SEqQ
	8xeJMyg9GgjbqACImtuQszxmIogPmXShD02ne9/bZHu1IcFrcsLFANIPHXBQoGXn
	4MdLwWwzCfpfp1IKBYhhIcLNH9z26jvRZZ+bniVWapuOu5HVrNYFG4lbxDWIVto0
	bDfrv/eP3jqhYsKobIkQqib8Sz88+yiTIrKy0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A412D474A7;
	Mon, 29 Feb 2016 13:36:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1AA49474A6;
	Mon, 29 Feb 2016 13:36:07 -0500 (EST)
In-Reply-To: <1456555333-5853-13-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 27
 Feb 2016 13:42:03 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4BA60CF0-DF13-11E5-868A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287864>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

All (or at least most of) these look old ones.  I'm inclined to say
we should do the whole thing post 2.8.0 release for this file.

>  notes.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/notes.c b/notes.c
> index 88cf474..0f03f77 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -422,7 +422,7 @@ static void load_subtree(struct notes_tree *t, st=
ruct leaf_node *subtree,
> =20
>  	buf =3D fill_tree_descriptor(&desc, subtree->val_sha1);
>  	if (!buf)
> -		die("Could not read %s for notes-index",
> +		die(_("Could not read %s for notes-index"),
>  		     sha1_to_hex(subtree->val_sha1));
> =20
>  	prefix_len =3D subtree->key_sha1[19];
> @@ -455,8 +455,8 @@ static void load_subtree(struct notes_tree *t, st=
ruct leaf_node *subtree,
>  			}
>  			if (note_tree_insert(t, node, n, l, type,
>  					     combine_notes_concatenate))
> -				die("Failed to load %s %s into notes tree "
> -				    "from %s",
> +				die(_("Failed to load %s %s into notes tree "
> +				      "from %s"),
>  				    type =3D=3D PTR_TYPE_NOTE ? "note" : "subtree",
>  				    sha1_to_hex(l->key_sha1), t->ref);
>  		}
> @@ -942,7 +942,7 @@ void string_list_add_refs_by_glob(struct string_l=
ist *list, const char *glob)
>  	} else {
>  		unsigned char sha1[20];
>  		if (get_sha1(glob, sha1))
> -			warning("notes ref %s is invalid", glob);
> +			warning(_("notes ref %s is invalid"), glob);
>  		if (!unsorted_string_list_has_string(list, glob))
>  			string_list_append(list, glob);
>  	}
> @@ -1020,9 +1020,9 @@ void init_notes(struct notes_tree *t, const cha=
r *notes_ref,
>  	    get_sha1_treeish(notes_ref, object_sha1))
>  		return;
>  	if (flags & NOTES_INIT_WRITABLE && read_ref(notes_ref, object_sha1)=
)
> -		die("Cannot use notes ref %s", notes_ref);
> +		die(_("Cannot use notes ref %s"), notes_ref);
>  	if (get_tree_entry(object_sha1, "", sha1, &mode))
> -		die("Failed to read notes tree referenced by %s (%s)",
> +		die(_("Failed to read notes tree referenced by %s (%s)"),
>  		    notes_ref, sha1_to_hex(object_sha1));
> =20
>  	hashclr(root_tree.key_sha1);
