Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47F1A1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 22:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732658AbfJXWwg (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 18:52:36 -0400
Received: from mout.gmx.net ([212.227.15.15]:46561 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732600AbfJXWw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 18:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571957540;
        bh=e5A5c9rER143w4bWr2XYtf7KtJ3gdQGQuSFdIQVOfjU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FgA5u8qzthobYaEWzQHyEdz4o+9RQlTcHVmtRp7qid8mZzgGbcniFrjnPXtd2XxeG
         YlPIRsKuNWN7hz+pqjIS1VuGL9skuKxxR2e8E6WivpsCqM+ils88dINm8zxF8OPsWI
         wBtKovF6gXevaIt/PQl+QhJKyuPBhu2pQM+FCcKE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mw9Q6-1i7U8G1DAi-00s2hE; Fri, 25
 Oct 2019 00:52:20 +0200
Date:   Fri, 25 Oct 2019 00:52:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bryan Turner <bturner@atlassian.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Git Users <git@vger.kernel.org>, git-packagers@googlegroups.com
Subject: Re: Git for Windows v2.24.0-rc0, was Re: [ANNOUNCE] Git
 v2.24.0-rc0
In-Reply-To: <CAGyf7-EyK0COjea2CPM7U5h6uekcFfL1eREQ6tatM3nQ21J_yw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910250051450.46@tvgsbejvaqbjf.bet>
References: <xmqq4l065zx5.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910220004190.46@tvgsbejvaqbjf.bet> <CAGyf7-EyK0COjea2CPM7U5h6uekcFfL1eREQ6tatM3nQ21J_yw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5hAC2qp3u93+w16GtUOv+3G8OKYpL1LNbcMkTM3esz0HlckqlT3
 VGyj3BIOpXvxBNxvLgundMV5NlO8tOimhrl5gHqg+sJ4/0V/EIPvU2S/5zGhIx/fI/NBl2+
 myUBoBhWD8V3QYHV3Dac21emNGMFhKg9Rfn7nVWknBhKFocYQIRWdK4fNyanXtCSuVg2PHW
 Sx/Gp3ymdb+Cp1j1IDIJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cMp7I2h8UDI=:1dxtPt6BZpU6mSWrWFHAI4
 1qzsCHLrlpgInYc76w2DJJbaIlz1089exgPxY6aeHBNiJEmnZBAvV/amGRQNI3l/Q2z3VDxP2
 SPJSKRoP1ojnwIl9Cc9n6mkwSi+zkhenXkhpympUAJ1V2qVN3vO2al1CmzICaeds65uqlNowi
 v+spusa7V7b4Hhz0yqmBXVFgySYciZkyTSZinbV2DGPSi3HHENEun1nZhyL9+fpTZZVM+ezk/
 sE/l+YUAq1boRdNyrf9iJnXfP/+8Jg+iU02hAqho+EedRQfl5M37114sNxQvMy+76u/HmkDUr
 D7zTfTRqDMk4R3QWviQ1cABt9qFBMMumSgGHrbhjkJgUBd2vd9mXseWbKuFPt+N+WIVp6XTNj
 T5zU181VkUaTU0OCJK9iDUo1A7NVrMVu9Tz8RDK8Ch5RH+2U5kI33lSPMVPvW4uC037L1CCT8
 fI5JhJsHPr0GUXhmYt9/+/jed/+kUmqlyS/G2aCWkhmJbGFjaCqUXpbBpGtqQflULM5pwzhZm
 33HeKRMJLtZQ9Zurv5d21c6waVaFJ4NjH+88DK6AQPrzwks6bjT+skblxM3Ihzi9vC44AXAg7
 IEadnbxcj5uJEV9KXmb+8w0v7rUzmemrw2Q1qOCCDTVIoB9gxJDEVZ/+NT5wvoXeRLiCv4drd
 kcgGgedjKYlX0mxROwrWU8XjKJcp9er44wRpMwD4zhXQWFHRjx978lkTLUb64CwTS0auPuvn+
 LJ+6wG1UkN9511gEeUkQsdhP6B6VacBJPfcn1dJBZ/D4tZGWdxROFlKuW8/Q8ZR+SMba5WJvk
 bOcNWRk/uUBqMTfSUMWTLNWYXCyCbkdzYtriUvARkUZso7GAqUfq5DAu82LpYYHv0Jb+vnZOP
 5wU+nO6tSqE13cn5RncYhSy6ae5MLOHq3qMlzB/1++Nu9VzQkQAx45IiAGU3z+x7vawnZeTem
 haxkjlamYJoWGeZ18teGsiufYs6U9XfCYSuoR6CjgkcTXcdL9cwk8onGnefXTrPVC9c/feOtO
 bkM7gUxk+EV70YkyQEC8DGzTf1LOJX1uepenvCy/Tlx+ikjtsd72axf0uvVPHX7bgMVfoKnaW
 1FnJYu6e0jjVoMoH0YqEHp1MUzdTkknRmpABeOjVUL7BLn0/cBM2g/20ThA/NVkWXVcGECmsD
 VzpDj5nLb8auhTiEkz/glTTfu6XVJ0y+Eh9H5Z2Zh67WE70RQl6RJYM8m8WhwA256pYbcFhDE
 8dBlJCFlBSVnn0CEptc2URIa0G3XiXddu7vHbdhK60DK8M1WnurWmYQ4jSzk=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bryan,

On Thu, 24 Oct 2019, Bryan Turner wrote:

> On Mon, Oct 21, 2019 at 3:05 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > a couple of days later than I wanted, but at least it is now here:
> > https://github.com/git-for-windows/git/releases/tag/v2.24.0-rc0.window=
s.1
> >
> > Please test...
>
> I've run both the Linux and Windows 2.24.0-rc0 candidates through
> Bitbucket Server's test matrix (~6,000 forked git processes,
> exercising various commands and verifying behavior/output). No issues
> found.

Thank you so much!
Dscho

>
> Thanks again for these early builds!
>
> Best regards,
> Bryan Turner
>
> >
> > Thank you,
> > Johannes
> >
> >
>
