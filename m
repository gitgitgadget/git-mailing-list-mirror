Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 732351F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 13:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755190AbcIANVh (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 09:21:37 -0400
Received: from mout.gmx.net ([212.227.15.15]:64346 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755111AbcIANVg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 09:21:36 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MTBsk-1bYL6L0BoU-00S4T3; Thu, 01 Sep 2016 15:14:03
 +0200
Date:   Thu, 1 Sep 2016 15:14:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 13/22] sequencer: remember the onelines when parsing the
 todo file
In-Reply-To: <xmqqzinszpww.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609011512200.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <12bffd6ca4eb7acc00a102d13348bb96ad08371d.1472457609.git.johannes.schindelin@gmx.de> <52d61bef-668b-fdc4-30b3-a34c11b39f81@gmail.com> <xmqq8tvc21re.fsf@gitster.mtv.corp.google.com>
 <a9831d93-f5b4-d729-eae0-1f7c1123a6a6@gmail.com> <xmqqzinszpww.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-110939644-1472735643=:129229"
X-Provags-ID: V03:K0:tbzc3joEMB89ueFMyFb3MWyHY7EKDDQ335homsqc+wd5QE2a+G5
 +bC/rDHHGH9YizFSWW2T3aHsiC40jkcloos7H7lBaQ5Bd0abz6xF3D4dTaW1iMv9XwLDfjP
 xNGhVslfeN5l1k1RUSXT9tKMINfpWyZYKHiPT/9Ju+XKdUNcdrsrJMcO4bFUm5NI+Gibivy
 1t7wGQJ22ds8nIHsqTpNA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1IaEssN0gIo=:EWrQnl1ui+kwbIKCEdxVlt
 Kb6roOuAgEipkvF04Ql+Z86ZmSL7y2eUXjViNhG+wvWKblzrwfqsKBS9P+ipvoyetWq5WQJ2W
 +xsxl+k2tu6QTagI4CA5kWc0awRf9xo14PhWR26ZOGZvE/9fxOC7RWULjwnovFKvun6zJ5U8K
 Oy6rqAp8hbHPIdiC8oAQtrDcUTyUE8lRQ36/g+JIyNXxrJz1ASUB42ltLZiQpnkk149+IeK0J
 wx8yTUmaZXRntnkwYwNaR8aZaxkKMV23r6t4j9YwFEqnMcUYgpUSoUAscEkhNnFG+ad7/OgaU
 URd4d4MiuoEPnCX6bEjOjOp+iwn5qPTXRIAhwKLuAvXjBX1megsYOwObQ8STGfLHDfHPwIbjP
 cW//nOyqepsfnIitnYSEXLJxQTpepSsegyrTSOk5cx3n/d+A/EgzPfhc+4Cb9MtDVf7swTNod
 GCT0r+aRn5OVJ0JrmrfV1xPa9V3ynII8PAGsWCMjRHHkNe0p+Q2v+5Krq8Z3mELN8Mt3gLIK8
 GKZx3XVvmks/cPM+3sW3sA54p9IZ4dM0Ln/j2P6gzZ8gwmERj7bxV+RPIEiaN2bOHCG3kOUQH
 hmoXEZhMuwID1K5ukwmqdIdMKXL+Xz8QFM4DK0dm0qYAt1RUzsiDMmIDBgWQ9I0nfnxBTIvgU
 hXwAja+9L4IkuQvEdBT4PNoKsUCVZnAMIt1Ofwcd+ze/rok6rqDGk2o94+uX3U4Qp9I7eSX4B
 Us6cL3fL2T2MPW4Ng/fsoqGCfgDX7TV1gmDaboqIcTeB9Ke20Fll04CSH779ZeUigUJw2EVek
 M9Y+6Bp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-110939644-1472735643=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Wed, 31 Aug 2016, Junio C Hamano wrote:

> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>=20
> >>>> @@ -709,6 +709,8 @@ static int read_and_refresh_cache(struct replay_=
opts *opts)
> >>>>  struct todo_item {
> >>>>  =09enum todo_command command;
> >>>>  =09struct commit *commit;
> >>>> +=09const char *arg;
> >>>> +=09int arg_len;
> > =20
> >> I am not sure what the "commit" field of type "struct commit *" is
> >> for.  It is not needed until it is the commit's turn to be picked or
> >> reverted; if we end up stopping in the middle, parsing the commit
> >> object for later steps will end up being wasted effort.
> >
> > From what I understand this was what sequencer did before this
> > series, so it is not a regression (I think; the commit parsing
> > was in different function, but I think at the same place in
> > the callchain).
>=20
> Yes, I agree with you and I didn't mean "this is a new bug" at all.
> It just is an indication that further refactoring after this step is
> needed, and it is likely to involve removal or modification of this
> field.

Not so. After you review the sequencer-i patches, you will see that it
makes tons of sense to have that "commit" field: "pick" is by far the most
common case, and it would not make sense at all to validate the todo
script, only to throw away the information we got, only to re-gain it
later in the sequencer.

Read: I strongly disagree with your cursory verdict that the "commit"
field should go.

Ciao,
Dscho
--8323329-110939644-1472735643=:129229--
