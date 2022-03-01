Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FE5C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 22:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbiCAW4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 17:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbiCAW4H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 17:56:07 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D706730F47
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 14:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646175320;
        bh=6uexDRnx/SvVO3t02Mr/QKPufAOyj74PUBkXlOhRvgI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=L5haOkgrUqW7IXpRyR82PqxsSQijnBI7wN4pDVDM9hkyzz3J7H1EHZI0potvSJOZq
         qBeBsu7M1NpWfrguqQARH1Sq9hsuYRcUhtHQxQTDyJFxS7OKmsRLl/QRxUincLsbec
         Jt0XS1bnx+25QKXEelJryhWYuFuR4Sn5r9Nc2mk0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.214.47]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJVDW-1neeum0oZ6-00JrQF; Tue, 01
 Mar 2022 23:55:20 +0100
Date:   Tue, 1 Mar 2022 23:55:18 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/scalar-diagnose, was Re: What's cooking in git.git (Feb 2022,
 #08; Mon, 28)
In-Reply-To: <xmqqmti9ssah.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2203012353090.11118@tvgsbejvaqbjf.bet>
References: <xmqqmti9ssah.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1209313880-1646175320=:11118"
X-Provags-ID: V03:K1:mvhUcIsJGzm6yuTTBEzCBQ0AlT9vLBIEjKlk2Z4gsEs4gYHnocf
 KCWvHoUMOzoZXdmUdf5wRadEb962UzZSgC8+Xlw5fbubI+VThEUJYK4KfQ5R6QKp4aU1lx6
 2l8Ewn6gXviTu5uTyeE33lf8OhBcpuzfmw/0mrTQ0zSWiEYYcbcnLtk/fHFUhAJY79hM63e
 gNXmR5bBwsCjJ7svsRXPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uZgfwyn3v28=:/JvoyGUr4UYGsOKfFWJxqk
 m9itC3vl03gTmT6PCwW03pjWf21ng/pgyj3IwhvX839YfUajoNli1kRXZm+6wX8XhldGZEBqc
 G5WlK9QCRpOGJnaAo8oDz6zN+nCGtnpaHz3cyqIxwupkna9mFrMXiWI3L6xrrmPk8jW5M/qdj
 +2Q/lgDqm7KTJrVnjXsUS7rtZzfoRiZOK44620Vnc+856vvRrUAgnA0E2qhqDUSiXcdfuzqZd
 s9teGJ1vokeXsRpP28CFaLntXiFe1CfsfnQjETFgAdvmNd3Nn6Ac/F1XtKtG4DVTQAhm/hIpd
 DSfyzIzKbuff3y1r6bEjIBYwFl1NzEcNZCXJ4qOwwqWJeFQ7/LN0o/WunuCZvo/I2tkw+/bkq
 oW3CdncRWsNChCU3V2X+qp0gm2p68svpKk5k9s7Kg1RUynI7PtovO9+aqLKzeTe2LCzVJC7pK
 IVD8MNckjDZM1ys2kI7WrUD+PKgPfJWLSUQXT6pAnQcUC2bx1UHgaqovwjRpJf3CWVtAGX5tc
 5UwyAh1VETvjE2IlU8x3exwdwWgvpVdYwG50yXItyq4xz/Nbx5NGApjIc9BhEikl8KSEaOIPH
 oWI1JimFg+lMEEj+GMI3AO8lXWWzVJN69bS5krEdVgzkyc6s8okLD6o17kQ4lqVLtqK2astvw
 QDziJj35dcAY7RxfKTLwiFcrciLQ1feE26Qc3IEwmZBwqQjEiT65+kwTVt4XKuxCyzTcePg8L
 /sUknPQHfwuFrUXCLPK9agm0OkF1pJd1DosLatLt+tgkoPSTZwO+2RskBtVBhxohRvYR8yHvL
 Ll8UVvveF09wdZt4bgwPI5eFyk9GnRrSO4IOjLhJes2V6wvqb7ZZrNZq3uv18cCoH6Iq7NNl3
 vF3z3SAh8TWHYxR+mBsbfKLwl+VYZ/EVHiOWKczYg/kAeS8dgN4byQQWmlsxawUh2jfD1WXuW
 czGZza1J6hyZ3KGtb0BSTnBq69V9o2dhuJbMq1AMLLAp7Ssrf5UWplNkLVm4IFTI4XA9Ucmdq
 HWIw6ewNaWdoD3GNi/k2iVpsTfdFkLdePa1ZhZ5k4S/OqBph16d6ewbnFW1hbzuCDeNb/3ywp
 xjapAUwNupy2hA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1209313880-1646175320=:11118
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 1 Mar 2022, Junio C Hamano wrote:

> * js/scalar-diagnose (2022-02-06) 6 commits
>  - scalar: teach `diagnose` to gather loose objects information
>  - scalar: teach `diagnose` to gather packfile info
>  - scalar diagnose: include disk space information
>  - scalar: add `diagnose`
>  - scalar: validate the optional enlistment argument
>  - archive: optionally add "virtual" files
>
>  Implementation of "scalar diagnose" subcommand.
>
>  Expecting a reroll.
>  cf. What is the status of this thing?
>  source: <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>

The status is that I'm woefully short on time and did not even manage to
read the sub-thread between you and Ren=C3=A9 (which might need another
adjustment to the code).

So maybe set it to `On Hold` for now?

Ciao,
Dscho

--8323328-1209313880-1646175320=:11118--
