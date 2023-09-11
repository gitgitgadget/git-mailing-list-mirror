Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E77CA0EC3
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348881AbjIKVbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237945AbjIKNXt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 09:23:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDC712A
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 06:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694438613; x=1695043413; i=johannes.schindelin@gmx.de;
 bh=FAZDG30Lnqz/+YyKjYjty1O+mJbWn2PCnMOBALKVpyI=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=mXUXG1vJEpRY60Sy952iSvVzLKNgEf6RBCjkIQOw43GWJzD509RNgvi5wMm+A3MrTdQs+kn
 +88e1TlGd5omer8Dze7Ja5no6CtvMiERSrjyIsZg513V6bbngziaJbWX8eikL4soNzGRW9gEc
 DEesFBXclc63Rm/5MDljXNorzVhyatFIbzmtGj5mimx/g164tXdF3rbLdpEO6TcVfQ7ATfVkI
 G22EAbXJjrlO1+f1B7DUABsBBAojBOkhlTeC837fyHiNY6ziGQ/0niY4J71O6rfMoxYbQtVdd
 fQ+uS5fXTQMwQ5USXe7b8KI3+e2WEKFAU7WZ/8S/tAmJdNyS82rA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.196.25]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2nA-1pstsN2vBq-00n5Ys; Mon, 11
 Sep 2023 15:23:33 +0200
Date:   Mon, 11 Sep 2023 15:23:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/1] range-diff: treat notes like `log`
In-Reply-To: <cover.1694383247.git.code@khaugsbakk.name>
Message-ID: <6e368e95-da48-1afc-01e8-58e23a6117dd@gmx.de>
References: <cover.1693584310.git.code@khaugsbakk.name> <cover.1694383247.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1685944006-1694438613=:115"
X-Provags-ID: V03:K1:Qbt+3gQkRpS/zY4/JO+TMI/5rnZfCEaPTcjAcuE6Cq9+j9DVcUh
 z79Ivn0dQSlGG/8DkWkoHTVRXfgE7oQVaVFvZyWtFHGRzIck4WuzdIEkIbTym2KccwbmRNk
 CFcaxZbKR++dlCsOaISBP3WXxCy1VcQJXnz3GTmwJ2QZKIo4q7v0imCg2ph8+Hh4+x+r001
 jnm5rQsCReVSEyGdpvGVg==
UI-OutboundReport: notjunk:1;M01:P0:4khjrw/1Q5M=;ZENrITmG4QI/wti5YaymrXNKI2H
 8Og2MDRhDazjNSJLHtpOOx0a2KRKA+ppvFGHz5YSpU9Hd/mZsMyd26Bq2U6tqUTRHhRn2Ibtu
 HN6Vsg0UYzr/3JVeO57jt5YFydXAZGQZ1YJEZ2Dx4afrtbugRfCRX2GGFric/M7gNH+jNWPxE
 fQwkPmJd4sGh+VI5tIj8R8hNIG2k3Z4DgM9gQjSovDtMQ6l9Lz19hEDLUL8CInt9yRCQ0pYgZ
 +s3u02THSCZVKxmSBQNmpv/8JKKN1w2l6AsFV9xtqLRrNXtjM98Y8bMCyp6uUll9Wu7lG+HoD
 HmoFpUymZTJjyK82b2rbHh8tdzpmaHQLP79eu2xbXgApr/wKwAxvtPEoRUodwUdzTHX23mRE0
 H3u+rZDxzBlwE8wGrhAQXya+zUKRGoilb4KvaqjiZCcG42P7hbe18Ud+e9cpPHCVRfdG/iBod
 ZQcEqPPxSSrJFekjfb8+bucUBNZ6EgDWDE8c3qoSlPNxpO4vyagaWDlAbr16OBMuWovGbOtbk
 9/XJd8Tvdts7QCaa3YiC3Jz1CzsNAdNIoSIRYbQ13m9Jbpxqn+EW5dloZhHWMPDpJxh4OOULi
 Hwh9hl9YtP1LC3RH+AWCbIgxVE9IjATpd2UxegJ3n9SxS55+Lc4muT270DLPnwteu0ZSBuoM7
 +A5rCTHCbGxddMd7TmCDcB7sny9746OnwiyZFher9Ko8yQ4jkaNu1mY9FVk3SRuYPT7Muve4J
 WRu/Z2GzHAAjRUYWQq4ROqSlbXFNgesC6M1Op4AVzwSnHs3zGqQn1s8Vk0xCTSm3QDySUmtUf
 ZgkalHgjPsTqWTuABec8n7l3cQMAtBSVn4V0YF4vmWuqf/aHKCtDv3NT7FhFjLfwB3pKV9hGW
 gQ+xwymhremlPAN9hxsH8pWbt7SpUB8RvojlHRfe+xI49ei/xNFg5bPavzg/X7irhfSrGjojP
 O3gT+ZZufA1ioyGa3zyq2zPWtU4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1685944006-1694438613=:115
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Kristoffer,

On Mon, 11 Sep 2023, Kristoffer Haugsbakk wrote:

> =C2=A7 Changes since version 2
>
> Dscho provided an [alternative] solution. My three patches and his patch
> have been squashed into one.
>
> =F0=9F=94=97 alternative: https://lore.kernel.org/git/94b9535b-8c2a-eb8f=
-90fb-cd0f998ec57e@gmx.de/

Thank you, this iteration looks good to me!

Ciao,
Johannes

--8323328-1685944006-1694438613=:115--
