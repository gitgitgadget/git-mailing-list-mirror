Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6C001F461
	for <e@80x24.org>; Tue, 27 Aug 2019 18:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbfH0Sya (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 14:54:30 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:15192 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbfH0Sya (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 14:54:30 -0400
Date:   Tue, 27 Aug 2019 18:54:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=proton;
        t=1566932067; bh=OMC6BL2NqRKZ6qGKp0l3uXxegLf6VecFHDk9+cdXA6c=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=LV8BLy6OXYelwd3VgTyegfo+e58axTbLucVz4NQd9yF9Pb91Oe4q6LbmvLVPT7zHF
         GC1Ue/Kqm/4dykbX8/hhF3Bg+0Iq3raLNHGgVe0rNIc15MWUxLD1esPh14ClkGBzQm
         HFLNNtDzk8KjjgBKwJjKMQuaVcINmkehDI6ps6g5qjQchNdUipZuxdHn0Za+e0RoZN
         wPfB0Qa1rjiDSIu3tOABj2UsFncuC9h0j/gyrBsh9+97HT2B0+DeRhw0pzp5VcJUxn
         w9O/1L87EKk2kq0Q6c5DGWlPhps7sGcb4L6QcX5BBHzXJ1Pzcud6g9SDIA2hxD7SwA
         TPJmL05WgkjCA==
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
From:   Ibrahim El <ibrahim.el@pm.me>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: Ibrahim El <ibrahim.el@pm.me>
Subject: Re: [PATCH 5/5] Signing API: Duplicated signing tests using new config aliases
Message-ID: <REK5vbm4i5ut8-lShrc8zcI0FhegDvy49CM2CXn4QS7prThNuwiu5J1Ae_kCh5c29Ri157tB86UXJH372WEFo_uWW9y7wf3oh1ysMZphs4c=@pm.me>
In-Reply-To: <20190826230704.GC11334@genre.crustytoothpaste.net>
References: <xidzc1zBudSNNUInNKpDPgAw3AlwtABPT9VpKuPpAfVodvQejHn5WHIYTrqlMlJEYB11iMVhxNCQKBnx7phcHaiPQhHLaqKgeVZwPTCx4n4=@pm.me>
 <20190826230704.GC11334@genre.crustytoothpaste.net>
Feedback-ID: RXIF8gqyi_fC5k95OfXmu3uPk6ALUZ4LT1y2TXMvXkIlhKcvgGbg1qhMCvct9LiRFa1gVJ9p8_D_liW8QUFSlg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thx for your feedback. I will update the necessary existing tests and re-su=
bmit the patches.


Ibrahim El Rhezzali

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Monday, August 26, 2019 11:07 PM, brian m. carlson <sandals@crustytoothp=
aste.net> wrote:

> On 2019-08-26 at 19:58:10, Ibrahim El wrote:
>
> > From: Ibrahim El Rhezzali ibrahim.el@pm.me
> > c6a1d1c21 Duplicated signing tests using new config aliases
> > Duplicating existing tests that are signature related and updating them=
 to use the new config aliases
>
> I don't think we want to duplicate all of these tests. Perhaps we could
> add a small number of additional tests in an existing signing test that
> makes sure both the new and the old configuration work as expected, and
> assume that the entire codebase will honor those config settings.
>
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-------------------------------------------------------------
>
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204


