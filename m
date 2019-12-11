Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8B7C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 12:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926A32077B
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 12:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YxfNITu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfLKM5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 07:57:35 -0500
Received: from mout.gmx.net ([212.227.17.22]:39617 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbfLKM5f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 07:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576069050;
        bh=mVyaXE7lxMRn+N2E53BzUqyL00E1+FgwqZOA3KyVAEY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YxfNITu9TA9BENbN65TBZG7xOUO5dmIc7pn6TSkT6tR4RpypvHEusz9OJ2qO8NpGs
         q1JeUZBIVKgUGTfHlH6nn6RdDE+f738A1Tev1/ShEtzVgO4ogXElSxBxfYj76Melcs
         PQqWYhIsPrDX43RG1k9n5gLorygc/6CWYGlGtY6I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOiHf-1iN6G51myV-00QCTe; Wed, 11
 Dec 2019 13:57:30 +0100
Date:   Wed, 11 Dec 2019 13:57:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     KOLANICH <kolan_n@mail.ru>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Could /Documentation/technical/commit-graph.txt be relicensed
 under a permissive license?
In-Reply-To: <8E1DF461-094C-4BBD-9F8A-575A45ED051B@mail.ru>
Message-ID: <nycvar.QRO.7.76.6.1912111353400.46@tvgsbejvaqbjf.bet>
References: <E2770343-BB39-458C-835E-04F0753783C3@mail.ru> <xmqqimmoq6vw.fsf@gitster-ct.c.googlers.com> <70575b23-6adb-a29b-8df8-f9099f86eb0e@gmail.com> <20191210205056.GA14079@coredump.intra.peff.net> <xmqqeexbrffe.fsf@gitster-ct.c.googlers.com>
 <8E1DF461-094C-4BBD-9F8A-575A45ED051B@mail.ru>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Z4C6W7MOHc6OfDZ+9gaMgIzRaVZ5wTpP33lkjt/AUwK9jvnC5sH
 Iao1aVMfPleUCZ81cWwq+Q1MvhKKwb2czQk92y9geuKHJchnQEuWsOyL6ocJvHwhqbKkfBu
 6m3h/XXQGOdCqGayowtUKqhSVC1KjZJt9oFnrBTA9BEoNI+4VtR/A3GYZ6UvcffEH2QUO+G
 TAaNnOF2NZhxem5L0xoUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U3RAKMyRKO0=:FLO/oTZCmVwfUgp1KjHZ2n
 RMDUGKC4SwcMml8FvDECYw23mlynwYll8M+aYDobjs25n9gqN3Mr8x2VuPM/MUvcXX9iVstlZ
 +GtkXqpMjDGMVFvcsI2r8jdzlRK5j8ep/PfiOzsBteBviGKVw5yXna/vAsnIhMS2SuwPVt3i0
 c42QeBDeT/UmV+l+k7bMjolvYPHEW8vF8vZ5wenVlTYgxKKKJ0GrZnAhS+6TPaYi/Fx1/HBaB
 Zp4+6tS0uzZrnM10SQSVsWYVIDLdmm7EJmYLsEW6cJ4d2fSKrQTjZxVdCEc5epLD7mmNH4VYr
 /VqYBwtgJonLP6dEnNzL2QyeASOFHc4AGWxqGRNWb1tXnGVaIbcMXRAbtiA4OuCN/+AlcXtoS
 tVmrFZCqTlw3imfZVB05wdoRau6RvhlNAkgSA2U6u1K5BHkIYhsBPqrW0KZowtMfFnkVBfbsz
 oJN0NFa7m31dIly+0yot5uUyBamgUv8p8g5QsBOjjvsn8JJ4USBJA6IsOfqm/UhxqUSFS2vie
 GjbfLq8bLavc1n7ed5qpdkMi1ipgD1sOydh6WpWsHZ75HN+tVmz+9rbLZwH2DG5Oda71MVo6g
 FojUEOw/mJuGusV6ndLirVPS3dEzUrVGhNF7CuhAVQEalK43b2judaACrLfSZKDfuQ4c7q7eX
 0Dy5snuLjfdFkcUT9tu8op1ECjqrnZAvWHcJ4mTyJn1kIfD3te8hQtZNpIJyM9WqWvRUDvkYE
 k/2EKEgkkZ6zxjrQTFgPkkxC2pnpGYEIIMc3Unm3NrcRg7bvmlUSF5VFNha/X+oOLjFR8TBBn
 psntJoC3cIzvd42chRloectYTP4ok57opSZU7aIzBnyW9fBWcWUts/ymq253QqqgxrmaVqcyg
 BM23jK5EgJ4StvjfXKVEQIrVYM+uKExSxeVG9eiCwD5EmxcmuRj9Wju6VY5nQlArkY+ow7y+8
 2hVjrzm3+/LW9Hq7Xw/FOAiUSAmXj0JQWV0aJm4EXIa0u6YMVrJjT9Csvjg6K+MsemyDFpnm6
 Ft198NnMFdWwhpWHObly/eJiOCnX1dPhFNmpnQ9/Gl4QsTsFro+wUiPMwVo5wWtT2R5KgiPcZ
 86jE1iaDKEz3086aQOiK4St5IfL6a5ZJs+W3LZV9qXSmqttnq4pfsI0pqoHzdRD3H2KlTWi5B
 BRCh0qAjqb8fHC5kB7vpngcUAp9QJ3wB+283UfjsQFB8sjOEzVf9iEj/6U2NAoeMtcQRgcj/K
 zIEri03C6GvRG2yj9RWDKeL4gjSHszTA9iYH61DhDR2R449RxwM0hzntkL34=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 11 Dec 2019, KOLANICH wrote:

> > spend the necessary effort to comply with the license as a waste of ti=
me.
>
> Necessity to treat so called free software with a technique invented to
> deal with closed-source proprietary software by companies enjoying their
> walled gardens and vigorously protecting their walls integrity in courts
> is a clear sign that there is something wrong with the software. I don't
> beleive that free open-source software should to work this way.

Seeing as the obvious effect of such a hostile statement can only be less
cooperation, in particular when replying directly to a mail where the Git
maintainer pointed out that there is hardly any benefit to the Git project
in addressing complaints raised in a combative manner, I have to wonder
whether you realize that you just sabotaged the process where quite a few
people were ready to help you to get what you desire?

Puzzled,
Johannes
