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
	by dcvr.yhbt.net (Postfix) with ESMTP id C43B21F461
	for <e@80x24.org>; Tue, 25 Jun 2019 09:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfFYJop (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 05:44:45 -0400
Received: from mout.gmx.net ([212.227.17.22]:51019 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfFYJoo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 05:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561455873;
        bh=IcDO87YikpOzt+E2VhULTRr5epnDJhmm8kwS1nMQNh4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jL7dMf4JJBiqY2e2PFkvB9iRymXCvMifbHdzgwreukz0Mjgxs8uols65aCPqjHGBo
         nFR1ekMU2KZaZlalExMbWMId3hyAT1aE9Wn1mWAI3t0bnzktl71sxvdr+dlBx89c1I
         VqcGMk38Bv3HKNpFwHrNVBLNS8FBacENtPM8qVjk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdvmY-1iGPvr1Ft0-00b03h; Tue, 25
 Jun 2019 11:44:33 +0200
Date:   Tue, 25 Jun 2019 11:44:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 01/10] ls-files: add --json to dump the index
In-Reply-To: <20190624130226.17293-2-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906251142580.44@tvgsbejvaqbjf.bet>
References: <20190624130226.17293-1-pclouds@gmail.com> <20190624130226.17293-2-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1597898811-1561455894=:44"
X-Provags-ID: V03:K1:Aj+KR9BckdIqIo5O8PpXOp53Dh9jt/dRJiJ1sDfVUjE/KPO3RW2
 Pva/TNMOs5lmHn07XyyhiVYC+tl75c3Wt0vKeuGk4VwZJ9hxlN1+QTDJkTp+V/DbARXNzcY
 U38Jqg5kRyEHCoeRVRzEdR4HVn157lr8hDJ4J1nZS+CmRrm3NShvthjKkdRMED1KrZ9dYRb
 95bKjqb1bKjEPAQxiqf+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bRf6UPYG0p4=:QmLzAHHCBuuU0UReza6kZr
 8JcW3zqhTQYiLfEdEh79WfulsZRZRascHSPCSIgptoOnYX37lmmkhLjNJPwcst3SN66wBfgka
 44hk905HBq0y/KiOvpWe6kQygoJVBkLiTtumICW5s40chCEVpwHy3BF4UgSzkY3tf++BA50T8
 T/xV/nd5EUzXAO5oYIZDQNq0ElkcGME3q5f6YmY79lhHSsrg16SKhsaYuvFt7mopZ8ZxC8PK9
 oF2E35h9gfaDAch1eLHvrUkChOqg+RYvxefDHaqMwg9pdxIf6I67iYcA763BZj8aQrbuaoRAi
 exHDnX0301ymBqRGwiFgPjHFTv0520xs6hXihE3KL95LwFv/vKkYwKDzBjv8Yc9oWD56n5qR5
 6ew+KQ42X54U0H0c8iLae71aCWA66urI5sHQX0an6fyDVmcp+AiL4Q5cutsXU/wDqFvngEEWo
 N1MaRfieL3MS44LhqXgE9zuNBapWHxzAIyjvouylWxfcHb0D2+hnZ8fOnVd9zAvwOzIKSS8+k
 7BuS+PkR3sAoD2SB3Jrk6HfZbg9klHY0XCygXEkf86UjilSBZgXG3b7CXojouWfVwF/AJLWyq
 u3sGeW08y5G3tNZ9vHwQ0kZ2uswu1eusksqrx8IdLY7EedpjBqXfHvIDbDTPkUsNimwi5PTBQ
 OH+cnfB8McUatj6ieZORoGlwHeHenSMr6bZDChsaUhjQVz1lYXlUhOBtDVvbuJK12P1daVwTW
 RNAKF6LVAmI3DttH2tpsMVr3iyw3Vwk6UOoPoojKf4L1p0gwzL0Ps0xfyJsqUKjkVqHxhFfDE
 pXJkCBFVsh5UFuCWvbGdWyDymx1S5KuIUWAzCwulPpUF7ypg8hZfk8ABkoa9RN0FRP2hRn4GZ
 +25jC3t+aq5VnW890b3rC6/NgaXb0dhGk8ECA0EiqWmmVGtyi4KTR+ZFl0llYWCVi3abjukBC
 SM14CwHN8gxut4z2oNCGQvffHom4o/jDzbl9GiWW6kp+pw5y04Mu6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1597898811-1561455894=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Duy,

On Mon, 24 Jun 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> diff --git a/t/t3011-ls-files-json.sh b/t/t3011-ls-files-json.sh
> new file mode 100755
> index 0000000000..97bcd814be
> --- /dev/null
> +++ b/t/t3011-ls-files-json.sh
> @@ -0,0 +1,44 @@
> +#!/bin/sh
> +
> +test_description=3D'ls-files dumping json'
> +
> +. ./test-lib.sh
> +
> +strip_number() {
> +	for name; do
> +		echo 's/\("'$name'":\) [0-9]\+/\1 <number>/' >>filter.sed

This does not do what you think it does, in Ubuntu Xenial and on macOS:

https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D11408&view=
=3Dms.vss-test-web.build-test-results-tab&runId=3D27736&paneView=3Ddebug&r=
esultId=3D105613

The `\1` is expanded to the ASCII character 001. Therefore your test cases
fail on almost all platforms.

Funnily enough, they pass on Windows...

Ciao,
Johannes

--8323328-1597898811-1561455894=:44--
