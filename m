Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 952B1202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 14:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932421AbdCIOwd (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 09:52:33 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:33553 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754948AbdCIOwb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 09:52:31 -0500
Received: by mail-io0-f169.google.com with SMTP id f84so28478612ioj.0
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 06:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ywmzFeo++gxl0KUKMXMabbX19LJ3VJ8/hUvWstVhFVM=;
        b=amvyLu3Gq1gH/bmLAicWwFfr5WGZ60PeGWhgAGM1uBpPhET6AZzyw31UIn+iDRelLK
         Tu8aKz7qWm6HA40I4TvxEcN3PYDjdAtlDOBPwuauUlpon0ra/CHjV3+/uiA//ZAwy90h
         aCRft2qHuP1CbiQr6LqppH6T9V5T6cepYTzM5iU8fyHpmT/yJpa4qw6FR41nO3WJvp9i
         +kkspZYr7dDTjxGnrFVAWecg2mWBWMe/UTwoQSrEjozxONbU5ArP5BcLllBcp8rCRGZw
         qMK0UtJ4EhVdDL/1S0cv5wncegLnuVHfknblDL8yo10rnXfB9Bw7WxWmq6k6HJXCChu2
         uBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ywmzFeo++gxl0KUKMXMabbX19LJ3VJ8/hUvWstVhFVM=;
        b=e6f7gaYjwvqAP72llXbxyKWJpW7Gg0NuA7Nrz5WfnYQVg9NOG7+vA+R4Q/6R9zMkEy
         +C7SZ/m1jEFFD+S8YSZZOAcnmoaj/AZyNrvdUCcgF0TqUUK6SftqOgJuWSe4FdUE3eKz
         mrpo+E9PwSXRzyycog1KLuozH109d2dT9nHWIw6HvSvUQ9TdfAg1VG7lCToD6oZkuT3b
         URt9/8BwPzgFkCtno4Thsz3inPvwwdMlLrgqvDZXBhGpdUF4ffpX1CUQJWNYOWG4l+Xt
         0nE0EOUr1JRhiDwNn1SpdHYjZZsX6/BksqYh5ewraSgq09/aRNNJ545DHnxJrI2NHCWv
         Iz7Q==
X-Gm-Message-State: AMke39mtmoRinmZ4esc+LZ08JGFHfSOIiZHtPOrbPavxzAm03h9rs48MzABgI9GrBPjTJmG2by6uxm2avLhv0A==
X-Received: by 10.107.57.2 with SMTP id g2mr12883172ioa.117.1489071149843;
 Thu, 09 Mar 2017 06:52:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Thu, 9 Mar 2017 06:52:09 -0800 (PST)
In-Reply-To: <20170309125132.tubwxtneffok4nrc@sigill.intra.peff.net>
References: <20170308202025.17900-1-avarab@gmail.com> <20170309100910.z4h7bwqzxw2xynyu@sigill.intra.peff.net>
 <CACBZZX53rMiB5-cA_7-SeU2Dt7d_Cr7_GgyC0rjQQPPf4qyCqw@mail.gmail.com>
 <20170309104657.7pwreyozxo2tdhk4@sigill.intra.peff.net> <CACBZZX5i+8bQLhLB4DnUAaUw1vA_KQjhtNBvm7drLepPAFFbAQ@mail.gmail.com>
 <20170309125132.tubwxtneffok4nrc@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 9 Mar 2017 15:52:09 +0100
Message-ID: <CACBZZX4W7brFe5ecTvQPMmf4X5_zH+dw3cB5xeVg+2hWYps0Ug@mail.gmail.com>
Subject: Re: [PATCH] branch & tag: Add a --no-contains option
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 9, 2017 at 1:51 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 09, 2017 at 01:12:08PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > I'm almost certain this is because the contains_tag_algo one doesn't
>> > clean up the flag bits it sets on the commit objects. So running it
>> > twice in the same process is going to give you nonsense results.
>>
>> Yeah indeed.
>>
>> I tried to hack something up to avoid this, but the
>> lookup_commit_reference_gently() we call will return the same
>> object.parent pointer for two invocations, i.e. the underlying
>> {commit,object}.c API has a cache of objects it returns, couldn't find
>> some way to quickly make it burst that cache.
>
> Yeah, you'll always get the same struct for a given sha1.
>
>> The other approach of making contains_tag_algo() itself detect that
>> it's been called before (or us passing a flag) and going around
>> setting commit.object.flags on everything to 0 seemed even more
>> brittle, particularly since I think between filter->with_commit &
>> filter->no_commit we might end up visiting different commits, so it's
>> not easy to just clear it.
>
> You can clear the marks with clear_object_flags(). But I don't think
> that type of solution will quite help us here. We consider each ref
> independently and ask "does it match --contains" and "does it match
> --no-contains?". So there is no moment where we are done with all of the
> --contains marks, and can move on to the --no-contains ones. The lookups
> are interleaved.
>
> We could move to doing them in chunks (the way filter->merge_commit
> works), and then clearing in between. Or we could use a separate bitset.
> The patch below does that.
>
>> I'm happy to hack on it given some pointers, will visit it again, but
>> for now unless I'm missing something obvious / you can point out some
>> way to hack this up I'll just submit v2 with the combination of
>> --contains & --no-contains dying with a TODO message.
>>
>> The patch without that functionality is still really useful, and we
>> can implement that later.
>
> I'm not opposed to that, though see what you think of the patch below.
> It's a bit noisy but it's conceptually pretty straightforward. It should
> hopefully be obvious how you'd add in a separate contains_cache for the
> "without" case.

I wonder how worthwhile making the combination of options case fast &
adding more complexity is, as opposed to just using the slower path
for those cases via:

diff --git a/builtin/tag.c b/builtin/tag.c
index 737a83028a..d90e8675a8 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -53,7 +53,10 @@ static int list_tags(struct ref_filter *filter,
struct ref_sorting *sorting, con
        }

        verify_ref_format(format);
-       filter->with_commit_tag_algo =3D 1;
+       if ((filter->merge_commit + filter->with_commit +
filter->no_commit) > 1)
+               filter->with_commit_tag_algo =3D 0;
+       else
+               filter->with_commit_tag_algo =3D 1;
        filter_refs(&array, filter, FILTER_REFS_TAGS);
        ref_array_sort(sorting, &array);

I think I'll amend the tip of my WIP v2 to have something like that,
and then we can follow-up with making these cases where you supply
multiple options faster.

> Looking at this, I'm pretty sure that using "--contains" with "--merged"
> has similar problems, as they both use the UNINTERESTING bit. So even
> without your patch, there is a lurking bug.

I'm currently running this:
https://gist.github.com/avar/45cf288ce7cdc43e7395c6cbf9a98d68

with this patch to builtin/tag.c:

diff --git a/builtin/tag.c b/builtin/tag.c
index 737a83028a..b93c5e1754 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -56,2 +56,4 @@ static int list_tags(struct ref_filter *filter,
struct ref_sorting *sorting, con
        filter->with_commit_tag_algo =3D 1;
+       if (getenv("GIT_NO_TAG_ALGO"))
+               filter->with_commit_tag_algo =3D 0;

To smoke out any combinations of commits in git.git where with &
without the tag algo we already return different results, nothing so
far, but it's slow going.

> diff --git a/ref-filter.c b/ref-filter.c
> index 3820b21cc..42b1bc463 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -14,6 +14,7 @@
>  #include "git-compat-util.h"
>  #include "version.h"
>  #include "trailer.h"
> +#include "commit-slab.h"
>
>  typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>
> @@ -1137,10 +1138,22 @@ static void get_ref_atom_value(struct ref_array_i=
tem *ref, int atom, struct atom
>         *v =3D &ref->value[atom];
>  }
>
> +/*
> + * Unknown has to be "0" here, because that's what unfilled entries in o=
ur slab
> + * will return.
> + */
>  enum contains_result {
> -       CONTAINS_UNKNOWN =3D -1,
> -       CONTAINS_NO =3D 0,
> -       CONTAINS_YES =3D 1
> +       CONTAINS_UNKNOWN =3D 0,
> +       CONTAINS_NO =3D 1,
> +       CONTAINS_YES =3D 2,
> +};
> +
> +define_commit_slab(contains_cache, enum contains_result);
> +
> +struct ref_filter_cbdata {
> +       struct ref_array *array;
> +       struct ref_filter *filter;
> +       struct contains_cache contains_cache;
>  };
>
>  /*
> @@ -1171,24 +1184,25 @@ static int in_commit_list(const struct commit_lis=
t *want, struct commit *c)
>   * Do not recurse to find out, though, but return -1 if inconclusive.
>   */
>  static enum contains_result contains_test(struct commit *candidate,
> -                           const struct commit_list *want)
> +                           const struct commit_list *want,
> +                           struct contains_cache *cache)
>  {
> -       /* was it previously marked as containing a want commit? */
> -       if (candidate->object.flags & TMP_MARK)
> -               return 1;
> -       /* or marked as not possibly containing a want commit? */
> -       if (candidate->object.flags & UNINTERESTING)
> -               return 0;
> +       enum contains_result *cached =3D contains_cache_at(cache, candida=
te);
> +
> +       /* if we already found the answer, return it without traversing *=
/
> +       if (*cached)
> +               return *cached;
> +
>         /* or are we it? */
>         if (in_commit_list(want, candidate)) {
> -               candidate->object.flags |=3D TMP_MARK;
> -               return 1;
> +               *cached =3D CONTAINS_YES;
> +               return *cached;
>         }
>
>         if (parse_commit(candidate) < 0)
> -               return 0;
> +               return CONTAINS_NO;
>
> -       return -1;
> +       return CONTAINS_UNKNOWN;
>  }
>
>  static void push_to_contains_stack(struct commit *candidate, struct cont=
ains_stack *contains_stack)
> @@ -1199,10 +1213,11 @@ static void push_to_contains_stack(struct commit =
*candidate, struct contains_sta
>  }
>
>  static enum contains_result contains_tag_algo(struct commit *candidate,
> -               const struct commit_list *want)
> +                                             const struct commit_list *w=
ant,
> +                                             struct contains_cache *cach=
e)
>  {
>         struct contains_stack contains_stack =3D { 0, 0, NULL };
> -       int result =3D contains_test(candidate, want);
> +       enum contains_result result =3D contains_test(candidate, want, ca=
che);
>
>         if (result !=3D CONTAINS_UNKNOWN)
>                 return result;
> @@ -1214,16 +1229,16 @@ static enum contains_result contains_tag_algo(str=
uct commit *candidate,
>                 struct commit_list *parents =3D entry->parents;
>
>                 if (!parents) {
> -                       commit->object.flags |=3D UNINTERESTING;
> +                       *contains_cache_at(cache, commit) =3D CONTAINS_NO=
;
>                         contains_stack.nr--;
>                 }
>                 /*
>                  * If we just popped the stack, parents->item has been ma=
rked,
> -                * therefore contains_test will return a meaningful 0 or =
1.
> +                * therefore contains_test will return a meaningful yes/n=
o.
>                  */
> -               else switch (contains_test(parents->item, want)) {
> +               else switch (contains_test(parents->item, want, cache)) {
>                 case CONTAINS_YES:
> -                       commit->object.flags |=3D TMP_MARK;
> +                       *contains_cache_at(cache, commit) =3D CONTAINS_YE=
S;
>                         contains_stack.nr--;
>                         break;
>                 case CONTAINS_NO:
> @@ -1235,13 +1250,14 @@ static enum contains_result contains_tag_algo(str=
uct commit *candidate,
>                 }
>         }
>         free(contains_stack.contains_stack);
> -       return contains_test(candidate, want);
> +       return contains_test(candidate, want, cache);
>  }
>
> -static int commit_contains(struct ref_filter *filter, struct commit *com=
mit)
> +static int commit_contains(struct ref_filter *filter, struct commit *com=
mit,
> +                          struct contains_cache *cache)
>  {
>         if (filter->with_commit_tag_algo)
> -               return contains_tag_algo(commit, filter->with_commit);
> +               return contains_tag_algo(commit, filter->with_commit, cac=
he) =3D=3D CONTAINS_YES;
>         return is_descendant_of(commit, filter->with_commit);
>  }
>
> @@ -1438,7 +1454,7 @@ static int ref_filter_handler(const char *refname, =
const struct object_id *oid,
>                         return 0;
>                 /* We perform the filtering for the '--contains' option *=
/
>                 if (filter->with_commit &&
> -                   !commit_contains(filter, commit))
> +                   !commit_contains(filter, commit, &ref_cbdata->contain=
s_cache))
>                         return 0;
>         }
>
> @@ -1538,6 +1554,8 @@ int filter_refs(struct ref_array *array, struct ref=
_filter *filter, unsigned int
>                 broken =3D 1;
>         filter->kind =3D type & FILTER_REFS_KIND_MASK;
>
> +       init_contains_cache(&ref_cbdata.contains_cache);
> +
>         /*  Simple per-ref filtering */
>         if (!filter->kind)
>                 die("filter_refs: invalid type");
> @@ -1560,6 +1578,7 @@ int filter_refs(struct ref_array *array, struct ref=
_filter *filter, unsigned int
>                         head_ref(ref_filter_handler, &ref_cbdata);
>         }
>
> +       clear_contains_cache(&ref_cbdata.contains_cache);
>
>         /*  Filters that need revision walking */
>         if (filter->merge_commit)
> diff --git a/ref-filter.h b/ref-filter.h
> index 7b05592ba..89af9f451 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -71,11 +71,6 @@ struct ref_filter {
>                 verbose;
>  };
>
> -struct ref_filter_cbdata {
> -       struct ref_array *array;
> -       struct ref_filter *filter;
> -};
> -
>  /*  Macros for checking --merged and --no-merged options */
>  #define _OPT_MERGED_NO_MERGED(option, filter, h) \
>         { OPTION_CALLBACK, 0, option, (filter), N_("commit"), (h), \
