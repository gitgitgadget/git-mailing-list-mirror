From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Subject: Re: [RFC/ PATCH 2/5] unpack_trees: group errors by type
Date: Wed, 9 Jun 2010 15:19:40 +0200
Message-ID: <AANLkTinBbuqN0ayoTjnDi7KUKlf64HTkEfnqzcQN9Mjl@mail.gmail.com>
References: <1276087446-25112-1-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<1276087446-25112-2-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<1276087446-25112-3-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<1276087446-25112-4-git-send-email-diane.gasselin@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Diane <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?ISO-8859-1?Q?Cl=E9ment_Poulain?= 
	<clement.poulain@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 09 15:20:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMLCP-0000fr-2B
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 15:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756848Ab0FINT6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 09:19:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:50219 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296Ab0FINT5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 09:19:57 -0400
Received: by fg-out-1718.google.com with SMTP id d23so2443602fga.1
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 06:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=c1+zBLTrr1ra/hLTJi3YBS7SmCfmvpzl6wii4HTf+h0=;
        b=grTSUCHUrFI/UfTvViWOqlJTDAQvPgM7c942wddGHnOSF+2Bt3rqPKV+YlqyO84GDI
         O9wFN6kXyFz9uItlJKPTdqPcjk3zvWTWz6ssszbWUuH297f9LW9be+TUILiBIPty5mU6
         uR7Xhhuk0H7F/JHW65D/FaESwXolgHwP1KTyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=Xx3/z8VALvq4YuCKa7/Ii+OR9V1LhdIqljXr8tvYuDhS6TzRgVdrQk/ylPXcEmQvo9
         /A00bs6lYDQIhZGtPICR2xkKYCC2GmHbaCpbxizHIUZ0C15Iaxw5JXdT6pclqJhWlQ4I
         mv1cOlVBSAS3cIREjOLgFI/nbmdYoGpMPIyoE=
Received: by 10.239.135.2 with SMTP id b2mr1260744hbb.206.1276089595227; Wed, 
	09 Jun 2010 06:19:55 -0700 (PDT)
Received: by 10.239.172.204 with HTTP; Wed, 9 Jun 2010 06:19:40 -0700 (PDT)
In-Reply-To: <1276087446-25112-4-git-send-email-diane.gasselin@ensimag.imag.fr>
X-Google-Sender-Auth: HFeqFnzerPertaRD0HK9DA67ItU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148771>

Sorry about this.
We had a problem sending our patch, only one message was sent and we
don't know what happened to the others (they have not been returned to
us).
As soon as the problem is fixed, we will send the entire patch.
Sorry again for the noise.

Le 9 juin 2010 14:44, Diane Gasselin <diane.gasselin@ensimag.imag.fr> a=
 =E9crit :
> From: Diane <diane.gasselin@ensimag.imag.fr>
>
> When an error is encountered, it calls add_rejected_file() which eith=
er
> - directly displays the error message if in plumbing mode
> - or stores it so that it will be displayed at the end of display_err=
or_msgs(),
>
> Storing the files by error type permits to have a list of files for
> which there is the same error instead of having a serie of almost
> identical errors.
>
> As each bind_overlap error combines a file and an old file, a list ca=
nnot be
> done, therefore, theses errors are not stored but directly displayed.
>
> Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
> Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
> Signed-off-by: Cl=E9ment Poulain <clement.poulain@ensimag.imag.fr>
> ---
> It appears that in verify_absent_sparse(), verify_absent_1() is calle=
d with
> ERRORMSG(o, would_lose_orphaned) as the error message.
> Yet, in verify_absent_1(), this error message error_msg does not
> seem to be used and at the end of the function, a would_lose_untracke=
d error
> is treated (before displayed and now added). Is it normal?
>
> =A0unpack-trees.c | =A0128 ++++++++++++++++++++++++++++++++++++++++++=
++++++++++----
> =A0unpack-trees.h | =A0 12 +++++
> =A02 files changed, 132 insertions(+), 8 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index c29a9e0..1e2f48d 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -45,6 +45,21 @@ static struct unpack_trees_error_msgs unpack_plumb=
ing_errors =3D {
> =A0 =A0 =A0 =A0? ((o)->msgs.fld) \
> =A0 =A0 =A0 =A0: (unpack_plumbing_errors.fld) )
>
> +/*
> + * Store error messages in an array, each case
> + * corresponding to a error message type
> + */
> +typedef enum {
> + =A0 =A0 =A0 would_overwrite,
> + =A0 =A0 =A0 not_uptodate_file,
> + =A0 =A0 =A0 not_uptodate_dir,
> + =A0 =A0 =A0 would_lose_untracked,
> + =A0 =A0 =A0 would_lose_untracked_removed,
> + =A0 =A0 =A0 sparse_not_uptodate_file
> +} unpack_trees_error;
> +#define NB_UNPACK_TREES_ERROR 6
> +struct rejected_files *unpack_rejects[NB_UNPACK_TREES_ERROR];
> +
> =A0static void add_entry(struct unpack_trees_options *o, struct cache=
_entry *ce,
> =A0 =A0 =A0 =A0unsigned int set, unsigned int clear)
> =A0{
> @@ -60,6 +75,88 @@ static void add_entry(struct unpack_trees_options =
*o, struct cache_entry *ce,
> =A0}
>
> =A0/*
> + * add error messages on file <file> and action <action>
> + * corresponding to the type <e> with the message <msg>
> + * indicating if it should be display in porcelain or not
> + */
> +static int add_rejected_file(unpack_trees_error e,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *=
file,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *=
action,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int porcelai=
n,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *=
msg)
> +{
> + =A0 =A0 =A0 struct rejected_files_list *newentry;
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* simply display the given error message if in plumb=
ing mode
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (!porcelain) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error(msg,file,action);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* if there is a porcelain error message defined,
> + =A0 =A0 =A0 =A0* the error is stored in order to be nicely displaye=
d later
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (e =3D=3D would_lose_untracked && !strcmp(action,"re=
moved"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 e =3D would_lose_untracked_removed;
> +
> + =A0 =A0 =A0 if (!unpack_rejects[e]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unpack_rejects[e] =3D malloc(sizeof(str=
uct rejected_files));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unpack_rejects[e]->list =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unpack_rejects[e]->size =3D 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 newentry =3D malloc(sizeof(struct rejected_files_list))=
;
> + =A0 =A0 =A0 newentry->file =3D (char *)file;
> + =A0 =A0 =A0 newentry->next =3D unpack_rejects[e]->list;
> + =A0 =A0 =A0 unpack_rejects[e]->list =3D newentry;
> + =A0 =A0 =A0 unpack_rejects[e]->msg =3D msg;
> + =A0 =A0 =A0 unpack_rejects[e]->action =3D (char *)action;
> + =A0 =A0 =A0 unpack_rejects[e]->size +=3D strlen(file)+strlen("\n")+=
strlen("\t");
> + =A0 =A0 =A0 return -1;
> +}
> +
> +/*
> + * free all the structures allocated for the error <e>
> + */
> +static void free_rejected_files(unpack_trees_error e)
> +{
> + =A0 =A0 =A0 while(unpack_rejects[e]->list) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct rejected_files_list *del =3D unp=
ack_rejects[e]->list;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unpack_rejects[e]->list =3D unpack_reje=
cts[e]->list->next;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free(del);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 free(unpack_rejects[e]);
> +}
> +
> +/*
> + * display all the error messages stored in a nice way
> + */
> +static void display_error_msgs()
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 int hasPorcelain =3D 0;
> + =A0 =A0 =A0 for (i=3D0; i<NB_UNPACK_TREES_ERROR; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (unpack_rejects[i] && unpack_rejects=
[i]->list) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hasPorcelain =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct rejected_files_l=
ist *f =3D unpack_rejects[i]->list;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *action =3D unpack=
_rejects[i]->action;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *file =3D malloc(u=
npack_rejects[i]->size+1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *file =3D '\0';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (f) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcat(=
file,"\t");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcat(=
file,f->file);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcat(=
file,"\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 f =3D f=
->next;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error(unpack_rejects[i]=
->msg,file,action);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_rejected_files(i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (hasPorcelain)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("Aborting\n");
> +}
> +
> +/*
> =A0* Unlink the last component and schedule the leading directories f=
or
> =A0* removal, such that empty directories get removed.
> =A0*/
> @@ -819,6 +916,7 @@ done:
> =A0 =A0 =A0 =A0return ret;
>
> =A0return_failed:
> + =A0 =A0 =A0 display_error_msgs();
> =A0 =A0 =A0 =A0mark_all_ce_unused(o->src_index);
> =A0 =A0 =A0 =A0ret =3D unpack_failed(o, NULL);
> =A0 =A0 =A0 =A0goto done;
> @@ -828,7 +926,9 @@ return_failed:
>
> =A0static int reject_merge(struct cache_entry *ce, struct unpack_tree=
s_options *o)
> =A0{
> - =A0 =A0 =A0 return error(ERRORMSG(o, would_overwrite), ce->name);
> + =A0 =A0 =A0 return add_rejected_file(would_overwrite, ce->name, NUL=
L,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(o &=
& (o)->msgs.would_overwrite),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ERRO=
RMSG(o, would_overwrite));
> =A0}
>
> =A0static int same(struct cache_entry *a, struct cache_entry *b)
> @@ -850,7 +950,7 @@ static int same(struct cache_entry *a, struct cac=
he_entry *b)
> =A0*/
> =A0static int verify_uptodate_1(struct cache_entry *ce,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s=
truct unpack_trees_options *o,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
const char *error_msg)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
unpack_trees_error error)
> =A0{
> =A0 =A0 =A0 =A0struct stat st;
>
> @@ -874,8 +974,16 @@ static int verify_uptodate_1(struct cache_entry =
*ce,
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0if (errno =3D=3D ENOENT)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> - =A0 =A0 =A0 return o->gently ? -1 :
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 error(error_msg, ce->name);
> + =A0 =A0 =A0 if (error =3D=3D sparse_not_uptodate_file)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return o->gently ? -1 :
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_rejected_file(spars=
e_not_uptodate_file, ce->name, NULL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (o && (o)->msgs.sparse_not_uptodate_file),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 ERRORMSG(o, sparse_not_uptodate_file));
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return o->gently ? -1 :
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_rejected_file(not_u=
ptodate_file, ce->name, NULL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (o && (o)->msgs.not_uptodate_file),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 ERRORMSG(o, not_uptodate_file));
> =A0}
>
> =A0static int verify_uptodate(struct cache_entry *ce,
> @@ -883,13 +991,13 @@ static int verify_uptodate(struct cache_entry *=
ce,
> =A0{
> =A0 =A0 =A0 =A0if (!o->skip_sparse_checkout && will_have_skip_worktre=
e(ce, o))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> - =A0 =A0 =A0 return verify_uptodate_1(ce, o, ERRORMSG(o, not_uptodat=
e_file));
> + =A0 =A0 =A0 return verify_uptodate_1(ce, o, not_uptodate_file);
> =A0}
>
> =A0static int verify_uptodate_sparse(struct cache_entry *ce,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0st=
ruct unpack_trees_options *o)
> =A0{
> - =A0 =A0 =A0 return verify_uptodate_1(ce, o, ERRORMSG(o, sparse_not_=
uptodate_file));
> + =A0 =A0 =A0 return verify_uptodate_1(ce, o, sparse_not_uptodate_fil=
e);
> =A0}
>
> =A0static void invalidate_ce_path(struct cache_entry *ce, struct unpa=
ck_trees_options *o)
> @@ -976,7 +1084,9 @@ static int verify_clean_subdirectory(struct cach=
e_entry *ce, const char *action,
> =A0 =A0 =A0 =A0i =3D read_directory(&d, pathbuf, namelen+1, NULL);
> =A0 =A0 =A0 =A0if (i)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return o->gently ? -1 :
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error(ERRORMSG(o, not_u=
ptodate_dir), ce->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_rejected_file(not_u=
ptodate_dir, ce->name, NULL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (o && (o)->msgs.not_uptodate_dir),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 ERRORMSG(o, not_uptodate_dir));
> =A0 =A0 =A0 =A0free(pathbuf);
> =A0 =A0 =A0 =A0return cnt;
> =A0}
> @@ -1058,7 +1168,9 @@ static int verify_absent_1(struct cache_entry *=
ce, const char *action,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return o->gently ? -1 :
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error(ERRORMSG(o, would=
_lose_untracked), ce->name, action);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_rejected_file(would=
_lose_untracked, ce->name, action,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (o && (o)->msgs.would_lose_untracked),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 ERRORMSG(o, would_lose_untracked));
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return 0;
> =A0}
> diff --git a/unpack-trees.h b/unpack-trees.h
> index ef70eab..49cc1ee 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -19,6 +19,18 @@ struct unpack_trees_error_msgs {
> =A0 =A0 =A0 =A0const char *would_lose_orphaned;
> =A0};
>
> +struct rejected_files_list {
> + =A0 =A0 =A0 char *file;
> + =A0 =A0 =A0 struct rejected_files_list *next;
> +};
> +
> +struct rejected_files {
> + =A0 =A0 =A0 char *action;
> + =A0 =A0 =A0 const char *msg;
> + =A0 =A0 =A0 size_t size;
> + =A0 =A0 =A0 struct rejected_files_list *list;
> +};
> +
> =A0struct unpack_trees_options {
> =A0 =A0 =A0 =A0unsigned int reset,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 merge,
> --
> 1.6.6.7.ga5fe3
>
>
