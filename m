Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35329C433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 21:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbiFHV4H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 17:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiFHV4B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 17:56:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1017DA206A
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 14:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654725331;
        bh=80g6PYER3vaNt5+mVcRdoc0vEueKhUy+PhRAWN5GQRI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WBFcR90Y25fqoSwEDveQ1adjjoHMPwgp5+jIQccPEHY9Td0c1Z7cTsApkK25NEzRh
         8XmR/ra4473qfR56ByfazF0ehGg9xEUquvvK1nYyufIwlF6TwqkvK0yHBokj2YD4n0
         Y/jdsu4f7sFWVA7jAxA7rgD3GWE2d7qkaMUGiMso=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.206.165] ([213.196.213.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2mFi-1ncC9X2ujs-0132ru; Wed, 08
 Jun 2022 23:55:31 +0200
Date:   Wed, 8 Jun 2022 23:55:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>, congdanhqx@gmail.com,
        dyroneteng@gmail.com, martin.agren@gmail.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2] ls-tree: test for the regression in 9c4d58ff2c3
In-Reply-To: <patch-v2-1.1-f2beb02dd29-20220603T102148Z-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2206082352520.349@tvgsbejvaqbjf.bet>
References: <patch-1.1-0fdfec624eb-20220531T171908Z-avarab@gmail.com> <patch-v2-1.1-f2beb02dd29-20220603T102148Z-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-714988630-1654725332=:349"
X-Provags-ID: V03:K1:c8x/2zxSlsR2JH8K/MqNigg7rcXJGAqEZUaOWwtHe8hD6mc+YoV
 pKMIn2+NECSsIUxg+4gPv+IUUdWSOS6LCYaDvuUe7mVQbbxY935UNvkzLjWpimCVu0YtVcF
 5SIwQlxfjh9bo/DRc70iwX/nnPKpaX1G7TUM/W8I/uJUq3aC/dcQEBgNqBA9EwmBXgGsWn4
 QoHBMYweE4mwoH3+cOEhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TNRZTesY08s=:FsPSqKl4ZeUgEcIBPdDEyf
 8P2/chpu+A0F+IojNob7XkXfM69KHiJjHZTTgjgSeKMHjXg0R879Un3WReJkhlFjUA/yxpltw
 3F0UUecJQ9p/a8AYHTqTxbzyzHEPPxOvcBxRaFs8t/5s/apkUB0oGosArOyHRnGYaIGHsGefB
 tUmq7Ue5+kDvYVfn+gjKHefZusLHiXMS4Ls8PsXYEQGQjnNdqG+hCIDwKUBEcNxuDwQBRnQ4v
 8seKkuIWxTYmEx/Rzf+GQb6dCtky6Q/a/HvMs2IsuAtYdJDabtF3nd8vRpyviV/iMnG9GRAiU
 P73urLOgQYTK6lqztq8OeCjoC9ST6JffHctxJpBQtKN8m34FrdaLmqFOsL+rKjjkfMLQ6QRDV
 1oigV42fMq/PyZ5ufK2MHbP317i1eyN2w1A/th1/PpTCn11JbjQQvM8BEbzufdIJohQxtkCvl
 HIjuwuWiXgAaOutsOtlqFcK1tSjSRh4uIMV+xGDoRqYc5GoMRPgasj24lFr5U6E/cJ3l8vi1W
 rozMBUo47WTgjsLqn2n3ZNNyb7xLrMI6sp4hbH9ijwfJXltW4IrKqbRqd0+f5E6u7HlqaJodk
 OK5iYwgZxMfBrbGrckTxEQoxtvLnSe3YE2UgNo8+5xe3PEnhQeclpqxQIZkio6I7W1hUxnqsm
 6hg48sKBjtSJMvPSEiOqCT++lwQl5JZDsBmpyutEycav+QheTIlAfCALVbDsGXmAgFRY6smOU
 DYQa6H+Q1KVU+S98tJaGKnvRNZDfYt38W7KE557nEqqQA4zKlrfgq+KUksm88+bC9JkSnjWy6
 k9KdT6A4Y2wUijaKh9iISQXsyArQB2kJ05kuv9NTkvlxfgAiIki153iO0sp1eRxOQKaY0CoN9
 7rSe3zsEHEj4hCOOFaOASs2QK8Nt89q30GvfCIBpNY8XeKV/joJIcOX99mCA5Q+H7q6cIPcOy
 tfUwT8JPoF/ztoAmLwAAO2Z9TQ1A3qHPObliPv/L3U47Xag1WEPifN2URm9kIFP/zG9qK7PKB
 DVYF2ULwgBiy1sj4DZBg8pocbdlcQ2H+KyNGz7YCo0Zk9akd2fy3oRCg0I3z3mY4sxUQYzAlM
 hE18xVnDiLayyKI/urQP0trlv9Z/ja/DByiarGwby50BqVm4tMXloPjdMmmyfuZbT0TFv87xV
 SuzTc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-714988630-1654725332=:349
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Fri, 3 Jun 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Range-diff against v1:
> 1:  0fdfec624eb ! 1:  f2beb02dd29 ls-tree: test for the regression in 9c=
4d58ff2c3
>     @@ t/t3105-ls-tree-output.sh (new)
>      +'
>      +
>      +test_ls_tree_format_mode_output () {
>     -+	local opts=3D$1 &&
>     ++	local opts=3D"$1" &&

This is a minimal fix for the CI failure I reported, but the hefty
addition of a dozen or so test cases (with the corresponding time penalty
for everybody who wishes to run the test suite) is still there, which
seems quite excessive.

Ciao,
Johannes

--8323328-714988630-1654725332=:349--
