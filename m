Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B0E21F42D
	for <e@80x24.org>; Fri, 16 Mar 2018 07:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753190AbeCPHSF (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 03:18:05 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:36876 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753166AbeCPHRv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 03:17:51 -0400
Received: by mail-wr0-f172.google.com with SMTP id z12so10660233wrg.4
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 00:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XaAOo1QOaFeSQ/iLgM9GknrCpWVlkoP4JjNNHLOsNg0=;
        b=N4sm4zWj5bLiP9Ty/MUcxZJMKb8D3ndW14CkIu03dLfL9EXzMToVAWTbBe1vjYTFAz
         keazEdYarWTwDpaHx8LoHBWrgBG0NlTnmMqrNMx00SZFSUixgwp7Re5cTnTNBaIx6g6b
         +I94jEsOCOgGUaof3cpnaiYScZbP7Ij8h+XjAYcI6lLf00dz7TsiYsoHYkpdHrOydy54
         yqCUd6rHLNBNrAyVdXpHbFOiWgWG932LKqjzfZOSHEwxo9UmNBLASt6/r5KIwd8pVk6E
         GbrcJ7nhuQomaZ6E9XdYSBp+4UR3saiq6PqjuvbkBbBExx2BBLnTfkm4WHFl0hRRv5Yo
         9oSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XaAOo1QOaFeSQ/iLgM9GknrCpWVlkoP4JjNNHLOsNg0=;
        b=fqna/CtlW1KLThMaNPYL39TET8jFaBo6My/NBQtlhW1e2fiX6rKE51OTYv3Gb2K5+q
         jRHyamAZ1z3GDDsKzET4BlI06R/BptCg2b9YUXIsKk5fbismpozuQqECQw90S7yLB+wc
         10MNdun/ft+2yVxL6ZxW/lWAb6wnSUyadFVd5QfI/FdhzBctUu3LPNrLZd5bueicbfU3
         lp1/Vyzt84sW+h4syuLSR08YZCEqTEC2mwRBpk035JCvUSYw6ZglH+k+JfhJlA62opv3
         jinJ/IlVWsZFvUqbVWCGzg15LGUGXRRSBOboMXh8lkZW63k478c67maRogNLAle5qIYK
         Cdsg==
X-Gm-Message-State: AElRT7HY3wP5F0bf0X4RRVuMZMTI2L5eNYOxMkL08DoQOGapwM+t7NYV
        cyPyRLI+tpUMCPLgRBZUy5iZLU6zKf3f89siF6M=
X-Google-Smtp-Source: AG47ELvKezYHkZKIgAsYwoLZ23sif7wAOhtHPVVfXuoZIVM5hevSjii0dXyYtVXviNXdZVUqJ+4T7LqjopuV3HGFuVo=
X-Received: by 10.223.133.182 with SMTP id 51mr584542wrt.226.1521184669476;
 Fri, 16 Mar 2018 00:17:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.197.147 with HTTP; Fri, 16 Mar 2018 00:17:48 -0700 (PDT)
In-Reply-To: <20180315204709.1900787-1-martin.agren@gmail.com>
References: <0102016225e61cc2-0d0c05ef-b999-4bf2-88ac-db9840dd2a87-000000@eu-west-1.amazonses.com>
 <20180315204709.1900787-1-martin.agren@gmail.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Fri, 16 Mar 2018 10:17:48 +0300
Message-ID: <CAL21BmkipcdT6M38PDJ6=kk_E5F8T_OmYOF_N097UbmzbnjESA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ref-filter: get_ref_atom_value() error handling
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-03-15 23:47 GMT+03:00 Martin =C3=85gren <martin.agren@gmail.com>:
> I skimmed the first four patches of this v2. It seems that patches 1 and
> 4 are identical to v2. Patches 2 and 3 have very straightforward changes
> based on my earlier comments. Let's see what this patch is about. :-)

Yes, you are right.

>
> On 14 March 2018 at 20:04, Olga Telezhnaya <olyatelezhnaya@gmail.com> wro=
te:
>> Finish removing any printing from ref-filter formatting logic,
>> so that it could be more general.
>>
>> Change the signature of get_ref_atom_value() and underlying functions
>> by adding return value and strbuf parameter for error message.
>>
>> It's important to mention that grab_objectname() returned 1 if
>> it gets objectname atom and 0 otherwise. Now this logic changed:
>> we return 0 if we have no error, -1 otherwise. If someone needs to
>> know whether it's objectname atom or not, he/she could use
>> starts_with() function. It duplicates this checking but it does not
>> sound like a really big overhead.
>>
>> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
>> ---
>>  ref-filter.c | 109 +++++++++++++++++++++++++++++++++++++---------------=
-------
>>  1 file changed, 69 insertions(+), 40 deletions(-)
>>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 62ea4adcd0ff1..3f0c3924273d5 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -831,26 +831,27 @@ static void *get_obj(const struct object_id *oid, =
struct object **obj, unsigned
>>  }
>>
>>  static int grab_objectname(const char *name, const unsigned char *sha1,
>> -                          struct atom_value *v, struct used_atom *atom)
>> +                          struct atom_value *v, struct used_atom *atom,
>> +                          struct strbuf *err)
>>  {
>>         if (starts_with(name, "objectname")) {
>>                 if (atom->u.objectname.option =3D=3D O_SHORT) {
>>                         v->s =3D xstrdup(find_unique_abbrev(sha1, DEFAUL=
T_ABBREV));
>> -                       return 1;
>>                 } else if (atom->u.objectname.option =3D=3D O_FULL) {
>>                         v->s =3D xstrdup(sha1_to_hex(sha1));
>> -                       return 1;
>>                 } else if (atom->u.objectname.option =3D=3D O_LENGTH) {
>>                         v->s =3D xstrdup(find_unique_abbrev(sha1, atom->=
u.objectname.length));
>> -                       return 1;
>> -               } else
>> -                       die("BUG: unknown %%(objectname) option");
>> +               } else {
>> +                       strbuf_addstr(err, "BUG: unknown %(objectname) o=
ption");
>> +                       return -1;
>> +               }
>>         }
>>         return 0;
>>  }
>
> This is interesting. This die() is never ever supposed to actually
> trigger, except to allow a developer adding some new O_xxx-value to
> quickly notice that they have forgotten to add code here.

Oh, cool, so I can revert this change, OK.

>
>>  /* See grab_values */
>> -static void grab_common_values(struct atom_value *val, int deref, struc=
t object *obj, void *buf, unsigned long sz)
>> +static int grab_common_values(struct atom_value *val, int deref, struct=
 object *obj,
>> +                             void *buf, unsigned long sz, struct strbuf=
 *err)
>>  {
>>         int i;
>>
>> @@ -868,8 +869,10 @@ static void grab_common_values(struct atom_value *v=
al, int deref, struct object
>>                         v->s =3D xstrfmt("%lu", sz);
>>                 }
>>                 else if (deref)
>> -                       grab_objectname(name, obj->oid.hash, v, &used_at=
om[i]);
>> +                       if (grab_objectname(name, obj->oid.hash, v, &use=
d_atom[i], err))
>> +                               return -1;
>>         }
>> +       return 0;
>>  }
>
> So if that conversion I commented on above had not happened, this would
> not have been necessary. Let's read on...

Of course, I will check and also revert functions that were touched
only because of other functions.

>
>>  /* See grab_values */
>> @@ -1225,9 +1228,11 @@ static void fill_missing_values(struct atom_value=
 *val)
>>   * pointed at by the ref itself; otherwise it is the object the
>>   * ref (which is a tag) refers to.
>>   */
>> -static void grab_values(struct atom_value *val, int deref, struct objec=
t *obj, void *buf, unsigned long sz)
>> +static int grab_values(struct atom_value *val, int deref, struct object=
 *obj,
>> +                      void *buf, unsigned long sz, struct strbuf *err)
>>  {
>> -       grab_common_values(val, deref, obj, buf, sz);
>> +       if (grab_common_values(val, deref, obj, buf, sz, err))
>> +               return -1;
>>         switch (obj->type) {
>>         case OBJ_TAG:
>>                 grab_tag_values(val, deref, obj, buf, sz);
>> @@ -1247,8 +1252,10 @@ static void grab_values(struct atom_value *val, i=
nt deref, struct object *obj, v
>>                 /* grab_blob_values(val, deref, obj, buf, sz); */
>>                 break;
>>         default:
>> -               die("Eh?  Object of type %d?", obj->type);
>> +               strbuf_addf(err, "Eh?  Object of type %d?", obj->type);
>> +               return -1;
>>         }
>> +       return 0;
>>  }
>
> This seems similar. The string here is quite sloppy, and I do not
> believe that the author intended this to be user-visible. I believe this
> is more like a very short way of saying "how could we possibly get
> here??". It could also be written as die("BUG: unknown object type %d",
> obj->type), or even better: BUG(...).

OK, thanks!

>
>>  static inline char *copy_advance(char *dst, const char *src)
>> @@ -1335,8 +1342,9 @@ static const char *show_ref(struct refname_atom *a=
tom, const char *refname)
>>                 return refname;
>>  }
>>
>> -static void fill_remote_ref_details(struct used_atom *atom, const char =
*refname,
>> -                                   struct branch *branch, const char **=
s)
>> +static int fill_remote_ref_details(struct used_atom *atom, const char *=
refname,
>> +                                  struct branch *branch, const char **s=
,
>> +                                  struct strbuf *err)
>>  {
>>         int num_ours, num_theirs;
>>         if (atom->u.remote_ref.option =3D=3D RR_REF)
>> @@ -1362,7 +1370,7 @@ static void fill_remote_ref_details(struct used_at=
om *atom, const char *refname,
>>         } else if (atom->u.remote_ref.option =3D=3D RR_TRACKSHORT) {
>>                 if (stat_tracking_info(branch, &num_ours, &num_theirs,
>>                                        NULL, AHEAD_BEHIND_FULL) < 0)
>> -                       return;
>> +                       return 0;
>>
>>                 if (!num_ours && !num_theirs)
>>                         *s =3D "=3D";
>> @@ -1391,8 +1399,11 @@ static void fill_remote_ref_details(struct used_a=
tom *atom, const char *refname,
>>                         *s =3D xstrdup(merge);
>>                 else
>>                         *s =3D "";
>> -       } else
>> -               die("BUG: unhandled RR_* enum");
>> +       } else {
>> +               strbuf_addstr(err, "BUG: unhandled RR_* enum");
>> +               return -1;
>> +       }
>> +       return 0;
>>  }
>
> This one too.. I start to think it is overkill to wire through these
> strbufs just to collect messages that should never ever be produced.  It
> almost seems to me like if 1) we want to collect errors using strbufs,
> and 2) we want to use BUG() for these sorts of assertions, then 3) we
> will be wiring error-strbufs through more or less all of our code. I am
> exaggerating, but there is something to it: A small change deep down a
> callstack where you want to add a BUG() "to be safe", and you might need
> to wire a strbuf all the way through.

I absolutely agree that we should not touch functions that produce
errors for Git developers. It still means that sometimes we need to
wire strbufs, but I will revert some of them. It's enough to handle
only errors for users.

>
> According to d8193743e0 (usage.c: add BUG() function, 2017-05-12), a
> good thing about BUG() is that we can get a core dump, a filename and a
> line number. That opportunity gets lost if we do these sort of
> transformations. Of course, these were only die("BUG: "), not BUG(), but
> my point is that they should perhaps have been BUG().
>
>>  char *get_head_description(void)
>> @@ -1447,28 +1458,33 @@ static const char *get_refname(struct used_atom =
*atom, struct ref_array_item *re
>>         return show_ref(&atom->u.refname, ref->refname);
>>  }
>>
>> -static void get_object(struct ref_array_item *ref, const struct object_=
id *oid,
>> -                      int deref, struct object **obj)
>> +static int get_object(struct ref_array_item *ref, const struct object_i=
d *oid,
>> +                      int deref, struct object **obj, struct strbuf *er=
r)
>>  {
>>         int eaten;
>>         unsigned long size;
>>         void *buf =3D get_obj(oid, obj, &size, &eaten);
>> -       if (!buf)
>> -               die(_("missing object %s for %s"),
>> -                   oid_to_hex(oid), ref->refname);
>> -       if (!*obj)
>> -               die(_("parse_object_buffer failed on %s for %s"),
>> -                   oid_to_hex(oid), ref->refname);
>> -
>> -       grab_values(ref->value, deref, *obj, buf, size);
>> +       if (!buf) {
>> +               strbuf_addf(err, _("missing object %s for %s"), oid_to_h=
ex(oid),
>> +                           ref->refname);
>> +               return -1;
>> +       }
>> +       if (!*obj) {
>> +               strbuf_addf(err, _("parse_object_buffer failed on %s for=
 %s"),
>> +                           oid_to_hex(oid), ref->refname);
>> +               return -1;
>> +       }
>> +       if (grab_values(ref->value, deref, *obj, buf, size, err))
>> +               return -1;
>>         if (!eaten)
>>                 free(buf);
>> +       return 0;
>>  }
>
> These are "real" errors and yield several more changes in the remainder.
> Ignoring those BUG-type messages at the beginning of this patch would
> give a patch like the one below. Maybe that would be a bit less
> intrusive for the same gain.
>
> Thanks for working on this. I feel that your patches are really
> interesting. They open up many possibilities for philosophical exercises
> about how errors should be collected and reported. ;-) I would be
> interested in knowing your thoughts, and others'.

Thank you! I was also thinking about other ways how to handle errors.
I haven't invented anything new, so at least I decided to make these
changes (for now).

>
> Martin
>
> ---
>  ref-filter.c | 51 ++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 32 insertions(+), 19 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 62ea4adcd0..e41505b3c0 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1447,28 +1447,32 @@ static const char *get_refname(struct used_atom *=
atom, struct ref_array_item *re
>         return show_ref(&atom->u.refname, ref->refname);
>  }
>
> -static void get_object(struct ref_array_item *ref, const struct object_i=
d *oid,
> -                      int deref, struct object **obj)
> +static int get_object(struct ref_array_item *ref, const struct object_id=
 *oid,
> +                      int deref, struct object **obj, struct strbuf *err=
)
>  {
>         int eaten;
>         unsigned long size;
>         void *buf =3D get_obj(oid, obj, &size, &eaten);
> -       if (!buf)
> -               die(_("missing object %s for %s"),
> -                   oid_to_hex(oid), ref->refname);
> -       if (!*obj)
> -               die(_("parse_object_buffer failed on %s for %s"),
> -                   oid_to_hex(oid), ref->refname);
> -
> +       if (!buf) {
> +               strbuf_addf(err, _("missing object %s for %s"), oid_to_he=
x(oid),
> +                           ref->refname);
> +               return -1;
> +       }
> +       if (!*obj) {
> +               strbuf_addf(err, _("parse_object_buffer failed on %s for =
%s"),
> +                           oid_to_hex(oid), ref->refname);
> +               return -1;
> +       }
>         grab_values(ref->value, deref, *obj, buf, size);
>         if (!eaten)
>                 free(buf);
> +       return 0;
>  }
>
>  /*
>   * Parse the object referred by ref, and grab needed value.
>   */
> -static void populate_value(struct ref_array_item *ref)
> +static int populate_value(struct ref_array_item *ref, struct strbuf *err=
)
>  {
>         struct object *obj;
>         int i;
> @@ -1590,16 +1594,17 @@ static void populate_value(struct ref_array_item =
*ref)
>                         break;
>         }
>         if (used_atom_cnt <=3D i)
> -               return;
> +               return 0;
>
> -       get_object(ref, &ref->objectname, 0, &obj);
> +       if (get_object(ref, &ref->objectname, 0, &obj, err))
> +               return -1;
>
>         /*
>          * If there is no atom that wants to know about tagged
>          * object, we are done.
>          */
>         if (!need_tagged || (obj->type !=3D OBJ_TAG))
> -               return;
> +               return 0;
>
>         /*
>          * If it is a tag object, see if we use a value that derefs
> @@ -1613,20 +1618,23 @@ static void populate_value(struct ref_array_item =
*ref)
>          * is not consistent with what deref_tag() does
>          * which peels the onion to the core.
>          */
> -       get_object(ref, tagged, 1, &obj);
> +       return get_object(ref, tagged, 1, &obj, err);
>  }
>
>  /*
>   * Given a ref, return the value for the atom.  This lazily gets value
>   * out of the object by calling populate value.
>   */
> -static void get_ref_atom_value(struct ref_array_item *ref, int atom, str=
uct atom_value **v)
> +static int get_ref_atom_value(struct ref_array_item *ref, int atom,
> +                             struct atom_value **v, struct strbuf *err)
>  {
>         if (!ref->value) {
> -               populate_value(ref);
> +               if (populate_value(ref, err))
> +                       return -1;
>                 fill_missing_values(ref->value);
>         }
>         *v =3D &ref->value[atom];
> +       return 0;
>  }
>
>  /*
> @@ -2150,9 +2158,13 @@ static int cmp_ref_sorting(struct ref_sorting *s, =
struct ref_array_item *a, stru
>         int cmp;
>         cmp_type cmp_type =3D used_atom[s->atom].type;
>         int (*cmp_fn)(const char *, const char *);
> +       struct strbuf err =3D STRBUF_INIT;
>
> -       get_ref_atom_value(a, s->atom, &va);
> -       get_ref_atom_value(b, s->atom, &vb);
> +       if (get_ref_atom_value(a, s->atom, &va, &err))
> +               die("%s", err.buf);
> +       if (get_ref_atom_value(b, s->atom, &vb, &err))
> +               die("%s", err.buf);
> +       strbuf_release(&err);
>         cmp_fn =3D s->ignore_case ? strcasecmp : strcmp;
>         if (s->version)
>                 cmp =3D versioncmp(va->s, vb->s);
> @@ -2231,7 +2243,8 @@ int format_ref_array_item(struct ref_array_item *in=
fo,
>                         append_literal(cp, sp, &state);
>                 if (parse_ref_filter_atom(format, sp + 2, ep, &pos, error=
_buf))
>                         return -1;
> -               get_ref_atom_value(info, pos, &atomv);
> +               if (get_ref_atom_value(info, pos, &atomv, error_buf))
> +                       return -1;
>                 if (atomv->handler(atomv, &state, error_buf))
>                         return -1;
>         }
> --
> 2.16.2.246.ga4ee44448f
>
