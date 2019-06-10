Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8EB21F462
	for <e@80x24.org>; Mon, 10 Jun 2019 18:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387836AbfFJS3p (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 14:29:45 -0400
Received: from mout.gmx.net ([212.227.15.19]:38327 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfFJS3p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 14:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560191382;
        bh=RVPr9Uu3q7Z8G/IGzz70fBzH7ArbBh6xiqUYjGWlxUk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=G8fkvIetRs6F3usESzStyNHw+V47W9HD2KqtFIM6yKF/achmTBTYp7hzwtzqWj06I
         NYaxOkiX52CbjLKpM5VOeJGZ/4/uvwgXECeEcddDFCicdj92TOqcNTrzLWKZmZxR3K
         fRC9wpZxIyn6wekV5Dyps7C1cv6s1MBad6vgTqaw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.215.76.8] ([46.142.197.184]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ln8Tl-1gtfhr2hKf-00hKnO; Mon, 10
 Jun 2019 20:29:42 +0200
Date:   Mon, 10 Jun 2019 20:29:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@DESKTOP-QUA364F.localdomain
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] t7610-mergetool: do not place pipelines headed by
 `yes` in subshells
In-Reply-To: <20190610095942.GA19035@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1906102026030.789@QRFXGBC-DHN364S.ybpnyqbznva>
References: <cover.1560152205.git.j6t@kdbg.org> <75c812bd4838f6f35b6f42b97ae396ebb28d8b95.1560152205.git.j6t@kdbg.org> <20190610095942.GA19035@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1034172982-1560191397=:789"
X-Provags-ID: V03:K1:jJ+JT60/F5/pMZKpMWQKeYr2oLy0YuzjOHBOhQmviC66zKmpcju
 gxmXFDi7Z4ZjWvIEC+VxFxvFPaJ8wWMW4O/HK+IeKs3UIBt1Rmo1MjS7LPj0rccq5czxJsy
 BFBZwmhi32aMLQapXuqNQ8B/XylnFdFbGrMJun5guy+rMb7eOUcyQ9VjaasHpiL5vX3tzly
 4Ss7bwrQBTckPJk7unt8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZmM+HL1PwSQ=:o9cNjTzzBN+nrq0a2QeWca
 b0TEyak16677UZzVxFuuS9Akc35E7mm1STQ6KgRaI2QeE66kZL1ZPmk9bbjJ2tkW0w6VO8qbI
 0zO4wqqh4zrhoIJ0eu/JOOJ6PpTZ1n2Tx8pUdQOg6+YyN9iZHKn/HXOwpceTyRjz9bxXhSFvQ
 AaUQ5XA01QMQmjjy+TODw4rn7X7Ri1Uz19nfFCRU3JvWzsDoTv1KXegCpKU5KcqDnVmTLzk5/
 0X0kQmZFDXPwztSnx6I6TlIUs6yCTeuOFa8CP2OzgN3HXoTx7mM60W/bLbiNX9+E4zo5QtN5H
 T6btIK7j6g8NmJ6P+2KVBH4DdsEHATH43dnv5s4mol+kwhNIiVdkcA/DjrMCxX0j/VJgV+it1
 JDE5ZeUuSSqShZ+xSOMw3Y623LwbSmJHbevht0s3ZQ+nOuyINaE9Efe7Eg2sd5sRQT6CgBZ4r
 7CWEPvCyZQdEaeJ3mTLYc4Y0ZE7bn52y8EPqCHICyWk9YVV9otxh7Zy1AndMgoIyeY0Nq64sJ
 33anCgn9aOOuBTFf7kLSCy2ma5nkjcHYq36J+xvaZpo+abEpdWOCkR66uhgXT3/23rovHNdDT
 zOsCLyVw84rmx75m/HuKR58KfIxZrqhts3DyiyjGcH4EI7ygW+zE/BO5GpGK/h8lfXLcg9xL9
 Kw5wfQ3mqe0TSx3cB0W6LH2apYiyVESHgkpCNoEL9puaG+HkHOCGiCzlsO/omxAfC5TvNxN1Z
 0K+OmHNDyLGiyy9AUrFbhSLLxOwg8+hTqK2ggbaKKy1EGHG4s611Vvm/J626kks4mf9oV9fYZ
 bHvng7zfCSMvwkjtsjT1i/omkykoMIisSUNK7I64PSIkpj9f+53/ZCVCpEhG4+o9mi3IgZPAO
 nFqy0gtdGJ/s4a6fPrslyyAzlafzBrQAUKi8nUFh61yxxdUVHpy4U7MckLuqLhV+kk87Y8g8a
 b5RdYggKLuDBa2hdM3baaq6EckOS9UPMuOqQdVNx45wWQwIthkFti
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1034172982-1560191397=:789
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 10 Jun 2019, SZEDER G=C3=A1bor wrote:

> > diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
> > index 5b61c10a9c..b67440882b 100755
> > --- a/t/t7610-mergetool.sh
> > +++ b/t/t7610-mergetool.sh
> > @@ -131,13 +131,13 @@ test_expect_success 'custom mergetool' '
> >  	git checkout -b test$test_count branch1 &&
> >  	git submodule update -N &&
> >  	test_must_fail git merge master &&
> > -	( yes "" | git mergetool both ) &&
> > -	( yes "" | git mergetool file1 file1 ) &&
> > -	( yes "" | git mergetool file2 "spaced name" ) &&
> > -	( yes "" | git mergetool subdir/file3 ) &&
> > -	( yes "d" | git mergetool file11 ) &&
> > -	( yes "d" | git mergetool file12 ) &&
> > -	( yes "l" | git mergetool submod ) &&
> > +	yes "" | git mergetool both &&
> > +	yes "" | git mergetool file1 file1 &&
> > +	yes "" | git mergetool file2 "spaced name" &&
> > +	yes "" | git mergetool subdir/file3 &&
> > +	yes "d" | git mergetool file11 &&
> > +	yes "d" | git mergetool file12 &&
> > +	yes "l" | git mergetool submod &&
> >  	test "$(cat file1)" =3D "master updated" &&
> >  	test "$(cat file2)" =3D "master new" &&
> >  	test "$(cat subdir/file3)" =3D "master new sub" &&
>
> Another possibility for eliminating a few more subshells might be to
> turn these
>
>   test "$(cat file1)" =3D "that"'
>
> checks into
>
>   echo that >expect &&
>   test_cmp expect file1
>
> because 'test_cmp' on Windows first compares the two files in shell
> and runs 'diff' only when there is a difference to report.

When you remember that spawning processes is much more expensive on
Windows, still, than I/O, you will realize that this adds even more
expense. Instead of a spawn & read, you are suggesting essentially a
write, spawn, read & read, and that is only the best case.

In the worst case, it would be a write, spawn, read & read, spawn, read &
read.

(Even if the first spawn is an MSYS2 spawn on Windows, which is more
expensive than the MINGW spawn for the `git diff`, if that is a `git diff`
rather than `diff`, didn't check...)

So I am rather negative about this suggestion ;-)

Ciao,
Dscho

--8323329-1034172982-1560191397=:789--
