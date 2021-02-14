Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7D2C433E0
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 10:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0925A64E52
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 10:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhBNKGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 05:06:20 -0500
Received: from mout.web.de ([212.227.15.4]:34841 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhBNKGT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 05:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1613297066;
        bh=yyX5FAj8z3e9IEl5cQI5eLbn5SalcKLwzzb1zzZLiJo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=IJuN36oPgdrkBwlwQmim1FH13Lactz5SjQ9IYT4kpxUBBw/dzv0OyjDI977RYdd+D
         Yd7a0JWkWsL451pMIeH7Dsy3wVA19zDRJCBosx6i9jYzrUKyWeyZBIeBggQ9V8jNr2
         dt57U1sEIsLchH5EQ/cb9OH6K9LJYOzYOtl7o76Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.159.90]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0M5Jip-1m5vr43pbr-00zYqI; Sun, 14 Feb 2021 11:04:25 +0100
Subject: Re: gitattributes export-subst and software versioning
To:     Eli Schwartz <eschwartz@archlinux.org>, git@vger.kernel.org
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
 <ac1288b8-5cdf-8e1e-702a-815c5fbc2da3@web.de>
 <4f65f02c-1d16-aa2c-3e7b-28d807b9ebe9@archlinux.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Issac Trotts <issactrotts@google.com>
Message-ID: <407c4820-e126-b9a2-e698-6cdabbfc63b8@web.de>
Date:   Sun, 14 Feb 2021 11:04:25 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <4f65f02c-1d16-aa2c-3e7b-28d807b9ebe9@archlinux.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VweQhvEDpYBblxYAa/AulbmCMkttt6SKkmI0r4y2DCf3ibc0ytI
 VZ4hyrORe3qBb+bdFLGbrTYscitN92cyoOkumoYqpJ54ZeRMlFd2jCifwZVy4z1YE4WtZ77
 drBEZw0BYMghjd5eIb9nQg8V+orRDLfdJFDQbn77Gwk72DG+IkszgJYzICMUlpX6vprs8Z3
 jISodEaceJxak+lmbkS8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cYRq9KMM5TM=:k4KJiZk/2RR6vGTgQ+55xJ
 eG4Oy04nf9svSmjscp0yQc6RRCFQiaePysr6fRRYqnQa25ktvV/+SFIbi460f8h8BsH93hHDI
 WtF7H7tzHUA+rzWWB2Gi1hneMnPeFUwkQg/O2XC8m4EdNGUOUKLC5hJG4FKu9BqGirXOUivoo
 1V6FaBZleRylJkS91fqxBtDJZ6HGjf0x3Ar/NaaSMalFev1kd7MjkYb7eCoFF0wMunqHfPseK
 ErNPjsLWjKYI4phXSDWew2M+JeKSxrD68I6zHbw1dMMz+CoxWQIQPbWOs46IklCxm4z3zjRoE
 qtj4FM2PfsNvlU0G2R045dTJcTVKxBOiMes1ICTlNNvLMp4tyVngzM3AWL2lsPhuPx4i0u+23
 XbrJPC1/GW4Q3L/wyx8LeK+a1RI7LBoib3LNiIIS7Q246xLUSuqlWNJmq8JdCrU8GBAW9Imwo
 NSW+7RGsW971RGo6ltQDIlvi48roCH9zwouuDvhjvpap3u0MnIXNTKB3Pu9kBLAe2MZ00SQGa
 moG+DKjdWnZPfaYLnNhD4mJrjDTse1JWuqZWHB0vx7PKi3mdgWpf3YeqFkDlR44nwTJqR8ajW
 0yrHHgmF3K+hglYZJjhAQoHnGtjNKPMarCoaXk9uRnIEi8ErkdxOrKgDme+HyIsacIAXaJumq
 bK6T03HrN6qwEwv8pMY4DrFLSjZZrHNrF3meU2x5Wu0cqV3F0iSqoYn1j+4M5r2FOzjYVvSWO
 ieQjGeAlBrsvBDfPq/08XNUiRv0SB3usWpmgSI+I84t6/BwTGdObXxVkNrYQg1PZdgcY7YTG2
 2GzBreQ9G4YySlC2MdhBeYfOlhjLs3OOr05Kn1h3DQnhEy9592f3X8cxGnYBpDTOOx2DKHoQt
 RhokezqTP6T21WGhnobg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.02.21 um 01:19 schrieb Eli Schwartz:
> On the other hand, with my zero knowledge of the code but having read
> lots of man pages... %S documents that it "only works with git log", so
> maybe it is possible to add an option that is documented to only work
> for git archive?
>
> e.g. if you do use it,
>
> $ cat VERSION
> $Format:%d$
> $Format:%S$
>
> $ git archive HEAD | bsdtar -xOf - VERSION
>  (HEAD -> master, tag: 1.0)
> %S
>
> It's apparently completely ignored and treated as raw characters. The
> same restriction could theoretically be added in the other direction for
> a new placeholder.

That's a curious case.  Supporting %S in git archive would be easy  --
it's just a matter of recording the name given at the command line for
the pretty format code to find, like in the sloppy patch below (missing
doc update, missing test, leaks memory, adds a static variable to
library code).

The inconsistent support of %S is not ideal and I think that set a bad
precedent, but on the other hand I don't see its usefulness for git
archive in particular.  So I dunno.  Perhaps worth doing once rev-list
gains support, for completeness.

Ren=C3=A9

=2D--
 archive.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/archive.c b/archive.c
index 5919d9e505..ffe4c35961 100644
=2D-- a/archive.c
+++ b/archive.c
@@ -9,6 +9,7 @@
 #include "parse-options.h"
 #include "unpack-trees.h"
 #include "dir.h"
+#include "revision.h"

 static char const * const archive_usage[] =3D {
 	N_("git archive [<options>] <tree-ish> [<path>...]"),
@@ -23,6 +24,8 @@ static int nr_archivers;
 static int alloc_archivers;
 static int remote_allow_unreachable;

+static struct revision_sources revision_sources;
+
 void register_archiver(struct archiver *ar)
 {
 	ALLOC_GROW(archivers, nr_archivers + 1, alloc_archivers);
@@ -41,7 +44,8 @@ static void format_subst(const struct commit *commit,
 {
 	char *to_free =3D NULL;
 	struct strbuf fmt =3D STRBUF_INIT;
-	struct pretty_print_context ctx =3D {0};
+	struct rev_info rev =3D { .sources =3D &revision_sources };
+	struct pretty_print_context ctx =3D { .rev =3D &rev };
 	ctx.date_mode.type =3D DATE_NORMAL;
 	ctx.abbrev =3D DEFAULT_ABBREV;

@@ -461,6 +465,8 @@ static void parse_treeish_arg(const char **argv,

 	commit =3D lookup_commit_reference_gently(ar_args->repo, &oid, 1);
 	if (commit) {
+		init_revision_sources(&revision_sources);
+		*revision_sources_at(&revision_sources, commit) =3D xstrdup(name);
 		commit_oid =3D &commit->object.oid;
 		archive_time =3D commit->date;
 	} else {
=2D-
2.30.1
