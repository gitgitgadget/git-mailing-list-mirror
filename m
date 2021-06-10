Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B60C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 07:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FACB613D0
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 07:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhFJHqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 03:46:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:57133 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhFJHqN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 03:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623311044;
        bh=ljWCp4Li+Id9IQ+oXqG5HNtDBKtkF3KXSiDCH5mL+YY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=isl8jrLNQPDWTLGgj12uQIPl1g51xIfVYdXKHQsYP34jHgqAY8u66PQ2oNWynihgm
         LYMKpMW1p8Z/TBM7IrP4IHHAwqGDTTKhn5UDuF8a0B8hur1YVdc26oq54b2O4UiUad
         9TTBxQBmlGPbw3dMas90BfCdFdmPMz2j6qlw31aA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.213.18]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqs0X-1lUt771lb7-00msOJ; Thu, 10
 Jun 2021 09:44:04 +0200
Date:   Thu, 10 Jun 2021 09:44:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/4] Documentation: use singular they when appropriate
In-Reply-To: <87eedd4n20.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2106100940380.57@tvgsbejvaqbjf.bet>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com> <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com> <87eedd4n20.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-561572494-1623311044=:57"
X-Provags-ID: V03:K1:JmWWhDPnhPwDqnENXVMbmYuGvw2nterE7Kod0/lHkLTDGhuw6cl
 vPCSAEkYsYfe1TkXBLNlEPyq77rrEHkoEutixYwTLE+pUHLqiLy8ayIXXqvtQzI2R62MBGq
 EbyVfSw3s1bn3YVZ3m6tks50eIx4eQneLJBe2dtGxexJZLHY/lfYjb4AAnlDRsLXfAUhqrP
 Pm2eeA3la5k1ysZnOnXjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y6tZg7tesjk=:TkFO97gZBApGyATJkTe3J/
 /TBkKhvwWJjh5OlLo9UR/TFlCD44jebUxjBJnFK3aevli9FY1sAOStBmff8z/RwGkgwXMDDSZ
 ll21FEnWC4GZrES3ZsES20b81IbrT/ipnPebcTuwNjr3oQaZEsvU0jO3xgNwRxAMEdt1tJvIl
 5uCC40XoF6ns4591RdTkMnf0VvN+Is1IXqQ8s7ighSIoGrBTqNiRYH2bc1Zmy6i0YBg6hvCei
 BWzC8ng/LodjbqaQo7U8iB1y9G+iv/xCT771KDznkl1ZtxQv+0x4Ik6fdYy7nQVbTgsCmAIF4
 pul3Nkq+jm4cVonNipKBFK/VUskhBM5FaJB11EXRqYPZrQFk+qMNwblJp9dL4C2rYyrisRvoT
 +N+jjrZZ/vLlw9CjM6qVJT81MnLwFVCZMrSUE5VircosqV02C/+DSHjvXEK60HL6Wga9RU5Kq
 vGCSBFH6PL7IF/8a3jVQKFIntMjvyu0mIWka8zu9xj2V1p46R+i7XV9erNfCS/gZ4XdUwsUIt
 6fcYOLOFKUhGcX7lQTqh7hoh7PG5GeJoUC4O+CUr5lVOCUMBnP3A2zxWTEcWxSouuiZGkNngU
 lzIPkCd/3AXubaf+vQASohLgwfJlv8e4P4xJDhNycy3ebPimn8F57H73dlpFCNhPI0shJwCEX
 91C6SB/wid1MI6XbG0OQUJoLnVEa3+qrQxSsej7jieaLlOQewVnbJLM73P52rQc2zEVz0e97m
 NIqiM31D2GeJdj4kBM+RSfVc4ZGSA4GTd14YuMwrO2HP1ZDhR6s5U2d+cOf0ko2ZvbpTLbpjN
 Z3qvbDQLsM47k/tDGu0EMyDaHYFcTAFmsF+ICweKkshMJh0LRGrby0Dj4+uGlxZYrCRkz55c6
 MEvE+kVkeA/9f6RIWMiOWInxMrWDyhRWWp4WbfZlh+IIdfCOqTgPI7whwSnvzFdYVNqh+vJj5
 mddl0o2i2ZThkXxSDm/rlAHfbm2uMMf/hodMH/v4RrMWXxNK9ShJDtfjUMgUvudCMEZPbqZKl
 jCV+L5JX2zX1pyzSX+hqeQjqDcoyqiWkzMKIC8aab3napXK9ewQMYU4zghIBR51SkD0pPRIET
 HhqBXY1xrAGgwvvksJZUE1sxaWNShDUjH3AJoU3auShtidkR0QTjtW0WA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-561572494-1623311044=:57
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 7 Jun 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Jun 07 2021, Derrick Stolee via GitGitGadget wrote:
>
> >  .../using-signed-tag-in-pull-request.txt      | 38 +++++++++---------=
-
>
> This is a quote from a mail of Junio's[1] (date and all). I don't think
> it makes sense to copyedit that after the fact without at least editing
> the header that indicates that it's a verbatim reproduction.
>
> 1. https://lore.kernel.org/git/7vehuyosaa.fsf@alter.siamese.dyndns.org/

We edit those documents all the time, e.g. when `pu` was renamed to
`seen`.

And I think it is appropriate to edit them: as soon as those emails were
copied into a version-controlled repository, we implicitly indicated our
intention to iterate on them. Why else would we need to version-control
them, after all.

And it is desirable to edit them, too. If we truly want to be welcoming
and inviting (especially to potential contributors who currently feel
underrepresented), we need to model the language in our documentation
accordingly.

And I want to believe that we truly want to be welcoming like that.

Ciao,
Dscho

--8323328-561572494-1623311044=:57--
