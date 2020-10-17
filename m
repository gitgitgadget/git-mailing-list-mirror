Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547FAC433DF
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 05:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58CB1207EA
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 05:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="cG/L/mjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393099AbgJQFbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 01:31:46 -0400
Received: from mail-41104.protonmail.ch ([185.70.41.104]:55276 "EHLO
        mail-41104.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392012AbgJQFbq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 01:31:46 -0400
Received: from mail-02.mail-europe.com (mail-02.mail-europe.com [51.89.119.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail-41104.protonmail.ch (Postfix) with ESMTPS id E624020098C8
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 00:42:42 +0000 (UTC)
Authentication-Results: mail-41104.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="cG/L/mjm"
Date:   Sat, 17 Oct 2020 00:42:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1602895355;
        bh=SZIVsfYIhyMvhz1heR9EuFJ+oDoTjWWw6eajjKiNsSE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=cG/L/mjm+UCCd2mddvmxC01l20silMuc04pEv7f6tcUCoJ8PsqqPAV7HLb5rwGxeP
         xpiXZ5Ky4AWgsS55D1s7kct2SpX33wuPCDoF+p4I+8NAVFrYpONb5Z3afdRrKaQxXU
         54MjOKeUiMx3borJqjbfDrlFzZxtc0nhbxos6n8g=
To:     Jonathan Nieder <jrnieder@gmail.com>
From:   Joey S <jgsal@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "wireshark-dev@wireshark.org" <wireshark-dev@wireshark.org>
Reply-To: Joey S <jgsal@protonmail.com>
Subject: Re: [Outreachy] Introduction
Message-ID: <10jLX0WcuXO5QAeFmLoSxxyDAwb9zvqiYPM8ZId5Rab4os7_yXTksG5Fc7Z_pM97vudO0W4AtE4PuunS4TeS6z45heDTJpzAfEuLoLycgwM=@protonmail.com>
In-Reply-To: <20201016230801.GA945741@google.com>
References: <HiG3ctHji8hdGWXWEwWgeoa6eDDHkUbhfa0x0xYr9EHWD7FqXqZsQt3fHMZ4Vle0jo2QPCW8rjRviw_aGKqxUIFtvX2igp1aUnx9p6YCL0Y=@protonmail.com> <20201016230801.GA945741@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you Jonathan, will happily get to it.


Hoping you all have a nice weekend,

Joey



=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Friday, October 16, 2020 5:08 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

> Hi Joey,
>
> Joey S wrote:
>
> > Hi everyone,
> > I'm Joey Salazar, an Outreachy 2020 applicant certified in CCNA and
> > Linux+, with some experience in C for both private and open source
> > repositories (BIND at gitlab.isc.org/Joey), community code reviews,
> > and automated tests in bash. I'd like to contribute to the "Add Git
> > protocol support to Wireshark" project and improve my skills, yet
> > remain open to a different project if that'd be preferable.
>
> Welcome!
>
> > I have installed and built git, followed
> > git.github.io/General-Microproject-Information and checked the
> > sample email thread [1], as well as the tutorial
> > git-scm.com/docs/MyFirstContribution and created the psuh command
> > files here [2].
> > After following the git.github.io/Outreachy-21-Microprojects page
> > I'd like to work on the 'Use test_path_is_* functions in test
> > scripts', and given that Charvi Mendiratta might be working on tests
> > t7101,t7102 and t7201 as per this ml thread [3], I'd like to check
> > with the group if working on tests t7006 and t7300 would be ok.
>
> I'd recommend just doing a single file. t7006 is a good one.
>
> > In parallel, I'm following
> > gitlab.com/wireshark/wireshark/-/wikis/Development as suggested
> > through the #git-devel IRC channel
>
> Yes, building wireshark and making your first modification to it would
> be a good next step.
>
> One possible first modification would be to teach
> epan/dissectors/packet-git.c about sideband. See "Packfile Data" in
> git's Documentation/technical/pack-protocol.txt for how sideband
> works.
>
> Alternatively you can run wireshark and see if anything you see
> bothers you and make a first contribution that improves on that. :)
>
> Happy developing.
>
> Thanks,
> Jonathan
>
> > [1] public-inbox.org/git/1386590745-4412-1-git-send-email-t.gummerer@gm=
ail.com/T/#u
> > [2] github.com/j-sal/git/tree/psuh
> > [3] public-inbox.org/git/CAP8UFD1m2zXUm1PXmJKW2MxA9XZVUOkBFA62jLP7jx6_D=
CYZGw@mail.gmail.com
> > [4] git-scm.com/book/en/v2/Git-Internals-Transfer-Protocols
>
> [5] https://www.wireshark.org/lists/wireshark-dev/202010/msg00042.html


