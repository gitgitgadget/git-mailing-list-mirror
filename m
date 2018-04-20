Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10B201F404
	for <e@80x24.org>; Fri, 20 Apr 2018 19:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbeDTTH7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 15:07:59 -0400
Received: from mout.gmx.net ([212.227.17.22]:54281 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751092AbeDTTH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 15:07:58 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MeMOx-1emH7537M7-00QAyH; Fri, 20
 Apr 2018 21:07:48 +0200
Date:   Fri, 20 Apr 2018 21:07:32 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
cc:     git@vger.kernel.org, Isaac Chou <Isaac.Chou@microfocus.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] fast-export: fix regression skipping some
 merge-commits
In-Reply-To: <20180420181248.2015922-1-martin.agren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804202041400.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <MW2PR18MB228432C95C18DE786957DE70E5B40@MW2PR18MB2284.namprd18.prod.outlook.com> <20180420181248.2015922-1-martin.agren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-372011290-1524251268=:4241"
X-Provags-ID: V03:K1:0lN3u3G22vqCws8t7ZPcX2oghpBvhD4iRplhBctynPK5WWhBb4z
 +ML1RhvUXXIHm8+Hs8iF9bxOnhpD8dJMNpocJFgLv9lRrqk+Wkk9ndDuAiV36khyUCrPjUp
 atCSp5mEArEeqj8vuxXXVlMsauRWokjW+LnvnqM3MWV/aDwy6e26xyzC05T3D4Zt7nVESWA
 Nl0tooN4gxj40fQtDqd5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EpDnYkAdbIQ=:XPSFTbHmAMC3u2PogBhSjf
 jz8AOkt/eJ8mn1ynPrX78X15vLsYQVkwjp8P1lokrkKWqliF9IndwMzmwf7//zWMexChK/LRv
 9EJEJHVBjZ3FY98tegG259N+jAfPV/lCL8pXlgKf696tqNkDpXeYHRIbUKz0HV9zDGQ1zRBxo
 ehSZ43jVujQxitm08fUAMsKlSs/8WcJERbM6hTrXHTRZTqM0OYCFfNGRcMF3VOXYa8Or9AAX5
 IoDXy0ZhfOEbA/uqTMCywCQCylUggu9+31uPG+gA7ZDNi8FtPgR456qZDAIj5azUxDx5vlsAo
 5PeIinMhEfav7hj8bMEiSZYSqb33tjEM4DXNhCnUEJshxkODPpDJsUvm/ZSlzTDWVY6kB5qxZ
 k77/seNHxc1wKkCGZ/I8NDHI4h6Mt+q2Q4Q4wU5ZekyhwFvHOAXARE6KNA5fQ5c5uwgAf6565
 1ir7Iy/pDQVU8B8HNtQixTGL6ZHGQDzt6Rt/YrBhWQQa86oDFL/OQYvn4p7Hs+nVW8kmjf9+G
 6nxMeQ44uUi3azYFoW/mk52jm8cJUJ39SRw7SdXBt5jATW5jfFQfGTwfK3yfV5WnjmSIqRn0u
 DHvb8S6ESNR2v+n8dJGqCn5zjerkeNHqmnOk47YkCDpRihhQ83XUtl+cqy0ZhfqU3HWAGNMBP
 GNV6xm1dWyqA6/fj8NgpMqk5XDiMaPwEWdA0Sl4QnuRUesmfFW2qTQ87RaJAAVJBLh1TV1woT
 tTvuiOEgz9bkvivt0CLovFrgUPnyvu2mUDIvqii2MHQF5g+05a8HrJwf76YajLHa2TicjAIOh
 hr8iqn268Z98XApfsGc5HJcJnJi2Fr2+AyxGHOb7/c92QlZ3Hg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-372011290-1524251268=:4241
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Martin,

On Fri, 20 Apr 2018, Martin =C3=85gren wrote:

> 7199203937 (object_array: add and use `object_array_pop()`, 2017-09-23)
> noted that the pattern `object =3D array.objects[--array.nr].item` could
> be abstracted as `object =3D object_array_pop(&array)`.
>=20
> Unfortunately, one of the conversions was horribly wrong. Between
> grabbing the last object (i.e., peeking at it) and decreasing the object
> count, the original code would sometimes return early. The updated code
> on the other hand, will always pop the last element, then maybe do the
> early return before doing anything with the object.
>=20
> The end result is that merge commits where all the parents have still
> not been exported will simply be dropped, meaning that they will be
> completely missing from the exported data.

Excellent explanation.

> Reintroduce the pattern of first grabbing the last object (using a new
> function `object_array_peek()`), then later poping it. Using
> `..._peek()` and `..._pop()` makes it clear that we are referring to the
> same item, i.e., we do not grab one element, then remove another one.

Instead of using _peek() and _pop() and having to reason about the
correctness, maybe we should simply re-push? See below for my suggested
alternative.

> My sincerest apologies for the stupid train-wreck that the original
> conversion was. Weird interactions between different components can make
> for fun bugs, but this one is just embarassing.

The only way to fail is by doing something. You did something. That is
much better than not doing anything. So please do not be sorry about
introducing a breakage. You did fix it, which makes you double awesome.

> Isaac, this should solve the problem you are seeing. Unfortunately, I do
> not have any experience with building Git for Windows [1]. I really hope
> that this bug did not take up too much of your time. Or eat your data!

It is as easy as

=09git clone --depth=3D1 https://github.com/git-for-windows/git-sdk-64

(downloading half a gigabyte of objects, but then you have almost
everything except for the Git source and one support repository for Git
for Windows), then starting git-bash.exe in its toplevel directory and
calling

=09sdk build git

in there. The `sdk` helper is in its infancy, so I could imagine that a
really neat thing would be to be able to build custom branches and bundle
them in a portable Git. Something like `sdk build portable-git --patch
https://public-inbox.org/git/20180420181248.2015922-1-martin.agren@gmail.co=
m/`.

In the meantime, it should still be doable by calling

=09sdk cd git
=09sdk init build-extra
=09/usr/src/build-extra/apply-from-public-inbox.sh https://public-inbox.org=
/git/20180420181248.2015922-1-martin.agren@gmail.com/
=09make -j15 && make -j15 strip && make -j15 install
=09sdk build installer

and then running that installer.

You could also build a portable Git instead by replacing the last line
with

=09/usr/src/build-extra/portable/release.sh 0-test

Or if you want to avoid building a portable Git installer, and instead
copy the files directly, you could try this sequence:

=09pacman -S --noconfirm rsync
=09mkdir ~/my-test-git
=09(cd / && rsync -Rau $(ARCH=3Dx86_64 BITNESS=3D64 \
=09=09usr/src/build-extra/make-file-list.sh) ~/my-test-git/)

Please let me know how it is going, I am always eager to make the Git for
Windows SDK easier to use, as it will ultimately save me time.

> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index 866ddf6058..2b46a83a49 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -540,4 +540,26 @@ test_expect_success 'when using -C, do not declare c=
opy when source of copy is a
>  =09test_cmp expected actual
>  '
> =20
> +test_expect_success 'todo' '
> +=09test_create_repo merging &&
> +=09git -C merging commit --allow-empty -m initial &&

I see that you copied the style of the latest test case, but I have to
admit that I would find it much easier to read if it said:

=09(
=09=09cd merging &&
=09=09test_commit initial &&
=09=09git checkout -b topic &&
=09=09test_commit on-branch &&
=09=09git checkout master &&
=09=09test_commit on-master &&
=09=09test_tick &&
=09=09git merge --no-ff -m Yeah topic &&

=09=09echo ":1 $(git rev-parse HEAD^^)" >marks &&
=09=09git fast-export --import-marks=3Dmarks master >out &&
=09=09grep Yeah out
=09)

i.e. using the subshell where you cd into merging/ first thing, and then
making extensive use of `test_commit`.

> +
> +=09git -C merging checkout -b topic &&
> +=09>merging/topic-file &&
> +=09git -C merging add topic-file &&
> +=09git -C merging commit -m topic-file &&
> +
> +=09git -C merging checkout master &&
> +=09>merging/master-file &&
> +=09git -C merging add master-file &&
> +=09git -C merging commit -m master-file &&
> +
> +=09git -C merging merge --no-ff topic -m "merge the topic" &&
> +
> +=09oid=3D$(git -C merging rev-parse HEAD^^) &&
> +=09echo :1 $oid >merging/git-marks &&
> +=09git -C merging fast-export --import-marks=3Dgit-marks refs/heads/mast=
er >out &&
> +=09grep "merge the topic" out
> +'
> +
>  test_done
> diff --git a/object.h b/object.h
> index f13f85b2a9..4d8ce280d9 100644
> --- a/object.h
> +++ b/object.h
> @@ -129,6 +129,15 @@ void add_object_array_with_path(struct object *obj, =
const char *name, struct obj
>   */
>  struct object *object_array_pop(struct object_array *array);
> =20
> +/*
> + * Returns NULL if the array is empty. Otherwise, returns the last objec=
t.
> + * That is, the returned value is what `object_array_pop()` would have r=
eturned.
> + */
> +inline struct object *object_array_peek(const struct object_array *array=
)

I looked, and this would be the first use of `inline` without `static`...

> +{
> +=09return array->nr ? array->objects[array->nr - 1].item : NULL;
> +}
> +
>  typedef int (*object_array_each_func_t)(struct object_array_entry *, voi=
d *);
> =20
>  /*
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 27b2cc138e..8377d27b46 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -650,9 +650,10 @@ static void handle_tail(struct object_array *commits=
, struct rev_info *revs,
>  {
>  =09struct commit *commit;
>  =09while (commits->nr) {
> -=09=09commit =3D (struct commit *)object_array_pop(commits);
> +=09=09commit =3D (struct commit *)object_array_peek(commits);
>  =09=09if (has_unshown_parent(commit))
>  =09=09=09return;
> +=09=09(void)object_array_pop(commits);
>  =09=09handle_commit(commit, revs, paths_of_changed_objects);
>  =09}
>  }

As I stated above, I think we can make this a bit easier to reason about
(and less easy to break by future additions) if we avoided the _peek()
function altogether, like this:

 {
 =09struct commit *commit;
 =09while (commits->nr) {
 =09=09commit =3D (struct commit *)object_array_pop(commits);
-=09=09if (has_unshown_parent(commit))
+=09=09if (has_unshown_parent(commit)) {
+=09=09=09/* Queue again, to be handled later */
+=09=09=09add_object_array(commits, NULL, commit);
 =09=09=09return;
+=09=09}
 =09=09handle_commit(commit, revs, paths_of_changed_objects);
 =09}
 }

(I did not test this, and I was honestly surprised that there is no
object_array_push() counterpart to _pop() ;-) So this might be all wrong.)

Ciao,
Johannes
--8323329-372011290-1524251268=:4241--
