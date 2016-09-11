Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6653C207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 08:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752682AbcIKIdq (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 04:33:46 -0400
Received: from mout.gmx.net ([212.227.17.21]:61039 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751629AbcIKIdo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 04:33:44 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LsgvV-1b3BBT1akz-012Gmz; Sun, 11 Sep 2016 10:33:38
 +0200
Date:   Sun, 11 Sep 2016 10:33:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Git garden shears, was Re: [PATCH 13/22] sequencer: remember the
 onelines when parsing the todo file
In-Reply-To: <5b707a0d-6c10-abb5-3213-d13490e9b9de@gmail.com>
Message-ID: <alpine.DEB.2.20.1609111027330.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <12bffd6ca4eb7acc00a102d13348bb96ad08371d.1472457609.git.johannes.schindelin@gmx.de> <52d61bef-668b-fdc4-30b3-a34c11b39f81@gmail.com> <xmqq8tvc21re.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1609011052260.129229@virtualbox> <xmqqeg53wj7a.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1609091708480.129229@virtualbox> <5b707a0d-6c10-abb5-3213-d13490e9b9de@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1319248791-1473582818=:129229"
X-Provags-ID: V03:K0:3fP+WmWwxhmOHZq94eOSaAm0BPgBUiJk1d0PjV7hjUVQo0EVyes
 bHZN8B1Mn0TmMYpLCWdjzOAVqx/Df55rAoGJSCF1byqT/WtBLSe0xbSdhpgnRG+s9LdUcnu
 Gyy0xkYnTwVGusQckHFW+VljetPxoVHmLNVMg4QU+VbfUrW2zL6skYc/iZJrne9DVkTwvON
 8EjPEXrQxyP8HhsZbkZfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Lri8REEAKE8=:Wn4XGhPWVVQ3WMYfDqAp1z
 a7emxopBNH/0uz74v4vxFV7BKqpe/WHFRepr5ZVhh62SNaxfoWJr85n9RP/8/e+THwaF2TQRa
 t9xbhQORtgX/XNx/S49nSrBQYj1LEZ0sBcCisL9+mbqpzjH8ymxPofr9KVifkiWSuU0F1CgNH
 b4WTDPy/GBhlBujcvrQSPiIlMzLkLBN9prvP5Uys8tKAq6yUL/o/ggdzb7A6earHmiVwEP9sB
 xPUEsRy090kO/kvWWDEdupAzrUmceq5NkvuZId1yZKnACXnXTmWNYhLlRFU/xgCnNOJsGDQSh
 h8aE465OSN1n/IYL54U4aKOsngov8kkT9lOY4kFaY5f2LEamyc9qy0ftePNRIC6K6gF9tppoY
 7zeTPJ634v1H0nxbgZhw8fAM4zFw0K2P+7aBURcA+H2bS5M+5v53q8Js0kV++3noS732yTgqv
 zj0AdugECzdTI94j2/Hvl6ASIhYOZVMrB+bLp5zhIfTru10a54DyLCvtQIGRAU0Bg4D4eK3Y2
 UcBNqXtQ+pCRGWe01j7vy6AFrUH5EQOjl37BA7zBuXfgCSKSy1Qh294mi2FBdN2xU9Js9/pT4
 /xQwh03LyXz4pMX32R2gNLPnhjl2rCPuYCkKZ0VElPCyvWmXvjuPSDitxTH05NL4zPH9L3Ogz
 Jmm+k3qgBYty3JEZmqAF6hvbp/+2te9/zgWMHFeJIeGuihMxhqhyyTQ02UPGPyPXOgu8t+t4e
 Q8y6O1Pl2nBOoh5rY34xDSuoJYppMp3lGTGueqwFHLKJVOhm0JI+GI/bYXCynOgNF8VzqR4kZ
 UEMF9Yj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1319248791-1473582818=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Fri, 9 Sep 2016, Jakub Nar=C4=99bski wrote:

> Hello Johannes,
>=20
> W dniu 09.09.2016 o 17:12, Johannes Schindelin napisa=C5=82:
> > On Thu, 1 Sep 2016, Junio C Hamano wrote:=20
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> >> I was sort of expecting that, when you do the preserve-merges mode
> >> of "rebase -i", you would need to jump around, doing "we have
> >> reconstructed the side branch on a new 'onto', let's give the result
> >> this temporary name ':1', and then switch to the trunk (which would
> >> call for 'reset <commit>' instruction) and merge that thing (which
> >> would be 'merge :1' or perhaps called 'pick :1')", and at that point
> >> you no longer validate the object references upfront.
> >=20
> > Except that is not how --preserve-merges works: it *still* uses the SHA=
-1s
> > as identifiers, even when the SHA-1 may have changed in the meantime.
> >=20
> > That is part of why it was a bad design.
>=20
> When preserving merges, there are (as far as I understand it), two
> problems:
>  - what it means to preserve changes (which change to pick,
>    that is what is the mainline changes rebase is re-applying)
>  - what are parents of the merge commit (at least one parent
>    would be usually rewritten)
>=20
> Maybe the internal (and perhaps also user-visible) representation
> of merge in instruction sheet could use the notation of filter-branch,
> that is 'map(<sha-1>)'... it could also imply the mainline.
>=20
> That is the instruction in the internal instruction sheet could
> look like this:
>=20
>   merge -m 1 map(2fd4e1c67a2d28fced849ee1bb76e7391b93eb12) da39a3ee5e6b4b=
0d3255bfef95601890afd80709 \t Merge 'foo' into master =20
>=20
>=20
> Note that it has nothing to do with this series!

Right. But I did solve that already. In the Git garden shears [*1*]
(essentially my New And Improved attempt at recreating branch structures
while rebasing), I generate and process scripts like this:

=09mark onto

=09# Branch: super-cool-feature
=09rewind onto
=09pick 00001 feature
=09pick 00002 documentation
=09mark super-cool-feature

=09# Branch: typo-fix
=09rewind onto
=09pick 0000a fix a tyop

=09rewind onto
=09merge -C cafebabe super-cool-feature
=09merge -C babecafe typo-fix

=09cleanup super-cool-feature typo-fix

Of course this will change a little, still, once I get around to implement
this on top of the rebase--helper.

For example, I am not so hot about the "merge -C ..." syntax. I'll
probably split that into a "remerge <SHA-1> <mark>" and a new "merge
<mark>" command (the latter asking interactively for the merge commit
message).

And also: the cleanup stage should not be necessary, as the "mark"
commands can accumulate the known marks into a file in the state
directory.

But you get the idea.

No :1 or some such. That's machine readable. But it's utter nonsense for
user-facing UIs.

Ciao,
Dscho

Footnote *1*:
https://github.com/git-for-windows/build-extra/blob/master/shears.sh
--8323329-1319248791-1473582818=:129229--
