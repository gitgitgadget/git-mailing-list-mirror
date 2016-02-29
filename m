From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/22] refs/files-backend.c: mark strings for translation
Date: Mon, 29 Feb 2016 10:43:49 -0800
Message-ID: <xmqqfuwbbbmi.fsf@gitster.mtv.corp.google.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
	<1456555333-5853-15-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 19:44:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaSnV-00054B-Rf
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 19:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbcB2Sny convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 13:43:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62876 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750885AbcB2Snw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Feb 2016 13:43:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A441C476CB;
	Mon, 29 Feb 2016 13:43:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dXg0E5HMFvGo
	jyAVAmrydasMs/E=; b=rLLsdfgueZxXgBxqKGk8JtMvYOw4UjTdlUTXhdpGwcBt
	26arc6DFOtJ0pL10fUQfwBVnv5aym08M3yXE5WN4YmS3qZbPfxgKb4q6bvGBN9Jw
	Oth2UFI4lO4qXypn/tabgALm49KFygy7Xk7giT75woYnfg6wcWvSsK5Za/cUf+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cquq9A
	rnsZlVkI6eoek9CUspVuUgYWBEIn/B4xrZjPc5cmc5qIO/8UTXkn1Lrb1Ja8gLl0
	UH8zT16Ox/YTUqKtHuR+0jDXT+jwTIMiDz5+A2qgc9FzW1RlV0ece/YRUhsOVvUL
	jJcXHR4f7MPtUhFiMiAeBYdF2n+A8e4r1vJl8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9C907476CA;
	Mon, 29 Feb 2016 13:43:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DA0E2476C9;
	Mon, 29 Feb 2016 13:43:50 -0500 (EST)
In-Reply-To: <1456555333-5853-15-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 27
 Feb 2016 13:42:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6015CB0C-DF14-11E5-9214-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287866>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

I'd really prefer to avoid any code churn on this file before the
dust settles for David's and Michael's series (the former is in
'pu', the latter is not but was already rerolled once) both of which
touch this file heavily.

>  refs/files-backend.c | 86 ++++++++++++++++++++++++++----------------=
----------
>  1 file changed, 43 insertions(+), 43 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 81f68f8..bf76094 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -203,7 +203,7 @@ static struct ref_entry *create_ref_entry(const c=
har *refname,
> =20
>  	if (check_name &&
>  	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
> -		die("Reference has invalid format: '%s'", refname);
> +		die(_("Reference has invalid format: '%s'"), refname);
>  	FLEX_ALLOC_STR(ref, name, refname);
>  	hashcpy(ref->u.value.oid.hash, sha1);
>  	oidclr(&ref->u.value.peeled);
> @@ -475,12 +475,12 @@ static int is_dup_ref(const struct ref_entry *r=
ef1, const struct ref_entry *ref2
> =20
>  	if ((ref1->flag & REF_DIR) || (ref2->flag & REF_DIR))
>  		/* This is impossible by construction */
> -		die("Reference directory conflict: %s", ref1->name);
> +		die(_("Reference directory conflict: %s"), ref1->name);
> =20
>  	if (oidcmp(&ref1->u.value.oid, &ref2->u.value.oid))
> -		die("Duplicated ref, and SHA1s don't match: %s", ref1->name);
> +		die(_("Duplicated ref, and SHA1s don't match: %s"), ref1->name);
> =20
> -	warning("Duplicated ref: %s", ref1->name);
> +	warning(_("Duplicated ref: %s"), ref1->name);
>  	return 1;
>  }
> =20
> @@ -526,7 +526,7 @@ static int ref_resolves_to_object(struct ref_entr=
y *entry)
>  	if (entry->flag & REF_ISBROKEN)
>  		return 0;
>  	if (!has_sha1_file(entry->u.value.oid.hash)) {
> -		error("%s does not point to a valid object!", entry->name);
> +		error(_("%s does not point to a valid object!"), entry->name);
>  		return 0;
>  	}
>  	return 1;
> @@ -653,7 +653,7 @@ static int do_for_each_entry_in_dirs(struct ref_d=
ir *dir1,
>  				i1++;
>  				i2++;
>  			} else {
> -				die("conflict between reference and directory: %s",
> +				die(_("conflict between reference and directory: %s"),
>  				    e1->name);
>  			}
>  		} else {
> @@ -914,7 +914,7 @@ static void clear_packed_ref_cache(struct ref_cac=
he *refs)
>  		struct packed_ref_cache *packed_refs =3D refs->packed;
> =20
>  		if (packed_refs->lock)
> -			die("internal error: packed-ref cache cleared while locked");
> +			die(_("internal error: packed-ref cache cleared while locked"));
>  		refs->packed =3D NULL;
>  		release_packed_ref_cache(packed_refs);
>  	}
> @@ -1069,7 +1069,7 @@ static void read_packed_refs(FILE *f, struct re=
f_dir *dir)
> =20
>  			if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
>  				if (!refname_is_safe(refname))
> -					die("packed refname is dangerous: %s", refname);
> +					die(_("packed refname is dangerous: %s"), refname);
>  				hashclr(sha1);
>  				flag |=3D REF_BAD_NAME | REF_ISBROKEN;
>  			}
> @@ -1239,7 +1239,7 @@ static void read_loose_refs(const char *dirname=
, struct ref_dir *dir)
>  			if (check_refname_format(refname.buf,
>  						 REFNAME_ALLOW_ONELEVEL)) {
>  				if (!refname_is_safe(refname.buf))
> -					die("loose refname is dangerous: %s", refname.buf);
> +					die(_("loose refname is dangerous: %s"), refname.buf);
>  				hashclr(sha1);
>  				flag |=3D REF_BAD_NAME | REF_ISBROKEN;
>  			}
> @@ -2099,7 +2099,7 @@ static int commit_packed_refs(void)
> =20
>  	out =3D fdopen_lock_file(packed_ref_cache->lock, "w");
>  	if (!out)
> -		die_errno("unable to fdopen packed-refs descriptor");
> +		die_errno(_("unable to fdopen packed-refs descriptor"));
> =20
>  	fprintf_or_die(out, "%s", PACKED_REFS_HEADER);
>  	do_for_each_entry_in_dir(get_packed_ref_dir(packed_ref_cache),
> @@ -2275,7 +2275,7 @@ int pack_refs(unsigned int flags)
>  				 pack_if_possible_fn, &cbdata);
> =20
>  	if (commit_packed_refs())
> -		die_errno("unable to overwrite old ref-pack file");
> +		die_errno(_("unable to overwrite old ref-pack file"));
> =20
>  	prune_refs(cbdata.ref_to_prune);
>  	return 0;
> @@ -2417,7 +2417,7 @@ static int rename_tmp_log(const char *newrefnam=
e)
>  			goto retry;
>  		/* fall through */
>  	default:
> -		error("unable to create directory for %s", newrefname);
> +		error(_("unable to create directory for %s"), newrefname);
>  		goto out;
>  	}
> =20
> @@ -2429,7 +2429,7 @@ static int rename_tmp_log(const char *newrefnam=
e)
>  			 * Solaris 5.8 gives ENOTDIR.  Sheesh.
>  			 */
>  			if (remove_empty_directories(&path)) {
> -				error("Directory not empty: logs/%s", newrefname);
> +				error(_("Directory not empty: logs/%s"), newrefname);
>  				goto out;
>  			}
>  			goto retry;
> @@ -2441,8 +2441,8 @@ static int rename_tmp_log(const char *newrefnam=
e)
>  			 */
>  			goto retry;
>  		} else {
> -			error("unable to move logfile "TMP_RENAMED_LOG" to logs/%s: %s",
> -				newrefname, strerror(errno));
> +			error(_("unable to move logfile %s to logs/%s: %s"),
> +				TMP_RENAMED_LOG, newrefname, strerror(errno));
>  			goto out;
>  		}
>  	}
> @@ -2486,25 +2486,25 @@ int rename_ref(const char *oldrefname, const =
char *newrefname, const char *logms
>  	struct strbuf err =3D STRBUF_INIT;
> =20
>  	if (log && S_ISLNK(loginfo.st_mode))
> -		return error("reflog for %s is a symlink", oldrefname);
> +		return error(_("reflog for %s is a symlink"), oldrefname);
> =20
>  	symref =3D resolve_ref_unsafe(oldrefname, RESOLVE_REF_READING,
>  				    orig_sha1, &flag);
>  	if (flag & REF_ISSYMREF)
> -		return error("refname %s is a symbolic ref, renaming it is not sup=
ported",
> +		return error(_("refname %s is a symbolic ref, renaming it is not s=
upported"),
>  			oldrefname);
>  	if (!symref)
> -		return error("refname %s not found", oldrefname);
> +		return error(_("refname %s not found"), oldrefname);
> =20
>  	if (!rename_ref_available(oldrefname, newrefname))
>  		return 1;
> =20
>  	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_REN=
AMED_LOG)))
> -		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG":=
 %s",
> -			oldrefname, strerror(errno));
> +		return error(_("unable to move logfile logs/%s to %s: %s"),
> +			     TMP_RENAMED_LOG, oldrefname, strerror(errno));
> =20
>  	if (delete_ref(oldrefname, orig_sha1, REF_NODEREF)) {
> -		error("unable to delete old %s", oldrefname);
> +		error(_("unable to delete old %s"), oldrefname);
>  		goto rollback;
>  	}
> =20
> @@ -2519,11 +2519,11 @@ int rename_ref(const char *oldrefname, const =
char *newrefname, const char *logms
>  			strbuf_release(&path);
> =20
>  			if (result) {
> -				error("Directory not empty: %s", newrefname);
> +				error(_("Directory not empty: %s"), newrefname);
>  				goto rollback;
>  			}
>  		} else {
> -			error("unable to delete existing %s", newrefname);
> +			error(_("unable to delete existing %s"), newrefname);
>  			goto rollback;
>  		}
>  	}
> @@ -2535,7 +2535,7 @@ int rename_ref(const char *oldrefname, const ch=
ar *newrefname, const char *logms
> =20
>  	lock =3D lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, 0, NULL,=
 &err);
>  	if (!lock) {
> -		error("unable to rename '%s' to '%s': %s", oldrefname, newrefname,=
 err.buf);
> +		error(_("unable to rename '%s' to '%s': %s"), oldrefname, newrefna=
me, err.buf);
>  		strbuf_release(&err);
>  		goto rollback;
>  	}
> @@ -2543,7 +2543,7 @@ int rename_ref(const char *oldrefname, const ch=
ar *newrefname, const char *logms
> =20
>  	if (write_ref_to_lockfile(lock, orig_sha1, &err) ||
>  	    commit_ref_update(lock, orig_sha1, logmsg, 0, &err)) {
> -		error("unable to write current sha1 into %s: %s", newrefname, err.=
buf);
> +		error(_("unable to write current sha1 into %s: %s"), newrefname, e=
rr.buf);
>  		strbuf_release(&err);
>  		goto rollback;
>  	}
> @@ -2553,7 +2553,7 @@ int rename_ref(const char *oldrefname, const ch=
ar *newrefname, const char *logms
>   rollback:
>  	lock =3D lock_ref_sha1_basic(oldrefname, NULL, NULL, NULL, 0, NULL,=
 &err);
>  	if (!lock) {
> -		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
> +		error(_("unable to lock %s for rollback: %s"), oldrefname, err.buf=
);
>  		strbuf_release(&err);
>  		goto rollbacklog;
>  	}
> @@ -2562,19 +2562,19 @@ int rename_ref(const char *oldrefname, const =
char *newrefname, const char *logms
>  	log_all_ref_updates =3D 0;
>  	if (write_ref_to_lockfile(lock, orig_sha1, &err) ||
>  	    commit_ref_update(lock, orig_sha1, NULL, 0, &err)) {
> -		error("unable to write current sha1 into %s: %s", oldrefname, err.=
buf);
> +		error(_("unable to write current sha1 into %s: %s"), oldrefname, e=
rr.buf);
>  		strbuf_release(&err);
>  	}
>  	log_all_ref_updates =3D flag;
> =20
>   rollbacklog:
>  	if (logmoved && rename(git_path("logs/%s", newrefname), git_path("l=
ogs/%s", oldrefname)))
> -		error("unable to restore logfile %s from %s: %s",
> +		error(_("unable to restore logfile %s from %s: %s"),
>  			oldrefname, newrefname, strerror(errno));
>  	if (!logmoved && log &&
>  	    rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", oldrefnam=
e)))
> -		error("unable to restore logfile %s from "TMP_RENAMED_LOG": %s",
> -			oldrefname, strerror(errno));
> +		error(_("unable to restore logfile %s from %s: %s"),
> +		      TMP_RENAMED_LOG, oldrefname, strerror(errno));
> =20
>  	return 1;
>  }
> @@ -2817,7 +2817,7 @@ static int commit_ref_update(struct ref_lock *l=
ock,
>  		}
>  	}
>  	if (commit_ref(lock)) {
> -		error("Couldn't set %s", lock->ref_name);
> +		error(_("Couldn't set %s"), lock->ref_name);
>  		unlock_ref(lock);
>  		return -1;
>  	}
> @@ -2862,7 +2862,7 @@ static int create_symref_locked(struct ref_lock=
 *lock, const char *refname,
>  	}
> =20
>  	if (!fdopen_lock_file(lock->lk, "w"))
> -		return error("unable to fdopen %s: %s",
> +		return error(_("unable to fdopen %s: %s"),
>  			     lock->lk->tempfile.filename.buf, strerror(errno));
> =20
>  	update_symref_reflog(lock, refname, target, logmsg);
> @@ -2870,7 +2870,7 @@ static int create_symref_locked(struct ref_lock=
 *lock, const char *refname,
>  	/* no error check; commit_ref will check ferror */
>  	fprintf(lock->lk->tempfile.fp, "ref: %s\n", target);
>  	if (commit_ref(lock) < 0)
> -		return error("unable to write symref for %s: %s", refname,
> +		return error(_("unable to write symref for %s: %s"), refname,
>  			     strerror(errno));
>  	return 0;
>  }
> @@ -2959,7 +2959,7 @@ int for_each_reflog_ent_reverse(const char *ref=
name, each_reflog_ent_fn fn, void
> =20
>  	/* Jump to the end */
>  	if (fseek(logfp, 0, SEEK_END) < 0)
> -		return error("cannot seek back reflog for %s: %s",
> +		return error(_("cannot seek back reflog for %s: %s"),
>  			     refname, strerror(errno));
>  	pos =3D ftell(logfp);
>  	while (!ret && 0 < pos) {
> @@ -2971,11 +2971,11 @@ int for_each_reflog_ent_reverse(const char *r=
efname, each_reflog_ent_fn fn, void
>  		/* Fill next block from the end */
>  		cnt =3D (sizeof(buf) < pos) ? sizeof(buf) : pos;
>  		if (fseek(logfp, pos - cnt, SEEK_SET))
> -			return error("cannot seek back reflog for %s: %s",
> +			return error(_("cannot seek back reflog for %s: %s"),
>  				     refname, strerror(errno));
>  		nread =3D fread(buf, cnt, 1, logfp);
>  		if (nread !=3D 1)
> -			return error("cannot read %d bytes from reflog for %s: %s",
> +			return error(_("cannot read %d bytes from reflog for %s: %s"),
>  				     cnt, refname, strerror(errno));
>  		pos -=3D cnt;
> =20
> @@ -3097,7 +3097,7 @@ static int do_for_each_reflog(struct strbuf *na=
me, each_ref_fn fn, void *cb_data
>  				struct object_id oid;
> =20
>  				if (read_ref_full(name->buf, 0, oid.hash, NULL))
> -					retval =3D error("bad ref for %s", name->buf);
> +					retval =3D error(_("bad ref for %s"), name->buf);
>  				else
>  					retval =3D fn(name->buf, &oid, 0, cb_data);
>  			}
> @@ -3447,7 +3447,7 @@ int reflog_expire(const char *refname, const un=
signed char *sha1,
>  	 */
>  	lock =3D lock_ref_sha1_basic(refname, sha1, NULL, NULL, 0, &type, &=
err);
>  	if (!lock) {
> -		error("cannot lock ref '%s': %s", refname, err.buf);
> +		error(_("cannot lock ref '%s': %s"), refname, err.buf);
>  		strbuf_release(&err);
>  		return -1;
>  	}
> @@ -3474,7 +3474,7 @@ int reflog_expire(const char *refname, const un=
signed char *sha1,
>  		}
>  		cb.newlog =3D fdopen_lock_file(&reflog_lock, "w");
>  		if (!cb.newlog) {
> -			error("cannot fdopen %s (%s)",
> +			error(_("cannot fdopen %s (%s)"),
>  			      get_lock_file_path(&reflog_lock), strerror(errno));
>  			goto failure;
>  		}
> @@ -3497,21 +3497,21 @@ int reflog_expire(const char *refname, const =
unsigned char *sha1,
>  			!is_null_sha1(cb.last_kept_sha1);
> =20
>  		if (close_lock_file(&reflog_lock)) {
> -			status |=3D error("couldn't write %s: %s", log_file,
> +			status |=3D error(_("couldn't write %s: %s"), log_file,
>  					strerror(errno));
>  		} else if (update &&
>  			   (write_in_full(get_lock_file_fd(lock->lk),
>  				sha1_to_hex(cb.last_kept_sha1), 40) !=3D 40 ||
>  			    write_str_in_full(get_lock_file_fd(lock->lk), "\n") !=3D 1 ||
>  			    close_ref(lock) < 0)) {
> -			status |=3D error("couldn't write %s",
> +			status |=3D error(_("couldn't write %s"),
>  					get_lock_file_path(lock->lk));
>  			rollback_lock_file(&reflog_lock);
>  		} else if (commit_lock_file(&reflog_lock)) {
> -			status |=3D error("unable to write reflog '%s' (%s)",
> +			status |=3D error(_("unable to write reflog '%s' (%s)"),
>  					log_file, strerror(errno));
>  		} else if (update && commit_ref(lock)) {
> -			status |=3D error("couldn't set %s", lock->ref_name);
> +			status |=3D error(_("couldn't set %s"), lock->ref_name);
>  		}
>  	}
>  	free(log_file);
