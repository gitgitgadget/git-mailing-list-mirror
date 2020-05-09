Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A8CC28CBC
	for <git@archiver.kernel.org>; Sat,  9 May 2020 10:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E735D20CC7
	for <git@archiver.kernel.org>; Sat,  9 May 2020 10:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="spPvQNcb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgEIKQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 06:16:20 -0400
Received: from mout.web.de ([212.227.17.11]:37965 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgEIKQU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 May 2020 06:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1589019371;
        bh=W5wf5sju8sSDTXkxEqrfUEN16RKtxogNiKyopDR+NwY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=spPvQNcbguOpKw0bipNSVsrH5UFNAN7MgzT75EtWuW9CJjgDB+4bGaCsO2+i2tuQu
         7Lg0vXt0v9PEj2p40OykFHzHVNDc9gYZw0tcHQ8EJ1Cijid5cHuYECWm/DHI/RXBhp
         JU2ILA7Zu4orrB5da91C7dMwY382otbakpECCNDo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.188]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N8Vop-1j2p2o1dp3-014MWn; Sat, 09
 May 2020 12:16:11 +0200
Subject: Re: invalid tree and commit object
To:     Brandon Williams <bwilliamseng@gmail.com>,
        git <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
References: <CALN-EhTpiLERuB16-WPZaLub6GdaRHJW8xDeaOEqSFtKe0kCYw@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d963242a-72f3-7f42-7c95-ea5148f74804@web.de>
Date:   Sat, 9 May 2020 12:16:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CALN-EhTpiLERuB16-WPZaLub6GdaRHJW8xDeaOEqSFtKe0kCYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UXJHydzd6R8B9eqdvjeLuqQwVJDHaiGACND6unZEKkj0Jo+5/Bl
 3y6iVD0sSZxqmOBUJGS16e2vGUZ6ul2hgDyVR7Wren73otZn5gcvdbtSvdH44xgjFBQuvO4
 4rS7oST19CVyweae2Hl8RpAEfOST2VA95Ybkm977VdaWF0NaCDplgKXpTVxbysOm/T8corX
 6H2sdov2KdHicngGwaK6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v/hbyc/RN2g=:cQxCrMY8jOza8EvFjJAkZ2
 jvHIk2b+oA141Q0v/m8y8tRFNKgdxSVajDpl7bTprOOglajNYkZ5qz+deRb27XFNIDpGeFafK
 AiUcqjvTtdYYjSfNXWwbrhonoN1PFn3EROauJJqEgMqGUYObkgd0daiMxoa68rl0/hGdFu01s
 bLtZqytP+rDMRIl5v8q478LR43ZGqkdcO9hz4gAwlDwhpTNIpCjh04cjRdWK8+0LMWMkMAyr8
 QFb641pWmB19eiEP2SqVhODbnrK+6HVxlrJgoQMJaEqgakI2SqxGoh91uStL8j5neRlpEETb7
 QxPqcaeMRcJ7prEUBru4hTh7Xq/575+r7QKUvZe/51MiudD6FNBZmTXSgxv8L41ukzz9ZsYij
 i2MUAntgyzhVeG6pco3OUnB/RbPCOX+pX+VMFY6mZGlUsKxWq3xCXRIPuU7B2g7FJrwvlv8el
 UvOT9UYxVGajiEENvZcakQgFknwkIuSsIR378PJ0izmBehai2WI2Dy2MULBBk1cYUeEQoMqvm
 A1w7QdR8mVLtkZqYo9MZOKNu2mUa7Et2rehd6zFB8jJdAJHZC2Ln56vf3FsyKiKQCNozLUEMm
 XPFdc6zTGbcnYK+vhN+eJeYIQv8rRRTV74usKsFylJDPFXRAiizEdf5+s+qQodXkLbO6bskGd
 cctPaPm1O89ukbI7E/75D2pbOG02zDTNB8GL4xThgT6tigzVGcTx+uyFEQ+9yHqkKVJCUYntz
 WYC9wHrd58snWK1aDCC+QEyvHp9ehFXwiDhmRnLEeQF9RCu29OzhZmemg85tMECtgfbbeCnDW
 d7z9SVjCYeoz6CVVF4GmHoJFWbvtzZaMlMS2cSZzf3D7OoTgCWxmg9G/3l4SOIJzHVgHKe6DU
 pmcrKJj6br9B7/Y+/0HDVhfL2jRPDveWluw1dKZlY0wStpB0U/SL9vB2p6LWi1SydOVBntQAM
 4TvHujcoQH/Sw/2vXsrjRlQQakJ5oVqHLbH+bm8qitj+Yzss8TaftHFeqe7MJnY4J7HOIQzwr
 6Gj2TPLh9gr+NfSS/JrzqY88Hxo5l+14JTEe3K+FZib0wOanqCQqrFzOiPf56Lky2zosalW2G
 pn2yaKNAAkSGCyb89LYXNGWCitB/z/g7/rteMPHUvSzUoftfMPVsyX52RbdwPGDZHYweJLEKV
 Ag7Dieg4CIrkaSv5+NqDDyDR30R4bzNbkDkPknoD/YJXRZ0eQxErq6fXXe4ZVJr6+uJbE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.05.20 um 08:19 schrieb Brandon Williams:
> Here's the setup:
>     tree c63d067eaeed0cbc68b7e4fdf40d267c6b152fe8
>     tree 6241ab2a5314798183b5c4ee8a7b0ccd12c651e6
>     blob 5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689
>
>     $ git ls-tree c63d067eaeed0cbc68b7e4fdf40d267c6b152fe8
>     100644 blob 5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689    hello
>     100644 blob 5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689    hello.c
>     040000 tree 6241ab2a5314798183b5c4ee8a7b0ccd12c651e6    hello

> Am I correct in assuming that this object is indeed invalid and should b=
e
> rejected by fsck?

I'd say yes twice -- what good is a tree that you can't check out because
it contains a d/f conflict?

So I got curious if such trees might be in popular repos, wrote the patch
below and checked around a bit, but couldn't find any.

Is there a smarter way to check for duplicates?  One that doesn't need
allocations?  Perhaps by having a version of tree_entry_extract() that
seeks backwards somehow?

=2D--
 fsck.c          | 10 ++++++++++
 t/t1450-fsck.sh | 16 ++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/fsck.c b/fsck.c
index 087a7f1ffc..f47b35fee8 100644
=2D-- a/fsck.c
+++ b/fsck.c
@@ -587,6 +587,8 @@ static int fsck_tree(const struct object_id *oid,
 	struct tree_desc desc;
 	unsigned o_mode;
 	const char *o_name;
+	struct string_list names =3D STRING_LIST_INIT_NODUP;
+	size_t nr;

 	if (init_tree_desc_gently(&desc, buffer, size)) {
 		retval +=3D report(options, oid, OBJ_TREE, FSCK_MSG_BAD_TREE, "cannot b=
e parsed as a tree");
@@ -680,8 +682,16 @@ static int fsck_tree(const struct object_id *oid,

 		o_mode =3D mode;
 		o_name =3D name;
+		string_list_append(&names, name);
 	}

+	nr =3D names.nr;
+	string_list_sort(&names);
+	string_list_remove_duplicates(&names, 0);
+	if (names.nr !=3D nr)
+		has_dup_entries =3D 1;
+	string_list_clear(&names, 0);
+
 	if (has_null_sha1)
 		retval +=3D report(options, oid, OBJ_TREE, FSCK_MSG_NULL_SHA1, "contain=
s entries pointing to null sha1");
 	if (has_full_path)
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 449ebc5657..91a6e34f38 100755
=2D-- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -257,6 +257,22 @@ test_expect_success 'tree object with duplicate entri=
es' '
 	test_i18ngrep "error in tree .*contains duplicate file entries" out
 '

+test_expect_success 'tree object with dublicate names' '
+	test_when_finished "remove_object \$blob" &&
+	test_when_finished "remove_object \$tree" &&
+	test_when_finished "remove_object \$badtree" &&
+	blob=3D$(echo blob | git hash-object -w --stdin) &&
+	printf "100644 blob %s\t%s\n" $blob x.2 >tree &&
+	tree=3D$(git mktree <tree) &&
+	printf "100644 blob %s\t%s\n" $blob x.1 >badtree &&
+	printf "100644 blob %s\t%s\n" $blob x >>badtree &&
+	printf "040000 tree %s\t%s\n" $tree x >>badtree &&
+	badtree=3D$(git mktree <badtree) &&
+	test_must_fail git fsck 2>out &&
+	test_i18ngrep "$badtree" out &&
+	test_i18ngrep "error in tree .*contains duplicate file entries" out
+'
+
 test_expect_success 'unparseable tree object' '
 	test_oid_cache <<-\EOF &&
 	junk sha1:twenty-bytes-of-junk
=2D-
2.26.2
