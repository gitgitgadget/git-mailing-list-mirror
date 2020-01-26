Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5A6C2D0DB
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 21:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40C2206F0
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 21:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Q2VEmVNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgAZV3O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 16:29:14 -0500
Received: from mout.gmx.net ([212.227.15.18]:35275 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbgAZV3O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jan 2020 16:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580074139;
        bh=sXaxcjjboJU4DytXkL4YYSz57a+I3FwBMCiR1TBI8ow=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Q2VEmVNVgY9n1vbrQbOdiKxnhyIdXZTnxJXiyfLOhsF7ErbVn5s7Txs0NcsVNZSRL
         QVAKbjDiTAphEAtyDRuLr7QxWaPRFz+TqInCKf9HEf3EMU5V2/V3K1Do/2o0zz50tn
         9HVZNDwuUSFXBowIBFsObX1al/iFjU8VWGXMyaLk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnps0-1jO4o433eM-00pJKI; Sun, 26
 Jan 2020 22:28:58 +0100
Date:   Sun, 26 Jan 2020 22:28:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johan Herland <johan@herland.net>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 03/22] t3305: annotate with SHA1 prerequisite
In-Reply-To: <CALKQrgcF0KK1gEvyKe3th2w0YJBbmv+grgbCeN4fOzHKo=H1UA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001261957060.46@tvgsbejvaqbjf.bet>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net> <20200125230035.136348-4-sandals@crustytoothpaste.net> <nycvar.QRO.7.76.6.2001261209590.46@tvgsbejvaqbjf.bet> <CALKQrgcF0KK1gEvyKe3th2w0YJBbmv+grgbCeN4fOzHKo=H1UA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PudTT3HcyK9DoLBQZwxQt7+d/lIcK+nK0GSD92o4jRefiFWSPNp
 MvDUQbMpslsKxP0Uk3SA7jjDzq/2mc8vYkswDQuGfEHwdUaQY7u5FzXCInju+MOYmv6stEk
 StvBhoHRwnJMj6vAJCJSC7cRAZx/uaHxqr5IJjTc17gPVrA7Q9c2yfwww691OvPKiD9DAvC
 3xne66t1sX4iRBK/OlNjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cCAE7mzcLc8=:aEQjGQDB1D5q/V5rYX1LIR
 DCbSJcnXhAAKfdBaQFPjKEqwWpQT8JONCbeA6dWueNLuV+GbNzO3m5BXei88KiscuquhH0ZAC
 frOd23G8IW34u3++qwqMfD0+D6oJcyU5uaNHvi0MOMSmDJVZREqbfYq9cwge411gZKFIvhmSj
 uoh+5WRoSaVHv/UORwqTGPipkhjeZ0z1zBQ0mXhVDFqStoeVTB8k7iGQumJWY2twSjcQXGX5H
 Wq72YRpPX1pEdptCthNw+0BCTUKNZh4LGkDN9lA6NUPF2TacZvlpBUIfcMu1lApcWE5JX4ZPD
 zG/FhnEwG679SjpcqMNKE212x1+mkDjQ4KDIkBTJMgqmgSj7yxEbKp3UNRbUDX4Uq2hF4pFYh
 Q16Nns9x0BCwgs/OmekHEjh5A99txUcm2+VJAPqTWsvUJThAFZddUE9rhXPerei8gD2Czj1w3
 HHIQ7QyKmdm3Pvd6Tulvc+vhz5E+1vRsIUWJ158ZJOD0sc07pIPNopGDXmrFbPZoHBLEF1sNm
 q1ZxXmF0/LcbUvQFYBuw4PtWZedOuE3ufvc6q5WI1Im8U6RsbLiEREWxZLWTXki174Rj7nnvE
 8sF9zDnuU+5jdxy6XCIiZJ+Ydg/TX/1wVbEq6AbR8kLYXWvr3yHjsrmn9P9GjAjIG8Crw0G4g
 1quoMB4SmtYgkdMIJQB8i3epzgE+v7kp4Ux1GziqyMaIiU7u16D+oV+lV2icb2vLUQBAUnvzy
 RpdGFpL2ijZ3aV6NFk3ZVcJzZG12eL10mOBquXkDnN83nTNzaNzfWwfwO2IFaKWTrVZ2+8uyi
 hEsNpm3FQmhDVADWovSsApYexo8IhY6WEME8U5wsUpoKhliWkwhOLWdZtg9J+dspmfzYH+I1E
 tOYQnqdGzRe8NMypBH3a80SrHP3DmW2NTn+xY8Srkzbnv5hsB0/sVNW92uol47Dw3rhCwANNK
 I4Zpe95Af7AZipANTI/Vg8A19rwO0Duazz8hTPaNSAUauopMFImzBh7MkSf/uHjSex2Fci0hI
 XuKNYJ93cNTvXZPc4l1sagbfngnDulwiXZB69ygkGJk3eKlnoCYU29X6Cvnct1sJf4DeN4+0E
 FxdP3k3xFNG13EEQ4wg2428UZXPHepukgSQTw223gKby89ZWJSK8HcY2nScgfFdBX9V2rZW8n
 AXxxJtb8XXUQ8slpTcIO7iTvf+0NgSU9dc0DRW4pB7yka951cJIoDmuqCDoa0nE/OU+y3IXjH
 ACgMT+5P2eENKfbZZ
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johan,

On Sun, 26 Jan 2020, Johan Herland wrote:

> On Sun, Jan 26, 2020 at 12:16 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Sat, 25 Jan 2020, brian m. carlson wrote:
> > > This test relies on a roughly equal distribution of hashes for notes=
 in
> > > order to ensure that fanouts are compressed.  If there are subtrees =
with
> > > only one item left after removing notes, they'll end up still with o=
ne
> > > level of fanout, causing the test to fail.
> >
> > That is _almost_ correct: The heuristic wants to see one bucket that h=
as
> > a note in it. Or something like that.
> >
> > See 73f77b909f8 (Notes API: for_each_note(): Traverse the entire notes
> > tree with a callback, 2010-02-13) for details. (Cc:ing Johan.)
>
> Something like that, yeah... Re-reading this code, I believe we stop
> the fanout at the current level when we can find one or more notes
> that do not share the high-nibble of their path with another note.
>
> Here we're at the top level, so this corresponds to looking at the
> very first hex character (0-9a-f) of the path (oid of annotated
> object), and if there are at least two such objects for each hex
> character, we will use a fanout of 1, otherwise, we collapse the
> fanout to 0.

That makes sense, but when I looked at the failed test, there seems
something else at play, at least in addition to what you said: for
_adding_ notes, your description is 100% accurate, but when deleting
notes, we are apparently not collapsing `PTR_TYPE_SUBTREE` nodes "quickly"
enough. Let me show you the part of `git ls-tree -r refs/notes/commits`
that starts with the hex digits 7, 8 and 9:

=2D- snip --
100644 blob 22939636f79a53181ea58f04f2136bd745976edd0018465e60a8df89816a9c=
2b 72/67b1c94ab5ddf005fd4b0e50b6a7816a62e7ed0459cec6aa1a00577b2111ba
100644 blob 2e3f3dad7043b2d02d09ca12b299acbe05d781357d3a56a2d012fdf7874094=
59 76/62d4b264094ca479be86ef7aa66daae63e45afa633a3892dc787b13ecff495
100644 blob 22e7f0c5af7315d692f8a107a43ba0784e1ab00a20ea803fab1acad1319e5f=
79 7b/8c0a9c86815a94da7ef90b356b1f98d6a4099af3fdc3d8625a8fa793b63821
100644 blob b3ce67c9d5507dc00d95d8fb2000c1d5b70908ad1d2c034e5833f57b7bb855=
11 7f/0af9cf9259cd6e67c0af3324ca443dd3d56694fbdc94d28e300a768d3d0e6e
100644 blob fafb40e32e87a2c481df6ceb37804d80c995faec3d7772c071b129fd47c2ba=
8a 8a/f1ad99a5e559f5835007f2bcb1b07de0e8c7434e7fbaa676a2edbd796a7f60
100644 blob b811e8da7c7acc83ef025753504ff6ed2d1eb8d2bb832d6b7487a7786d67aa=
53 93/f364fafaee6a178d8e8939f15d5b260f71940f663c3731396ee43082fd6551
100644 blob 0b1915ccb6f64cac64f2297893bce1ba7408660f79182302faaada71ee8c3c=
1c 96/b562b168f94e5c6e6a1e40ec4b817aa168c99769b1d9a46f7e048e93897fb4
=2D- snap --

This command was run in the worktree after running an unmodified t3305
with `GIT_TEST_DEFAULT_HASH=3Dsha256` in brian's `transition-stage-4` bran=
ch
(well, I removed the `SHA1` prereq again, that's the modification I made).

As you can see, there _is_ a fanout of 1, but there is only a single note
for a commit whose ID starts with `8`.

Debugging a little, it seems that the `PTR_TYPE_SUBTREE` node for `8` was
not collapsed, even if there was only one item left.

So I formed a hypothesis that the subtrees are only removed when the
_last_ item is removed for any given leading nybble, but that turned out
to also be incorrect. It is a bit more tricky than that. This is the
smallest set to which I was able to reduce the notes without reducing the
fanout to 0:

=2D- snip --
100644 blob cc2ee5e00d8bc3805d704b67439dc8175bcf9497603288e6de2d4d8b3fc7be=
9f	05/b6e3d1394d020129f71fd8e41cf7ea8cbc58ae0f1332abd5da0c74ea194b71
100644 blob 1c6afe76a1bcd0103c36ab9707a2ca9e68974b6a6bbaae564c0509c43b4392=
bd	1e/311d64dc3ad5491964bcded60fee15b19d5b9c916a7e62a4f0746fa4e81fa6
100644 blob cf97d105e3970ef1cf9b12ac092be80abcd496c593bc8ca5550d059c396763=
0a	28/79e092d524b7ae9a42026ab2886094cce8ffc63175f8b3fd5de84faef10df3
100644 blob 78ef788b804dd0e5415c386b4a29668f61033483c35438f0471dfd7c4bfa09=
3b	36/fe8fe67a2e9d0203c665d6e08ca454833ec32a97369769a7138d3938c0000b
100644 blob f46845c2d7e3272319aa5c18e359fdbc37731c88a945bb9632b8c4321983c7=
5a	4a/a271a09d848f99d3fb978e5c156baa812a0fa1c30a88c885831641630be01a
100644 blob ecf5a4a178ca4b51cea457abe7c935761ca15a1d817f83c2da6816ede84db7=
79	51/eaee3ca1a8698cb0aaa4de2d3f339985570da68b28e84af752e1cfd25f5197
100644 blob 2f4e9d6a4a1d050f8cb932ba545e53b48d9b669f6e00dc4a962d88ee9d9248=
2b	62/dd63d43070c3ca7e3a6cdfa4ed970256a00a06e88d10fcb0532acd51419e0f
100644 blob 22939636f79a53181ea58f04f2136bd745976edd0018465e60a8df89816a9c=
2b	72/67b1c94ab5ddf005fd4b0e50b6a7816a62e7ed0459cec6aa1a00577b2111ba
100644 blob fafb40e32e87a2c481df6ceb37804d80c995faec3d7772c071b129fd47c2ba=
8a	8a/f1ad99a5e559f5835007f2bcb1b07de0e8c7434e7fbaa676a2edbd796a7f60
100644 blob b811e8da7c7acc83ef025753504ff6ed2d1eb8d2bb832d6b7487a7786d67aa=
53	93/f364fafaee6a178d8e8939f15d5b260f71940f663c3731396ee43082fd6551
100644 blob 589656c26944c471b5ac65739f8c7b96663a9f827a3d27beb49e39e3707b72=
94	a2/0e8f30856061125d479779755ef3238a7b561f9336e0143c437daac7d93f4c
100644 blob 7eaa9350d5c6bd6fd0fc4071c5d6a266949046c67987a9e1f665ba34d95f41=
9d	a2/80d13a05aa68cc5ef948a8b69067807457fd37c00ce4a234fa4a0c0753ef4e
100644 blob 7a8378dd60d6024db645757eac7271a80b101a2df230ebd1a57ff52ff2d32e=
36	b9/2a3a7dc6db290d93f79150bfb31447f3e550cfe4a63c5ddbeac18fec755e86
100644 blob 86fff6007d9911249bee803a6630e182677355a5574e637d1a8301e219c5da=
86	c1/52ffd73d1c5e7c121c7c247682f1ee971f6f09101c96a84486d18be41d0dd0
100644 blob cd887698e1da81a76ae1caf0eaec19d60830a13ead152ec4700be511ceb8ee=
33	d0/3f742b8b95f68478946d7fe7495da9462801fadeaaa06c11bf54dbc46610f5
100644 blob 19f7bdfee9687311dbe1195e0a64954b677ae68e6d734fd5fb76ea4ad4f937=
82	ea/356ae2d38123b46639db98df14953f4c7cdd91738779174ec67876ce9487e3
100644 blob 948c0cba23ec0405c622c9dea8ed8dd7b3fa043c86b5e5a8b4de0d1c6a0e67=
b9	f7/802d4c716fed3c76fe58c86ac7c3ae3e19b8c0d3ea97c9f90f5939fe5a78d8
100644 blob 28690ad489e29e3607c82e1f626ec24d7f831555c802108bfe9b993fbd794a=
7e	f7/da03e811b7d9071ee19dabdc721e0f863e28c92dfa3257474282396a73bb44
=2D- snap --

You will note that there are two entries that start with `a2`, and two
entries that start with `f7`. If I remove any of those, the corresponding
subtree will be collapsed, and the fanout will be reduced to 0.

But it is only happenstance with SHA-256 that there are these entries that
agree not only in the first, but also in the second leading nybble.

Therefore...

> Hence we need an absolute minimum of 32 notes (and some rotten luck)
> to get a fanout of 1. As the number of notes increase, the probably of
> fanning out increases, passing 50% at ~79 notes, and reaching ~100%
> somewhere north of 150 notes.

... I would register that we need an absolute minimum of 16 notes (and
some rather crafty craft) to get a fanout of 1.

In that light, I think that I would prefer to retract my patch that
"only" reduces the remaining number of notes to 20: it should reduce them
to 15 or less. So why not reduce it to 10 (because it is only one changed
digit).

> > > The test happens to pass with SHA-1, but doesn't necessarily with ot=
her
> > > hash algorithms, so annotate it with the SHA1 prerequisite.
> >
> > I would rather see this tested, still, and reducing the number of note=
s
> > that are retained from 50 to 20 before testing that the fanout has bee=
n
> > reduced to 0 seems to do the trick. Therefore, I would love to submit =
this
> > for squashing:
>
> Yes, it seems that for SHA1 and the (deterministic) objects used in
> the test, we got away with 50 notes, but that is not the case for
> other hash algorithms. Lowering the number to 20 definitely results a
> fanout of 0, as should any other number below 32.
>
> +1 to Dscho's squash.
>
> ...Johan

Thank you so much for the analysis. To be honest, I did not quite
understand all the details of the comment added in 73f77b989f8 when I
wrote the patch I suggested, so I basically just picked that number "20"
out of thin air.

Together with your insights, I would like to propose this commit message
for the squashed commits (I left in the hunk that removes the `SHA1`
prerequisite, but of course that won't be part of the final commit):

=2D- snip --
t3305: make fanout test more robust (needed for SHA-256)

To make things more performant, notes are stored in a "fanout": when
there are enough commit notes, they are no longer stored as verbatim
commit IDs at the top-level tree of the notes ref, but instead the tree
is deepened much like the loose object cache: subtrees are introduced
whose names are the two hex digits they "chomp off" the commit IDs.

The test case 'deleting most notes triggers fanout consolidation' wants
to verify that the fanout level is reduced automatically when enough
notes have been deleted.

However, that test case expected that reduction to level 0 (i.e. _no_
fanout subtrees) to happen after reducing the originally-added 300 notes
to 50, which _happened_ to work with SHA-1-based commit IDs, but it is
no longer works with SHA-256-based ones.

The reason: The heuristic for the fanout looks at the number of entries
for leading nybbles (read: hex digits) of the commit IDs. If there are
more than a single annotated commit for all of the 16 hex digits, the
fanout is incremented. It is a bit more tricky when reducing the number
of notes: the fanout is reduced reliably only if there are less notes
than hex digits (i.e. less than 15 notes) for a given prefix.

For good measure, let's reduce the number of notes to 10 in the test
case 'deleting most notes with git-notes' so that the test case
'deleting most notes triggers fanout consolidation' is guaranteed to
succeed with _any_ hash algorithm.

Original-patch-by: brian m. carlson <sandals@crustytoothpaste.net>
Helped-by: Johan Herland <johan@herland.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
index 3520402bb81..b83c2670ebe 100755
=2D-- a/t/t3305-notes-fanout.sh
+++ b/t/t3305-notes-fanout.sh
@@ -43,7 +43,7 @@ test_expect_success 'many notes created with git-notes t=
riggers fanout' '
 '

 test_expect_success 'deleting most notes with git-notes' '
-	num_notes=3D250 &&
+	num_notes=3D290 &&
 	i=3D0 &&
 	git rev-list HEAD |
 	while test $i -lt $num_notes && read sha1
@@ -56,8 +56,8 @@ test_expect_success 'deleting most notes with git-notes'=
 '
 '

 test_expect_success 'most notes deleted correctly with git-notes' '
-	git log HEAD~250 | grep "^    " > output &&
-	i=3D50 &&
+	git log HEAD~290 | grep "^    " > output &&
+	i=3D10 &&
 	while test $i -gt 0
 	do
 		echo "    commit #$i" &&
@@ -67,7 +67,7 @@ test_expect_success 'most notes deleted correctly with g=
it-notes' '
 	test_cmp expect output
 '

-test_expect_success SHA1 'deleting most notes triggers fanout consolidati=
on' '
+test_expect_success 'deleting most notes triggers fanout consolidation' '
 	# Expect entire notes tree to have a fanout =3D=3D 0
 	git ls-tree -r --name-only refs/notes/commits |
 	while read path
=2D- snap --

brian, would you mind adopting this patch into your patch series? For your
convenience, I pushed it up as `t3305-sha256-fanout` (based on your
`transition-stage-4`) to https://github.com/dscho/git.

Thanks, Dscho
