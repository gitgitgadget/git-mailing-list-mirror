Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253A2C33CB3
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 21:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3ABF205F4
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 21:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fc4itQrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgBAVGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Feb 2020 16:06:53 -0500
Received: from mout.gmx.net ([212.227.15.15]:35967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgBAVGx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Feb 2020 16:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580591204;
        bh=SoNaYRz5DRQCBNGz3HrT9Bo9q1K7So/ci3OFmd1uEx8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fc4itQrTFjMO5p6dp6gOUcys34karL99pZ+N9wuwuBTxdEv7sEPR8otj5dTTE8R71
         j3BYr3BEZ4KoEu7wqM3b/HOme+KWCF0q2fC9CLV7Cov7V44WlecHd7oBtQXs/K+HYX
         lRmL8Dib359alKZzbYZMyFrJtWNWxJ8MbIqX1lSc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6llE-1ivGQM1wcA-008H0m; Sat, 01
 Feb 2020 22:06:44 +0100
Date:   Sat, 1 Feb 2020 22:06:43 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Mike McGranahan <mike@mcgwiz.com>, git@vger.kernel.org
Subject: Re: Patch text in git-add patch mode lacks whitespace highlighting
In-Reply-To: <20200201110203.GA1864964@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2002012205520.46@tvgsbejvaqbjf.bet>
References: <CAK7jxYgJNvCp=m6rH31HNzN9Mqgaav7_YPvUMZmRb7mdYDZ_1g@mail.gmail.com> <nycvar.QRO.7.76.6.2001311304140.46@tvgsbejvaqbjf.bet> <20200201110203.GA1864964@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NBJqv+oYbUaLXOIN+o9yz2ic3F2Eh6C7f3Fb7fzmDMogo2HtNf9
 L7ZgmamQShYBg3QX3ZryxQdgalFpYfTOrm9D/CLHxV8MF4hrf5eQXcA51GYo66ozFbZpmWL
 JTugNWzEeGiXVAAwetJCf4+UvJb+BqVZWUbMX/hBid0gpwCkYqeKbDrpA3PP4QzE084/oXH
 aoeRG7S2XQdOgCFxNOWjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XLVDBTKUOok=:uieUkYcZwK4q9n8vP81qod
 EYmZTW1ylQXwOl64ysp0GUjiHmzqORFkgYHipGaplaHsLjjWk0zYM/4KqW+Dm7KNAjVlDaI5H
 LeqSkT4IyyTd6/3BBCisWou3Phuch5IFMx0ub9yhklAXNXc5senV+46M4+QpFkBYLei2FGQAj
 EfGyAW73NZ3Z5MP6C6w6zCmlUGhx9WfSJksup02AJi2exgQ1t54HXnQwH9oKbNwdIQfyvARtd
 5WlXpyNvfovw4kYEDZDj/mvYHiMPOlMSxggYyaakGo7HQ3w/BsrMvg5OtbotV0YKYuJ/AnHxM
 MQ3UhjexPA0oqBs0/L8bTXCMRRLa7kyxOaqyzzyrotnrqCTYizVLnTZFVuZ20uT5CU1Tb+p5k
 QzH+/kC6/DYk8z0DUs2FES5vDXKTQM52Oi0SnBkgh9CeX/IvO4FGEDDvzQONqDeIIwH8lLwML
 9Mgcfyff8ob6//KqFyNxwWR8U5LHKraGtH/zvDT8cM2zdvX4q04nEAwaQe61Hj8o0+TW1/bGR
 3yr6Pr0lAd+7YBkyoGCLR5GeTydji2xUq1buYCe2xwWPXLiLTZqhS2FHyCCGEMwgvm2KCHXA1
 FOZduEK9Rug0Ocr072PsFeBj2bpCKuuY6pmKgd8dcfJPrVXehKn2LpinFHQB/NOYdatXe2PoB
 zCwdNFcYkz2dkaisL65BJvM8cLEjKwuDcY2jUpDRSxFbQTKydjYWa2kZNOsS3QAmKoz0+YiyK
 BnkzuiA9HkwFKGJSkOdFkhQGxt+WLXfZzZTyj+lg1SKbEp4A70wuG0uSaZpsDUW+JGwg37ANT
 O4X1vYhLbAQcLfe6ElNObSroedHj1MUWqqNwp5BVkdD/7VJZn1VUEPzgHLjh8xiMWQznWAmsr
 z4fchYsMpsEET9yrCO/wcWjeN0fJMJx/7ieu+i69KqgKqNQDItQsMx3LiGltzUeRNMwi/iwiP
 b/jlF26tSyHjLvuoeVirvqhVx0sfng9i/qXxQDTrZrjPyMq0E3S74fSc4wEluOKkad1XfLs90
 RhoNHTe/uyBivrUWrZjRX8ign8jhM+fzk0Ymt2QRX367yqISe3v848cALPWj+y56O/dVt/lOk
 O2MEHpzQthuwFSz3ae1Gr7Gon4iwLbYo3kfgCCIrdjrE8G/MDBbQNvcBGXF6/lpRDlU+UIMOc
 10I2vZNdi9uCkFSO9OmnBuTN1H+CeBlvbktVOJJe9v2KOiqlmmL/ZYhabmOAkF04B4sFFnJxP
 5+iDy19Yp9LpMkfS3
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sat, 1 Feb 2020, Jeff King wrote:

> On Fri, Jan 31, 2020 at 01:37:44PM +0100, Johannes Schindelin wrote:
>
> > If my reading is correct, and we want `git diff-files --color` to resp=
ect
> > the `diff.wsErrorHighlight` setting, then this patch fixes that:
> > [...]
> > The bigger question is whether other core developers agree with this? =
And
> > what other `diff.*` settings should be respected by `git diff-files` (=
and
> > of course, `git diff-index`)?
>
> I think you can take my posting of an identical patch elsewhere in the
> thread as a "yes". :)

Thank you ;-)

That answer only applies to the first question, though. The second
question, whether other `diff.*` settings would like to enjoy the same
treatment, is still open for debate...

Thanks,
Dscho
