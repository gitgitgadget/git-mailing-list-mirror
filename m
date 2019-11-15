Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B40E1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 11:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfKOLLV (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 06:11:21 -0500
Received: from mout.web.de ([212.227.15.3]:50969 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727142AbfKOLLV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 06:11:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573816272;
        bh=rIVAt5NjqgnjpMg0W6FbKpwXu03opeByzuVXjlt/xYk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kMpCx0MFGNeqFmp7Yg+P5+/7JNwOLNWSKDky2g4J/4nVIAvB7pFaxrFb41quVVzuL
         XXHdw6HB6HJjK9f240MIMn2ohPIlTUyQjYWeqCKFmsSuIJGAcOpgAHO7/d/CMnExp3
         HJ2br5fDFoBroogrwgse7M9LtPZlZUQAYP3iXAPo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.93.34]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lc8rF-1i4Euj1QcH-00jdkZ; Fri, 15
 Nov 2019 12:11:12 +0100
Subject: Re: git-coccinelle: adjustments for array.cocci?
To:     Coccinelle <cocci@systeme.lip6.fr>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <xmqqa790cyp1.fsf@gitster-ct.c.googlers.com>
 <fe9b8c08-6fd4-d378-f3ff-8170381b10e0@web.de>
 <xmqqr22b9ptk.fsf@gitster-ct.c.googlers.com>
 <ba5d609a-16ea-d7e9-66e6-19aab94b2acd@web.de>
 <53346d52-e096-c651-f70a-ce6ca4d82ff9@web.de>
 <6c4ef61f-5fef-ffc8-82d6-ee42006756b4@web.de>
 <aed296a6-bae0-6fcc-515e-ef96fed24ca6@web.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6fffd13a-738b-e750-9f5a-f0bfb252855b@web.de>
Date:   Fri, 15 Nov 2019 12:11:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <aed296a6-bae0-6fcc-515e-ef96fed24ca6@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3JLiDdjFnIuaXWVj3YavJ2Ip3X07n3DMfUXqMGH2uQbDQTsZQby
 WBLQnDn//mBgrooUXJydl3vkHd3LR4NTXh43P+hIH2LFQ0WWs/zQRcjdlLLpWbOOsIyhVOc
 PRvVsH1tuQcZglM/TxsCmVZCyGO8MC2M0W427kGHNjIRF3OT+NSHm4Qz1je4VIv7i7b9Rne
 pc5nGRLzeufQle1sJn32A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dsz2rt24rOc=:iDonXNDM+FivrzBIdami0U
 74zHMaOPGb6F2YG8fwTb1W6tzOV3vULMmQ2v/nmkdmr8KAxJuMemB5tozKTxuE8AIfG0gnSiK
 a3y5IWgI3XClN6nVxmMukqxDHeYwSpK3PrYEzX/lLoAcf7lVOoizn6gDqT9Qahx02hOYa6FKC
 VkecWm9onmPJVb1+RQFTEtJa0eE1iIuwUxSbS2kCmsWGoCFnCfSjgRobjEZfa80sJfJP2xnjh
 9HNgJUus9mAs01Aj2CDhdnfN5n/xEObn8DhgkUcjus5ni7ASJZRUhhHNRWNtoaOELWpRSggkG
 clchrldo4g7JzSEW/hYnOUwUDZrxQj7yEVF6zaWursPbEi9Vc4Yaa2rNtlEBODd5tQ60QWTsX
 zua5DJV56NC+Nx0DLDLhsIsitVGAKUUSvT8EheCEZh7rgNcaheDKPuS5xtxKjxPHZ5i4wmWfG
 v3OmiZvnilR+YjVntSGml/FSc4fT49Yx8TC3pDHZ82Dqr6LSs3Q/ZoTIvpVRk+NA6qt0jH+k8
 CpTwyRN9//sG/tFAARdBbJTyWxIFunhG86BYQ7bz1STA//wYqNaUYsWC8/k5i1fAHzCb7YRw5
 5KOy2SHaC4rOkYx7HRq0jZwSusgIT7Sec2mVlyVoFENBGy4i6oX4qx1TdHvAFeJ5EK7mf/TM3
 nIU4orzn4qPvUeYK4nbqf/LA6nW3rtmgbzC4Ob6odA7S8bS1K0yYZgG6jmtRALidSd6AJ3klR
 +lsbBFuYE8rctWlHt97ot1suQDRyCHByOiSXK+ri2KLfORNMgyTd0Lz1EfmWbJ4iKYLHAbIKW
 hX76Sq6AyowatitNJMf2UmEtutrUxFVkPM9TVpl7AfFKJx11R/n6Xwb0w7e2AO1mKba2Nm8ab
 gHIE2Zz3F0p/mNW9s8RddCIjQ2mWl8GpcNE/LFoL2uQSiod8VORy4y+RdshXpZsnt3T9ar4xh
 blVDqWZmJbzOV3awP1kZu8aBOHzw9JGFkrb22/3USu7/mgWjunE5wSgo3UoQkfty35QHSxZwq
 c5SBe4u4n3NpZsFoRjNWFvTO3miL0Prk1WJ3jFgpLNtV0d80Ng4jG1KoNK2HlDuXDz6Qv4eax
 qgRzNJVW9Gd3CT+nrbUUhO1sDFnR0KFnhTQIBbIC+Qzmb+bSW273/8MPBgq2Eqb7uQZi6BrKt
 yBXdtqxlNzB7024K19JIEwXvd7giU7lZn4+Y5Vw19NRGadOcCcQTSyNbqP+4X7jgLmIXPoT3p
 CkObWukdSScOpYTvoifMzFxuo3JSH3l/tkcXYHnKUHZxCXkFB6gHLLATvGk4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Anyway, someone who can reproduce the issue using the latest release
> of Coccinelle would be in a better position to file a bug report.

Hello,

I repeated the discussed source code transformation approach together
with the software combination =E2=80=9CCoccinelle 1.0.8-00004-g842075f7=E2=
=80=9D (OCaml 4.09).
https://github.com/coccinelle/coccinelle/commits/master

1. Yesterday I checked the source files out for the software =E2=80=9CGit=
=E2=80=9D
   according to the commit =E2=80=9CThe first batch post 2.24 cycle=E2=80=
=9D.
   https://github.com/git/git/commit/d9f6f3b6195a0ca35642561e530798ad1469b=
d41

2. I restored a previous development status by the following command.

   git show 921d49be86 | patch -p1 -R

   See also:
   https://public-inbox.org/git/53346d52-e096-c651-f70a-ce6ca4d82ff9@web.d=
e/

3. I stored a generated patch based on the currently released SmPL script.
   https://github.com/git/git/blob/177fbab747da4f58cb2a8ce010b3515c86dd67c=
9/contrib/coccinelle/array.cocci

4. I applied the following patch then.

diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.coc=
ci
index 46b8d2ee11..89df184bbd 100644
=2D-- a/contrib/coccinelle/array.cocci
+++ b/contrib/coccinelle/array.cocci
@@ -12,27 +12,21 @@ T *ptr;
 T[] arr;
 expression E, n;
 @@
-(
-  memcpy(ptr, E,
=2D- n * sizeof(*(ptr))
-+ n * sizeof(T)
-  )
-|
-  memcpy(arr, E,
=2D- n * sizeof(*(arr))
-+ n * sizeof(T)
-  )
-|
-  memcpy(E, ptr,
=2D- n * sizeof(*(ptr))
-+ n * sizeof(T)
-  )
-|
-  memcpy(E, arr,
=2D- n * sizeof(*(arr))
-+ n * sizeof(T)
-  )
+ memcpy(
+(       ptr, E, n *
+-       sizeof(*(ptr))
++       sizeof(T)
+|       arr, E, n *
+-       sizeof(*(arr))
++       sizeof(T)
+|       E, ptr, n *
+-       sizeof(*(ptr))
++       sizeof(T)
+|       E, arr, n *
+-       sizeof(*(arr))
++       sizeof(T)
 )
+       )

 @@
 type T;

   I suggested in this way to move a bit of SmPL code.

5. I stored another generated patch based on the adjusted SmPL script.

6. I performed a corresponding file comparison.

=2D-- array-released.diff	2019-11-14 21:29:11.020576916 +0100
+++ array-reduced1.diff	2019-11-14 21:45:58.931956527 +0100
@@ -6,24 +6,10 @@
  	r->entry_count =3D t->entry_count;
  	r->delta_depth =3D t->delta_depth;
 -	memcpy(r->entries,t->entries,t->entry_count*sizeof(t->entries[0]));
-+	COPY_ARRAY(r->entries, t->entries, t->entry_count);
++	memcpy(r->entries,t->entries,t->entry_count*sizeof(*(t->entries)));
  	release_tree_content(t);
  	return r;
  }
-diff -u -p a/pretty.c b/pretty.c
=2D--- a/pretty.c
-+++ b/pretty.c
-@@ -106,8 +106,8 @@ static void setup_commit_formats(void)
- 	commit_formats_len =3D ARRAY_SIZE(builtin_formats);
- 	builtin_formats_len =3D commit_formats_len;
- 	ALLOC_GROW(commit_formats, commit_formats_len, commit_formats_alloc);
=2D-	memcpy(commit_formats, builtin_formats,
=2D-	       sizeof(*builtin_formats)*ARRAY_SIZE(builtin_formats));
-+	COPY_ARRAY(commit_formats, builtin_formats,
-+		   ARRAY_SIZE(builtin_formats));
-
- 	git_config(git_pretty_formats_config, NULL);
- }
 diff -u -p a/packfile.c b/packfile.c
 --- a/packfile.c
 +++ b/packfile.c
@@ -36,17 +22,6 @@
  		} else {
  			ALLOC_GROW(poi_stack, poi_stack_nr+1, poi_stack_alloc);
  		}
-@@ -1698,8 +1698,8 @@ void *unpack_entry(struct repository *r,
- 		    && delta_stack =3D=3D small_delta_stack) {
- 			delta_stack_alloc =3D alloc_nr(delta_stack_nr);
- 			ALLOC_ARRAY(delta_stack, delta_stack_alloc);
=2D-			memcpy(delta_stack, small_delta_stack,
=2D-			       sizeof(*delta_stack)*delta_stack_nr);
-+			COPY_ARRAY(delta_stack, small_delta_stack,
-+				   delta_stack_nr);
- 		} else {
- 			ALLOC_GROW(delta_stack, delta_stack_nr+1, delta_stack_alloc);
- 		}
 diff -u -p a/compat/regex/regexec.c b/compat/regex/regexec.c
 --- a/compat/regex/regexec.c
 +++ b/compat/regex/regexec.c


How do you think about the differences from this test result?

Regards,
Markus
