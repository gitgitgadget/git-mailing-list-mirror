Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7BE01F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 13:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755296AbcIANfQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 09:35:16 -0400
Received: from mout.gmx.net ([212.227.17.21]:56376 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755289AbcIANfP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 09:35:15 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MLR30-1bg06u3zXe-000bSd; Thu, 01 Sep 2016 15:35:11
 +0200
Date:   Thu, 1 Sep 2016 15:35:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 16/22] sequencer: prepare for rebase -i's GPG settings
In-Reply-To: <a948ad4f-2145-bacb-0ec6-7edac14c4d4c@gmail.com>
Message-ID: <alpine.DEB.2.20.1609011534300.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <c6a37af958f59390c00429a5b38b34d34c9a5b95.1472457609.git.johannes.schindelin@gmx.de> <104de15c-77e8-9474-9579-4934ca8a4323@gmail.com> <xmqqmvjszoia.fsf@gitster.mtv.corp.google.com>
 <a948ad4f-2145-bacb-0ec6-7edac14c4d4c@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1291225525-1472736910=:129229"
X-Provags-ID: V03:K0:u5Xv/nFfmwPnL7CBU1Dl5F2wvAJg/Upz8lPOuLXwLWTdmBbBKZ6
 AlUyMS0FHK4BtV/MIeuRVe/1DO7ub1rWXl5hTD2cwkjNj2tvGMLl8BBsn82NS35zq9T3tz/
 FMRrjHx+3KbGpg8elMcW2xOYXo8csfzRkE7ef8Nxv12xhdHaHJfI93KlNB6BILGDDGqfRfV
 TsSdKwAzJNxePRK1GTZIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+aBAyfMrfNU=:2RarU8VUgo3k0WGrKTtVg8
 EyAUf2A2Qn+SaaD2h69hcX/YQ/orM+vxyUaZ7oBn6Q+7GG6AIppOvdF/uf8bTU/C5aFBx5rLy
 srBsdT63Guy6H4mc5OnQN3BckabHE9hDfwlvPXTeLrKV+MZQdeDMqSZCwNUbvean1cR5DoHHo
 p8D+CVV9rEungLBS5JzEg7HIHGxija3kXkV2Tqyf8iF5Z6LWNE5Sod5tCs9xVeKQC+DxfL+MR
 dUmkge6SxzeC9Ajj6NuA8bqzX8cafKJSRm/VnfUitlV2cYbVDkAEb37eWu27RVYR9tkJuGPjj
 9H2fiGJ+U49DtWnamxqcHKJ+qDjS5Z8p+PwFBSOKwf59Ot2wF/4uKxHPdSBgyWETvgOLcYBqM
 YZ6QOYSne7ISRnxLl54BaMiMe2hjZ04VzW8PDvxXa9SnnjQl76iduv3F+/0WRmbKst0cbjyKS
 br6yK3BhHA/oj26uCerNrBN923y0G4PTL3eZWmIWRTnrxPhFRe6jKNUUjCVRfA2vzFft6LXil
 w83iAO6dpgY8whBq2YK7Yb8LnkIC577fAQjJuUtJcIyVP5T7F8otCBHefmH4wm9q+ZRzYbfyc
 qgZq8UOZySMGPFEigNIj3NBum5GrBBrw2IzIVVulC5woBIlssRBZ8PhZKsfiC815o2zlO13M4
 ZnovKNo2qyErGmoV3rmfeQvpgza2Pu5110LQp2uXeUoWqH3MKGZ+h6rEXT5yyhxQ5J5FCKUwA
 EFvHq60l/rdv+HiJlC7dCD3jR9w0PUFZ1yVEmdIvJCNVnyeo6ad4CFLB91eRGFC9HDvT2/HnF
 BC0NsrK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1291225525-1472736910=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Wed, 31 Aug 2016, Jakub Nar=C4=99bski wrote:

> Note that if the last line was
>=20
>     +=09=09=09=09sequencer_entrust(opts, strbuf_detach(&buf, NULL));
>=20
> we can make it not leak.  A bit tricksy, though.

Heh... I made it that tricksy, then.

Ciao,
Dscho
--8323329-1291225525-1472736910=:129229--
