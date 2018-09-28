Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 461421F453
	for <e@80x24.org>; Fri, 28 Sep 2018 00:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbeI1GvW (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 02:51:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41117 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbeI1GvW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 02:51:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id m77-v6so3024014pfi.8
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 17:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9mOF5maE3FQCwh9FUBy0dQRxL5q+L9ue6IlK6/9IgFI=;
        b=kiMoqMUGNcga23vB0euLHG4cTE0a5XC4sbdTeSEkbcNMSS3YF3OeOxYsWF77lGnDJo
         BAKrtVdO33sn77LbTfZ5JjBHVubzoIis/JW4D3DWeVKrMk3dqdz9HTPzqmKczw2ENLl+
         /bOhUQi/eJFNAxIfQRzetUJjuhMXezwvBQfbQA+s6eO8ceOMR1o2GR0eFY3WOXpzBhyp
         L9yEO5X++L+iMvbajfyFnTgzMvqYK5F564WD/seKWsnZwT+lUYJR1l/eNBj1YqiV133K
         uv5SWrRLGhjgUWop9taLQqRTbAnhFSTGz4FOUNWEfw9KbZz+CXuQBxUC1ApfMiARotMJ
         Bx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9mOF5maE3FQCwh9FUBy0dQRxL5q+L9ue6IlK6/9IgFI=;
        b=HG8gpmP4A1rXMc6N1zUa+nIetDzi8bFXbxdgXZugjhXV4r32unDdp8e6AWlK0oYHHW
         t7Hc00w6NRGU4p+47AQHY5q1yHbsv87VGq4fb+thDHbxgsGK/x7GujsqCTuFSRuzKz+t
         cyUkfUP2iDcvrSvk0H0qkZuXzvVVNhmYp2v5CmggXhDMuHA+WRlpWF4paVEsFa6C2y4V
         gwLZ43n5WOLc11TlJLoViuLMNYxdZQjqWxN1CWMll8pu5kGKy6pmeUeK+ILm0L5jkSEH
         OFWRFvTH9Y0uJn60j5UqheEdEmZotmIxsXUG8uyZzlTg6orYFRnmXWArN2ddZU9cnB7M
         VP0g==
X-Gm-Message-State: ABuFfojR2hBfID/pVA+RWBMSnL5WLsK3mr2BsbvF8gNiYvQEj0pYzH9K
        v+knhVc2MUUUsnVBqopyGxPycXuC
X-Google-Smtp-Source: ACcGV62XqOSgQRiLwwO3djVA+jYdJJG5AwJDgB+dy6qAF0aq434a+CV1u3fr9dXHm5ECzK2giGsOBA==
X-Received: by 2002:a65:4cc3:: with SMTP id n3-v6mr3527251pgt.257.1538094623629;
        Thu, 27 Sep 2018 17:30:23 -0700 (PDT)
Received: from smckelvie-mbp2tb.corp.xevo.com (hq.xevo.com. [4.14.243.50])
        by smtp.gmail.com with ESMTPSA id 189-v6sm4892150pfe.121.2018.09.27.17.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 17:30:22 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] submodule: Alllow staged changes for
 get_superproject_working_tree
From:   Sam McKelvie <sammck@gmail.com>
In-Reply-To: <xmqqbm8ifvka.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 27 Sep 2018 17:30:21 -0700
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D09E2583-BD1D-4C56-9C19-6B1E97CEEDAA@gmail.com>
References: <20180927181054.25802-1-sammck@gmail.com>
 <xmqqbm8ifvka.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of your comments seem reasonable; however, since the patch was =
signed off by Stefan it
Is unclear to me whether I should submit another patch or what. I =
apologize for not being
facile with the patching workflow.

> On Sep 27, 2018, at 3:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Sam McKelvie <sammck@gmail.com> writes:
>=20
>> Subject: Re: [PATCH] submodule: Alllow staged changes for =
get_superproject_working_tree
>=20
> s/Alllow/allow/;
>=20

Ok, no caps on first letter of subject.

>> Invoking 'git rev-parse --show-superproject-working-tree' exits with
>>=20
>>    "fatal: BUG: returned path string doesn't match cwd?"
>>=20
>> when the superproject has an unmerged entry for the current =
submodule,
>> instead of displaying the superproject's working tree.
>>=20
>> The problem is due to the fact that when a merge of the submodule =
reference
>> is in progress, "git ls-files --stage =E2=80=94full-name =
<submodule-relative-path>=E2=80=9D
>> returns three seperate entries for the submodule (one for each stage) =
rather
>> than a single entry; e.g.,
>>=20
>> $ git ls-files --stage --full-name submodule-child-test
>> 160000 dbbd2766fa330fa741ea59bb38689fcc2d283ac5 1       =
submodule-child-test
>> 160000 f174d1dbfe863a59692c3bdae730a36f2a788c51 2       =
submodule-child-test
>> 160000 e6178f3a58b958543952e12824aa2106d560f21d 3       =
submodule-child-test
>>=20
>> The code in get_superproject_working_tree() expected exactly one =
entry to
>> be returned; this patch makes it use the first entry if multiple =
entries
>> are returned.
>>=20
>> Test t1500-rev-parse is extended to cover this case.
>>=20
>> Signed-off-by: Sam McKelvie <sammck@gmail.com>
>> ---
>> submodule.c          |  2 +-
>> t/t1500-rev-parse.sh | 17 ++++++++++++++++-
>> 2 files changed, 17 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/submodule.c b/submodule.c
>> index 33de6ee5f..5b9d5ad7e 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -1885,7 +1885,7 @@ const char *get_superproject_working_tree(void)
>> 		 * We're only interested in the name after the tab.
>> 		 */
>> 		super_sub =3D strchr(sb.buf, '\t') + 1;
>> -		super_sub_len =3D sb.buf + sb.len - super_sub - 1;
>> +		super_sub_len =3D strlen(super_sub);
>=20
> As we are reading from "ls-files -z -s", we know that the name is
> terminated with NUL, so we can just use strlen().  Good.
>>=20
>> 		if (super_sub_len > cwd_len ||
>> 		    strcmp(&cwd[cwd_len - super_sub_len], super_sub))
>> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
>> index 5c715fe2c..b774cafc5 100755
>> --- a/t/t1500-rev-parse.sh
>> +++ b/t/t1500-rev-parse.sh
>> @@ -134,7 +134,6 @@ test_expect_success 'rev-parse =
--is-shallow-repository in non-shallow repo' '
>> test_expect_success 'showing the superproject correctly' '
>> 	git rev-parse --show-superproject-working-tree >out &&
>> 	test_must_be_empty out &&
>> -
>=20
> I have a feeling that this break made the series of tests in this
> block easier to follow.  Shouldn't we be moving in the other
> direction, namely =E2=80=A6
>=20
That=E2=80=99s fair.


>> 	test_create_repo super &&
>> 	test_commit -C super test_commit &&
>> 	test_create_repo sub &&
>> @@ -142,6 +141,22 @@ test_expect_success 'showing the superproject =
correctly' '
>> 	git -C super submodule add ../sub dir/sub &&
>> 	echo $(pwd)/super >expect  &&
>> 	git -C super/dir/sub rev-parse --show-superproject-working-tree =
>out &&
>> +	test_cmp expect out &&
>=20
> Here is an end of one subtest, deserves to have a break like the =
above.

OK

>=20
>> +	test_commit -C super submodule_add &&
>> +	git -C super checkout -b branch1 &&
>> +	git -C super/dir/sub checkout -b branch1 &&
>> +	test_commit -C super/dir/sub branch1_commit &&
>> +	git -C super add dir/sub &&
>> +	test_commit -C super branch1_commit &&
>> +	git -C super checkout master &&
>> +	git -C super checkout -b branch2 &&
>> +	git -C super/dir/sub checkout master &&
>> +	git -C super/dir/sub checkout -b branch2 &&
>> +	test_commit -C super/dir/sub branch2_commit &&
>> +	git -C super add dir/sub &&
>> +	test_commit -C super branch2_commit &&
>> +	test_must_fail git -C super merge branch1 &&
>=20
> and all of the above is just a set-up for another subtest, so a
> solid block of text like we see in the above is good.
>=20
> 	Side note: there are a few of
>=20
> 		git -C $there checkout $onebranch &&
> 		git -C $there checkout -b $anotherbranch &&
>=20
> 	as recurring pattern.  Shouldn't they be more like a single
> 	liner
>=20
> 		git -C $there checkout -b $anotherbranch $onebranch &&
>=20
> 	?  It wasn't clear if the split was an attempt to hide some
> 	breakage (e.g. "checkout -b B A" did not work but "checkout
> 	A && checkout -b B" did) or just being verbose because the
> 	author is not used to "checkout -b B A" form.

You=E2=80=99re right, the two forms are equivalent and the single-line =
version is simpler.

>=20
>> +	git -C super/dir/sub rev-parse --show-superproject-working-tree =
>out &&
>> 	test_cmp expect out
>> '
>=20
> Thanks.

Thank you.

