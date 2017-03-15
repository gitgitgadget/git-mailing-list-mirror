Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 506E420323
	for <e@80x24.org>; Wed, 15 Mar 2017 09:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752730AbdCOJod (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 05:44:33 -0400
Received: from smtpo.poczta.interia.pl ([217.74.65.205]:41949 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752669AbdCOJoc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 05:44:32 -0400
Date:   Wed, 15 Mar 2017 10:44:24 +0100
From:   Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>
Subject: Re: fatal: Could not get current working directory: Permission
 denied | affected 2.10,2.11,2.12, but not 1.9.5 |
To:     =?iso-8859-1?b?UmVu6Q==?= Scharfe <l.s.r@web.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
X-Mailer: interia.pl/pf09
In-Reply-To: <f2ab799f-5f0a-0ce0-0625-13513bc1973d@web.de>
References: <elvahoiwfqayelbskykd@qjih>
        <7d947891-ce40-23e7-2bc7-0f76dee53665@web.de> <hpulcgxossrwvfbbcvcl@zndn>
        <10cc42b8-0f63-2d97-8da1-2943970d63cc@web.de> <ogwsaxvtiqlsiwojzxul@owpk>
        <3ba0c8e3-894a-846f-ba99-dad1deba7cdf@web.de> <tskgutqgpyszzedvyfra@prol>
        <f2ab799f-5f0a-0ce0-0625-13513bc1973d@web.de>
X-Originating-IP: 89.64.255.37
Message-Id: <ffntuqzgjgcfhebokbty@eduj>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1489571064;
        bh=ubRWNjDNYJdJBxBmyjIp/tAcBt404mghiLAvyvTH6cM=;
        h=Date:From:Subject:To:Cc:X-Mailer:In-Reply-To:References:
         X-Originating-IP:Message-Id:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=XNEwu3s0VlovqaLhrZVgWz5RKtlmEL+88mImQ9qAYUmdf6YmaLrF6+OCWJUnLKf8H
         45RpKs5KYp8OVFQTlgUelOouLb4hK0bl3CgCZoMF4wMhnRZzia5kpnsezcZ1W/PQ+g
         fu3Zhf9xlbXDNA8Y8WE8LU94m+CrKdchwsbKQBYA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Od: "Ren=C3=A9 Scharfe" &lt;l.s.r@web.de>
Do: "Zenobiusz Kunegunda" &lt;zenobiusz.kunegunda@interia.pl>;=20
Wys=C5=82ane: 18:59 Wtorek 2017-03-14
Temat: Re: fatal: Could not get current working directory: Permission denie=
d | affected 2.10,2.11,2.12, but not 1.9.5 |

>=20
>> Am 14.03.2017 um 08:44 schrieb Zenobiusz Kunegunda:
>> Od: "Ren=C3=A9 Scharfe" &lt;l.s.r@web.de> Do: "Zenobiusz Kunegunda"
>> &lt;zenobiusz.kunegunda@interia.pl>; Wys=C5=82ane: 22:31 Poniedzia=C5=82=
ek
>> 2017-03-13 Temat: Re: fatal: Could not get current working directory:
>> Permission denied | affected 2.10,2.11,2.12, but not 1.9.5 |
>>
>>>
>>>> Am 13.03.2017 um 14:23 schrieb Zenobiusz Kunegunda: Bisecting: 0
>>>> revisions left to test after this (roughly 0 steps)
>>>> [a26bc613a64ac2c7ee69a50675e61b004a26382d] pretty.c: make
>>>> git_pretty_formats_config return -1 on git_config_string failure
>>>>
>>>> This is what I found with git bisect
>>>
>>> Strange, I don't think git_pretty_formats_config() is even called
>>> by git status.
>>>
>>> Ren=C3=A9
>>>
>>>
>>
>>
>> a26bc613a64ac2c7ee69a50675e61b004a26382d - is actually working
>> revision
>>
>> The question is - is git history linear enough for git bisect to
>> produce any useful result? Gitk produces rather complicated diagram.
>> Especially for year 2014. I'm not sure about reliability of this
>> method. Or maybe it should be used in a specific way I'm not aware
>> of. If you have any advices how to use it in this specific case,
>> please let me know.
>=20
> Ah, right, I didn't pay enough attention, sorry.  Step 0 is the last=20
> one, but you need to rate it as good or bad before reset presents the=20
> result.  History is not really linear in git's own repository.  But if=20
> you didn't reset bisect's status you may still be able to finish it by=20
> running "git bisect good a26bc613" now.
>=20
> (And if that doesn't work then at least you now have a much quicker way=20
> to check using the long directory name..)
>=20
> Ren=C3=A9
>=20
>=20

Oh, my bad. Haven't been using git bisect for quiet a while and forgot to r=
ate.
Ok, so I did bisect again

$ git bisect bad
7333ed1788b4f2b162a35003044d77a716732a1f is the first bad commit
commit 7333ed1788b4f2b162a35003044d77a716732a1f
Author: Ren=C3=A9 Scharfe <l.s.r@web.de>
Date:   Mon Jul 28 20:26:40 2014 +0200

    setup: convert setup_git_directory_gently_1 et al. to strbuf
   =20
    Convert setup_git_directory_gently_1() and its helper functions
    setup_explicit_git_dir(), setup_discovered_git_dir() and
    setup_bare_git_dir() to use a struct strbuf to hold the current working
    directory.  Replacing the PATH_MAX-sized buffer used before removes a
    path length limition on some file systems.  The functions are converted
    all in one go because they all read and write the variable cwd.
   =20
    Signed-off-by: Rene Scharfe <l.s.r@web.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

:100644 100644 0a22f8bd1d631fe5f0afe1d84162ca4064a00e4f 937dad503c28681d7c2=
1f5dc300ea943cfe5b17a M	setup.c

$ git bisect log
git bisect start
# bad: [b260d265e189728b26e50506ac6ffab6a7d588da] Git 2.2
git bisect bad b260d265e189728b26e50506ac6ffab6a7d588da
# good: [83332636f575f00edff8f3afb15a2f96885bf417] Git 1.9.5
git bisect good 83332636f575f00edff8f3afb15a2f96885bf417
# good: [9181365b856a63f8c5486ad0fe48f1cd60852da3] Merge branch 'maint-1.8.=
5' into maint-1.9
git bisect good 9181365b856a63f8c5486ad0fe48f1cd60852da3
# good: [9181365b856a63f8c5486ad0fe48f1cd60852da3] Merge branch 'maint-1.8.=
5' into maint-1.9
git bisect good 9181365b856a63f8c5486ad0fe48f1cd60852da3
# good: [ba655d15b58ab2a00032b74e5b2617a0b658a01f] Merge branch 'sk/mingw-m=
ain'
git bisect good ba655d15b58ab2a00032b74e5b2617a0b658a01f
# bad: [88e7dff93d7010bb2974f8e1599a4e53c73e18f3] Merge branch 'jk/prune-to=
p-level-refs-after-packing'
git bisect bad 88e7dff93d7010bb2974f8e1599a4e53c73e18f3
# good: [8a7b034d6d451491dbcfaebc3d4ed4f08c756822] add tests for `git_confi=
g_get_string_const()`
git bisect good 8a7b034d6d451491dbcfaebc3d4ed4f08c756822
# bad: [f655651e09b9fa7bf8ff13f1b4a5b16c7956e4cf] Merge branch 'rs/strbuf-g=
etcwd'
git bisect bad f655651e09b9fa7bf8ff13f1b4a5b16c7956e4cf
# good: [aa544bfbc6eb11e4f0471f3144d3e3ac75c0e4a9] Sync with 2.0.4
git bisect good aa544bfbc6eb11e4f0471f3144d3e3ac75c0e4a9
# good: [212d781c967317a05a704609ddf3ffc8a09f8590] Merge branch 'jk/fix-pro=
file-feedback-build'
git bisect good 212d781c967317a05a704609ddf3ffc8a09f8590
# good: [44ceb79f84b0f339147d2d44e4bb50cc472be03e] Merge branch 'jk/pretty-=
empty-format'
git bisect good 44ceb79f84b0f339147d2d44e4bb50cc472be03e
# bad: [4d3ab44d26c47d100cec39d0ef9ed9746eb7e454] use xgetcwd() to set $GIT=
_DIR
git bisect bad 4d3ab44d26c47d100cec39d0ef9ed9746eb7e454
# bad: [251277acdf8c8dee59bdd0e9e7b7e3502226cf9d] abspath: use strbuf_getcw=
d() to remember original working directory
git bisect bad 251277acdf8c8dee59bdd0e9e7b7e3502226cf9d
# good: [d13a0a97e097c6a601bafc529a716477cc94dc20] unix-sockets: use strbuf=
_getcwd()
git bisect good d13a0a97e097c6a601bafc529a716477cc94dc20
# bad: [7333ed1788b4f2b162a35003044d77a716732a1f] setup: convert setup_git_=
directory_gently_1 et al. to strbuf
git bisect bad 7333ed1788b4f2b162a35003044d77a716732a1f
# first bad commit: [7333ed1788b4f2b162a35003044d77a716732a1f] setup: conve=
rt setup_git_directory_gently_1 et al. to strbuf
=
