Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FD7C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 12:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiBVMIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 07:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiBVMIW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 07:08:22 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988EEB2E34
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 04:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645531669;
        bh=l4uhTUvLcadLgSPk1kK3tCnXZWYh4NOR76D1aWUprDU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LAZa1XT2Afy2KowWjtBOKDZhd7OOkKA0ixgIRhpCloBigUTfCU7zY4W3WXo0Fr33E
         iE9p4EbjIfyxaQ8JHAHNixxI3hKJcZ8FWkd84DQy0ALH+2XzoLf2puVciHIx4kwHdt
         yp14K9oLJCO8FiVwZqsOyMH9LeCkl3oRrZRGx81c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYNJg-1niyet2CYM-00VPaG; Tue, 22
 Feb 2022 13:07:49 +0100
Date:   Tue, 22 Feb 2022 13:07:47 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 05/25] CI: remove unused Azure ci/* code
In-Reply-To: <220222.86k0dn89bm.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202221306190.11118@tvgsbejvaqbjf.bet>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <patch-05.25-4738a22a36d-20220221T143936Z-avarab@gmail.com> <nycvar.QRO.7.76.6.2202221115590.4418@tvgsbejvaqbjf.bet> <220222.86k0dn89bm.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-592315336-1645531669=:11118"
X-Provags-ID: V03:K1:RoQ8GWZ5CBBYc6pndGOOKcRgQP/EAZQb/kAQ8q8kofNnmQVjv+m
 WhPiVb1KbF2FzuYTc5axyIseWroCFOHEuxDaJmTOdw06yEN6upVqmyMmujePZHDkf5h5PS2
 ty4G380km2a72Ky49otiBcC7FwQ/DyE0wJDp+eavp86qkQu07RwhaqrNJegYNELTdP3Y2l2
 Ugp9VfzgqlK/KlQPVlIFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ct+95a+I/JI=:xRzB8Mf7MBr7fOuZCiwZIM
 FuKR56EXpRjGwKKUJupREzXTe7xyzRwMDVHgyk5FbZEHlvCzwUImovezdP7bty2X7hiU+UOFA
 WItnOMfCpi4Ncdgi5/NL2EpUC3k2TazEcawgxwOAG1G9uaaHINQMy7wEbLx9RQm+yNP1lhYp2
 /zgxCTP0C0lliWPdNKD1gnJ5PNiDNq6lkyhZ4No5xJJTh7o3vU0HOmTCALkoaOLB5hBWdPjGQ
 45PfZ1HH/VGN4qtGYD0MepBrH+MY6q8xrNtuE7Q/Ksin5IkUjkS4oK/IyGwIeYr0J1ifqkifT
 MfKukI97QN55moIhD0vt57fXy0RN1RzJ/1ikVOJ9kotJt7Sm84+3qElVI2PZQAUf7Rir+m1Xy
 ZZLGVSqm12rSag2SCYcX31N9VVa61EH8CRzpnw1J2EaU0uEmB4v9HDIlbem+AzQ6DO5TAozPD
 uBp/pVjnWBsXueAVZJy4ldR//qY9f0C6naniBmtsnKDFt4jeXsjTbrD/MBeRuJUHmxaaN6rzi
 TYxkelPUTTJVJXW6hED/cgRcsE/keug65J6dMRsXchGkXkyn6JCzWJrghv0ECRWL+r4Un3Waj
 BP3AnvYAsetuMnqozbE+aCs+7cl7QnozWK5EJ09TohFvfMiaO70sFRAx/cPCq6/VD1CyAHhTC
 gZ8NGm+iTcaz70Gv/6O4hFwnX8AHZFuBtsn3q4gu4SzsALTSYWsJvG1apAJ44roCqmQevlk4s
 44fm6wyc4FCvirII7x3GYXig+LuUMADydLXWEu2wzZXLde3OF9pumzBeFdS7GsvdYKpJBDb1k
 o3CHih3Qx+wE54UaHWxLHQs5A5aMFtFDPyyR9k7mP4T6TVRUWKgNz5HFSEw4ITx4rMHJDhTbg
 IZvt19flVtU7SiYelcBpCAzxKEduxtQeE1hlTXUwAHCeVZhyyKjv/DLhALJowNW8DJnm1WHzR
 yjaAgft2MbIKLW+5xQPT40XEoNxqdotmlWjjA3CNSE+epb1H9HEpb3SDHXOEdqSmvUdjUOlse
 vrsg52/+rdrTVe9XRAB0+eTYt7FbCoNwRrUgqah8dH6le5v1CkzmwzmGEVhwM6q4D8WvdlRKd
 K+Dt7zjMbA1jJw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-592315336-1645531669=:11118
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Tue, 22 Feb 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> It's still unclear to me how Azure CI is being used as a "fall-back",
> can you explain that?

By reinstating the `azure-pipelines.yml` file from the last known-good
version.

Ciao,
Johannes

--8323328-592315336-1645531669=:11118--
