Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6A9C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 13:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiKJNvw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 08:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiKJNvv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 08:51:51 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF6B178A4
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 05:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668088307; bh=qXZj1OZ2DtFPA9aeX/qXiin+Tbx2FVqvYgPF4DCLP/M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=W6UhmRUFlRqy2aAxuky1nKVBztEgPov/2EF8HR9Ez7Y/htVGismC412C80m2VMmCC
         u6LeQpvBVEkLqMWHKrPs9yCmCmygWR2xBIGslCXIXJqBPRfjgtFZJrAYrC6QfmdCPZ
         6OFGLnqkDnAbQa/CTypMxFEUJwQCIj2Sq578MpjzxgV0zrevtBDoiug6pfFTpnV/RI
         eGZ878L/9IQRBH6ISPDS+CaVjOiEwWkeQCqXLHP+28fG01OcKLzt6cMN/L2owQvKLI
         fUGKApaQ2LS1rJPPjK98ICPVk7wtQGp8R3CdyGQO11vD8xMT9DHpZoXobHI+YNDtLk
         SdMc9JYGOB6zA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.27.167.171] ([213.196.213.188]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE6F-1oZgLI0YNn-00KiH3; Thu, 10
 Nov 2022 14:51:47 +0100
Date:   Thu, 10 Nov 2022 14:51:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Simeon Krastnikov <skrastnikov@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Potential bug in --color-words output
In-Reply-To: <e2164b04-98de-6f19-6c33-6979c1a328ff@gmail.com>
Message-ID: <39so8720-p05o-9qns-1o8o-q783271n40os@tzk.qr>
References: <e2164b04-98de-6f19-6c33-6979c1a328ff@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1709056636-1668088307=:16139"
X-Provags-ID: V03:K1:ZnU94IdrQ4zEBQ+yEKGy7b4nk4TcW8Euj186kw+j+trGmZ08cMH
 W3/r/q2ORA6KXLt5geGAy4KXxX2UhxFCg9xq40F8w9iZE18DlRRXYioRxCPH6ry+IvoEaTK
 vZKdbJTc1mCiVDo3lWGhVmtiaCbIHVSBddgibfURjT/FMNl0ysq9U9qbl+xdGttHYVuiAdR
 ZI7D215GNCSUVT3ftNlWA==
UI-OutboundReport: notjunk:1;M01:P0:TwYhq121v0k=;8AuTB2cCX6sWvoR2FIX6aWuQT4n
 ESDWO0xBpzDwtds31VosMPYabW6uyi+jdw3LpQmuOvMX7p37AU9Wx39zoeXrSstmwsFihf68l
 4gJJJ6T3H5bIzigDNmGNJ6OsGUH6xz9oBhZnYTnRrQSyXd+cP6qZdyJHc/VbKxbOANEo5xHAn
 TBmOz2/Uz8Iutq6zwLl0McPLoqx9sgyOjbSHr2YCVXQcduExRRfw5oldU6PY+0grT8vqhYJY+
 aeHv9lBu6rV2YT6PRCqdmXFquarI55kX+RJpdOiYkP5CWPwGqbgdR8vubu3maz7D+9INTK0Gj
 R83F4PaRpaLimVtIWGiniiSWU5w4WssSW/eqpPk5wNq0PY22B3UMr5qZsB4KmOP3YJe+ALQ0I
 IrkLKLG9++QCXOiPuQv7M+laBGt7pa5RJDtf/jnpyvs7Yq6kOiEY60gj2E/JofWPOp3I8h0W8
 3J9SOWKJUc1Qas1REBvKSdrakLvUe3xXjVC+PNAddhhRJzomgL96WwuQOgIRP1fPJDo9OlFur
 1eoNjyGUcnfGxtOK+b+hHXLZzBalNox7vwdIPpJydhH8yoc+x/gt1SRDklNQpK3Nzz3kJMi2k
 QlMbPP9yrpT49QYaPrIheI8sq7q77aNN8MDUwydnac/p3gmnJSnlYuvl25/gqholGXFHJ/FQ5
 YpNslG/aO++Spoeto7ZzPKZYgbNNfWSQ2+TZxjfpfI2U/sfqYv0/Ai1jtlH1rjZd2pbfIkRiY
 yopKozTpxm+SuYMthgnhUjuyy2xOYf1sxYvkShj/4DWcSPvJhOsVjTNfcTHWh4HIO12F4kB/I
 yk5MIaDth3SVYvRW0ychDA3dNqKig9JQ9w67zQdbwQkHRlwnnyzDaxkYQSfJcMyUpXWqsX8xP
 DcfGUfo3wMCzLIO9wmKvt3kGkycofqRWQQ4FryStAa1zxq0Ag8Ui4PHGrKmo9MBVlWER/XMg3
 g7Hpydlw27uZID3K8STxlmC6ZSY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1709056636-1668088307=:16139
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Simeon,

On Fri, 28 Oct 2022, Simeon Krastnikov wrote:

> Given an initial file with the contents "not to be", which I then change=
 to
> "to be", the output of 'git diff --color-words', is
>
> =C2=A0 notto be
>
> with the first three letters colored red.

This seems to be a limitation of the original `--color-words` design.

FWIW I find myself using these three aliases all the time now, i.e. using
a different word-coloring mode that works much better for me:

	[alias]
		cwdiff =3D diff --color-words=3D\"[A-Za-z0-9_]+|.\"
	        cwlog =3D log --color-words=3D\"[A-Za-z0-9_]+|.\"
		cwshow =3D show --color-words=3D\"[A-Za-z0-9_]+|.\"

Explanation: the regex `[A-Za-z0-9_]+|.` treats runs of alphanumerical
characters (including the underscore) as words, and also treats any
individual characters that do not fall into that category as "words".

The only downside of this is that the coloring does not help identifying
white-space differences because only the foreground color is changed
(which does not result in any visible difference for white-space
characters).

Maybe these aliases help you, too?

Ciao,
Johannes

--8323328-1709056636-1668088307=:16139--
