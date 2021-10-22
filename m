Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603A5C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 07:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49CC1610EA
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 07:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhJVHxj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 03:53:39 -0400
Received: from mout.gmx.net ([212.227.17.20]:52163 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232180AbhJVHxh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 03:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634889078;
        bh=iIxpbXX2ppuwSv9wknHZXqlwWEdbDvEetlWZPjdBmsA=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=aybyjaDI8eQkmmsOaYPxCVEO0nD6ziwqZqExMPKl4DrIkTjdMLFaBrBKOtmTvv0l9
         bCJ3mlR/wkc59oVhM42PYsgNv+FLhxk2HDA6eDkXUpYhWhWRNXu6ujoHYWvT/t6QEi
         f7XYS1JgiVbMkEg26ijBoied41CIYdkWCrnG8zLI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.19.78] ([89.1.213.179]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Wuq-1maXXW31TY-005VRw for
 <git@vger.kernel.org>; Fri, 22 Oct 2021 09:51:18 +0200
Date:   Fri, 22 Oct 2021 09:51:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: [Summit topic] Let's have chalk talks (part 1/?)
Message-ID: <nycvar.QRO.7.76.6.2110220950020.62@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1395394440-1634889078=:62"
X-Provags-ID: V03:K1:RKzCJQIWaEruLv5BGhag1VTDw6kTp9XqJ5B8HpYk2BNQnv9b99P
 W3jJYsB/6QinYqjaySDtf1W144rqOWrI39/k2oInGyHNOrKjw2R5bszmLzAVPgKfmczIZtl
 RUv516S9JOtFFeY8UXiTdKupaXcpSnYkXDuVV4jLXr6w1RtF/qc63BRD+GzmbTNNJXAY1A9
 8mV+Ucev699chdsFsMPlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KunxnbvqgO0=:1FijlD173m3CXCebZfKIgI
 vrci2ii2hGBaaX+TZpraDdS4fOF8NizGPpxqJ8MfYItsFqIBDYuC05ZLj7jhzdxmvVNyN8tH/
 FWnUL3V9uCqu7Xtk+VCCVAv0/s1Ss2mWPcMHnqKyD0qw875DOt2R9kfLMUOoU42IDiIHs3VoA
 R9ZaPjKKjahyVRz+gO5QwVdQe7baw6+SKLNNS3n9AOo7zvvtmDSYSXjxHGXkqlDi6UHL4G+U0
 ji41W9tdmwkayT5xnX7sUulA0x/wJRKGIHT0K1ENrZTf/NqfvbldAHRiqii4mt6EPydPQLZmb
 jBZkwVmJF9VHHUDecsoEF2wXLXB2bRtfrqnyfH4Evx9ibYd9dfR97QqOWECGhd5rSOMTCKAc3
 gjMhOdkYMfu0Ctw5W6XO9JNantGTgvlhix1outTT80F7uxYY2MHtrIMm7CIKzLedF0VKtJiAF
 HE/U1Ti9uwn+f+vKLtfokZN8ITyEAeHjMpp14w4aRutsiQb5e211X9ViXZIkzXYlOUYLo19LY
 INf106KwGfty7wqJWKeFRlNapgHMSQj1Z4TRRtP0sxjE2KSuX0wjh+E/Fg29BRDgyxktD9nsR
 Mwwzm1f1dlEKunuSkXPoZjChgz0JDkpGInUJfbtvPLUs1SIHEd0zzBxvxnWQu5/f3KFoMyAOp
 9yoMw/XnUu+wRMUmT88/KE0SDrya8n6q32Q8GgIVoO+z70oXhA9WV2XCnsjkynVk1Bm+hGc+0
 K2VE7G5jW/UAX7jEeecpBFjlbqPF5vCk7yIJSbxpLq1w3D+mvKLJSC+o/ear+2TQnIA9o0ATF
 DFghAYpDjZcwEb2KPnXU58Jn9B/0RI+Yg5Ey+pLy3OObFlsHFeOplQCNqvQCYVi3tCmxe3Hm9
 kGkGWRP+3jXCMBdy4ZTxUJEVPFAINVxgOMXLVqU+0dBGDqH9rU9f6wSHFT2n6/5w0CuaHSuG4
 ag0dxUOmMWKwjx9PbG5wHXwlDhs9cY5wusSySjgk7JeKd89aUPs35jSlZgfxE7HtcBzwD2IJG
 Kmu/57l0rBNHWXb1lqw5T9I/ldRWxpGnZCXk3QVELC/CH9X7leNs4wbVWcWWsEFy9v/YYKbNh
 SMHkJ7h2KBlYgE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1395394440-1634889078=:62
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Apparently I have to send this in chunks, to fool the Bayes filter of our
beloved mailing list into doing The Right Thing.

This session was led by Emily Shaffer. Supporting cast: =C3=86var Arnfj=C3=
=B6r=C3=B0
Bjarmason, brian m. carlson, CB Bailey, and Junio Hamano.

Notes:

 1.  What=E2=80=99s a public chalk talk?

     1.  At Google, once a week, the team meets up with no particular topi=
c in
         mind, or a couple topics, very informal

     2.  One person=E2=80=99s turn each week to give an informal talk with=
 a white
         board (not using chalk)

     3.  Topic should be technical and of interest to the presenter

     4.  For example: how does protocol v2 work

     5.  Collaborative, interactive user session

     6.  Helps by learning about things

     7.  Helps by honing skills like presentation skills

     8.  A lot of (good) humility involved. For example, colleagues who ha=
ve
         been familiar with the project for a long time admitting they don=
=E2=80=99t
         know, or have been wrong about things. Makes others feel more
         comfortable with their perceived lack of knowledge

     9.  Could be good for everybody on the Git mailing list, might foster=
 less
         combative communication on the list

     10. Might be a way to attract new people by presenting =E2=80=9Cold t=
imers=E2=80=9D as
         humble

 2.  Does that appeal to anybody else?

--8323328-1395394440-1634889078=:62--
