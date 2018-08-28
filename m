Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E9241F404
	for <e@80x24.org>; Tue, 28 Aug 2018 13:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeH1RZL (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 13:25:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:47033 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbeH1RZK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 13:25:10 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjJCt-1fMwfL18d5-00dXCA; Tue, 28
 Aug 2018 15:33:24 +0200
Date:   Tue, 28 Aug 2018 15:33:24 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Nikolay Kasyanov <corrmage@gmail.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: A rebase regression in Git 2.18.0
In-Reply-To: <87in3ueiks.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808281532220.16620@tvgsbejvaqbjf.bet>
References: <679370A8-E477-450D-96E5-6B1869D27576@gmail.com> <87in3ueiks.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-260913486-1535463205=:16620"
X-Provags-ID: V03:K1:e0vayqeExKDcvA/JqYv5s95+KJIQDO+qH04+oNfahMmZLVD7/fl
 TQ00Ht6pCD0HqrUIFyTaOCO2zvgkrTaR0rAt5yiwdlZtp4D7JHo84mE95aoqwigJnOTTyev
 9+ThXaT7jBGL4N4iXjQsobEWukRVxKtoOx9fywrQ8QBLqUXF6uy87TOC3oZu3ZQ9pyrsUJE
 ZE0uK/Gxvyz19RO/oRHSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zAGvibe8YyA=:V7Soq/89O9jp05TS2HPm8s
 waIcQ+0McqUlt7q7oqnuarkOpY81hdPHAQU31VBQJP2V4LNT6ncfz8nbD1GaS/gyldnruYOaJ
 sGHKKgpYHiFTxBaJPFH7bVK3Y8xlq5aSS3DMtnLXTLYJrwLHIUjhKW5qhX3VQsL79xDfe5erM
 TwZ4NSdeGOSAGxeY6+8n1eTuK0LfiEo4z6i+gJ8cU7x3iKDTGkYtI1GR9oUurgUenk9vISXMO
 w57buHZ01cI8CMj2HYm/lzR1MiGyPv8jvW5tRu9mz7Xe4kIV/iYdjvkre1+c2ROIE+0gSYo87
 PoYldlX7VtO2PSfRHcj7+fhqAUrKs4yLtzA7/XhdoNqAZeL/rtpM3tIzZ5KqCC+qU0nhprsrP
 J42AvgJjxh4xvQ1A5oKntTsThJG4zQN42cj7nDMy4H/o5Su5nHBiLplAaQFBwnUty0x/OSH3G
 0vyH9ysUpa60SGVam2HZA3GLtfnQogWTJU5p8Efz0uEwo4O/MmEXK64OwxCruIm6cUxdoWICZ
 ZhKj7Ky1gV/+kmC18dbQVfkhOmHPEGfd32qtrSV7XDZ4aCVHWYbhq098Yv/PIaA/Dpz76ndaG
 HDEYfCKfHN8HcMShmWDULwQPm9FyO0jyq0FV+cpkefNx3vV46WWlt5es8Ad2j7qoJXZoBYT2s
 PEzw72fuN1QFrsKngJaVfnixylKU6/UVwJy6FbON+1uddaexwDlJiDjVRqy++U2N5ME9FEdQy
 xrLIyl6DoKqyhz/AScITc5EQxADKEKNEFO6lqUECcUjPej/cbFq6uUa3gvm5GzZq+mppiM5tg
 qyB9WXh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-260913486-1535463205=:16620
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Tue, 28 Aug 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, Aug 28 2018, Nikolay Kasyanov wrote:
>=20
> > I=E2=80=99ve found something that may be a regression in git rebase imp=
lementation in 2.18.0.
> > First I spotted it on macOS but I can also confirm it happening on Linu=
x.
> > Git 2.19.0.rc0.48.gb9dfa238d is affected too.
> >
> > In order to trigger it, a repo layout similar to the following is requi=
red:
> >
> > files/
> > =09file1
> > =09file2
> > =09file3
> > =09file4
> > =09file5
> > project
> >
> > Let=E2=80=99s call this state baseline. Then, in a branch, let=E2=80=99=
s edit project file and move file3 to nested/files subdirectory, here=E2=80=
=99s the final layout:
> >
> > files/
> > =09file1
> > =09file2
> > =09file4
> > =09file5
> > nested/
> > =09files/
> > =09=09file3
> > project
> >
> > Let=E2=80=99s get back to master and also edit project file to cause a =
conflict. After that trying to rebase the branch upon master will cause the=
 following git status output:
> >
> > rebase in progress; onto baf8d2a
> > You are currently rebasing branch 'branch' on 'baf8d2a'.
> >   (fix conflicts and then run "git rebase --continue")
> >   (use "git rebase --skip" to skip this patch)
> >   (use "git rebase --abort" to check out the original branch)
> >
> > Changes to be committed:
> >   (use "git reset HEAD <file>..." to unstage)
> >
> > =09renamed:    files/file1 -> nested/files/file1
> > =09renamed:    files/file2 -> nested/files/file2
> > =09renamed:    files/file3 -> nested/files/file3
> > =09renamed:    files/file4 -> nested/files/file4
> > =09renamed:    files/file5 -> nested/files/file5
> >
> > Unmerged paths:
> >   (use "git reset HEAD <file>..." to unstage)
> >   (use "git add <file>..." to mark resolution)
> >
> > =09both modified:   project
> >
> > All renames except file3 are invalid and shouldn=E2=80=99t be here.
> > Here=E2=80=99s how the output looks like produced by an older Git versi=
on (git version 2.15.1):
> >
> > rebase in progress; onto baf8d2a
> > You are currently rebasing branch 'branch' on 'baf8d2a'.
> >   (fix conflicts and then run "git rebase --continue")
> >   (use "git rebase --skip" to skip this patch)
> >   (use "git rebase --abort" to check out the original branch)
> >
> > Changes to be committed:
> >   (use "git reset HEAD <file>..." to unstage)
> >
> > =09renamed:    files/file3 -> nested/files/file3
> >
> > Unmerged paths:
> >   (use "git reset HEAD <file>..." to unstage)
> >   (use "git add <file>..." to mark resolution)
> >
> > =09both modified:   project
> >
> > Here=E2=80=99s a ready-to-use repository: https://github.com/nikolaykas=
yanov/git-rebase-bug.
>=20
> Thanks for the test case. This bisects down to 9c0743fe1e
> ("merge-recursive: apply necessary modifications for directory renames",
> 2018-04-19) first released as part of 2.18.0.
>=20
> I have not dug to see if the behavior change is desired or not, that
> commit changed the results of a bunch of test cases, maybe it was
> intended. Elijah?

I think this was already mentioned before, in a different mail thread:
have you tried whether `git rebase -m` fixes that behavior?

Ciao,
Johannes
--8323328-260913486-1535463205=:16620--
