Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D5FC4363C
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 20:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A518123A59
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 20:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="d5daBjco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgIUUyN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 16:54:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:39561 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbgIUUyL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 16:54:11 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 16:54:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600721649;
        bh=Q5quJmUdyVor2i/TmLGNCLbOkbNbZzKHTgEQ+hr4yws=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=d5daBjcoDWDjVhCIjfdkoICaL2wU54Yx1na8u9Tb4nz0ELejzNd0BbBm7m/9eJ6S5
         jrOso5N1LhnrgJZCpYxCM9ruYgoHENUUPLFVcyJ/1pwxR85GT6K6F6kn83NkobCcuf
         WInuiXmo9r6PAWIsIcGxEc/7ek5AFhx36uXaGUro=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.212.93]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9dsb-1kYiGB3sc1-015WUp; Mon, 21
 Sep 2020 22:49:03 +0200
Date:   Sun, 20 Sep 2020 17:34:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/5] t/test-terminal: avoid non-inclusive language
In-Reply-To: <xmqqo8m5v2g9.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009201733510.5061@tvgsbejvaqbjf.bet>
References: <pull.734.git.1600279853.gitgitgadget@gmail.com> <3b4ae48d4a3a7e2d6aae259ead19b6643d2533e8.1600279853.git.gitgitgadget@gmail.com> <xmqqft7hwhyd.fsf@gitster.c.googlers.com> <xmqqo8m5v2g9.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZxD4+PvSUn9w0FecJssRjzCIRUvPhPiXxm/l/G0KWPiJzDuHb72
 zmK6kpLDAngezH/ofXSfQC1R0WyyRQ92g662OwmlFjKaHKeIdreJRw9C2BjEjK32Jhc73xz
 bnKK5HAvJxXeO5mBpaQgd2YJQzpF47j74xxORSVpPWKDFJnQ9xBxXJx8/SavqwR7QtkUpWd
 18PPl1TL6cEzr7SV6UAqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A6gUrSP6klc=:AV5fobjXepdUDxXAnBF6Sd
 tBYs9CYyus47vQVavGP1IltLSuXGOErSbdErJuFhivBOIn0YkpDthbFaD6kSFK+6s4+OeBYCX
 FJnQQ5lpGGmuKpMo74Ur64L0Mh9ygrrIBVTbS7B2wZ3gu4g1zkoqL+TeMk/MaZd+0XiCfVI3q
 2lfNvG+ukXlOG28gz443FFaxCKZ/HEhpVHYn70C4dgpOuG6iuC4C9Q74KZar3FXUrA0BpK8fN
 KyEdkTsfYHxy04WWdVh9+xmp8qR+9j36cKcbojV0pD7RZyehScesAoBO7jW8eAFMmhFOaUGNd
 u3tOc7YGnzq2hb3CxnmUG2Rzt0KAPPJlQcAUcSiDA2S3WVCRk1Yz2apDT6POtj/KHfZuwt5lJ
 UTP/K3cxLNjvSQRjUi/SH+v+IyVaCTAKm/MTUNaxYCbhCCw9YYzhb42uPop1wV5BASXuJO654
 5EBzSXr5JCkshN5XL6wz1MPvf+vjW5bKYfFDqHEqcs0l++fadmJ/dCs3x6wC//Z+oQmJwHtd+
 QowlLu3tMyU6kVYPGWzDrl/CymDXz2cERrt2K9jT8pv+9C1+CQt/fAiYIplUgGZb7N07jt7zv
 czPSEgs0TO/nXs/QpEq08pC0o7PBWgBY2HVMkg4C4eELljUbRDtvP7eiKd9EbpFXujkBBqGAg
 JOgb4gr5Nb689iQ3gQu9mm7IK4t3S1oFZe5PHESRRT6LAu4FVFeAPzW5rGHAI3XHi/LE6wcW0
 c/3UMf450PNIzsKZ9GHxGZam4Ba62MNmqjBVpB80qj7f3UmMcXHeZhl987cndg+POyG5qJxGF
 vDPoPo1GAGxfHMnVwKGaBScxJAuOuBtZ52e3tBvO39iAd12GDlsBV3oWS7lknMJIY+96yveI4
 vdj0VDfrUw3g6TjyebscgY71jdgu0xQz6Qa+Jx7dt8XWzEak/4+GW8+rhqdoLdBqeNiL/SFvW
 e+n21ptGMKMsGUhRvDUlp61Bl4q9PvmNUOaJbifpquYqy5stAOaeaXgd5x07sp+iV5MUiIWvH
 wU4CaWMSIcwkrq6FbKbQXDM79wtduIkaM1RvMEtyo60GNsfpAjMTDO5R1d5pSCP09Hd134On9
 wX4vTp+YjYBF25o/6VAh47jMo60+5tktW0vdV1bEMa3XisyrmeV+GwsrGCXJErgwjQw2oqxOu
 Kz/cwRSEFyO020I0LR48YvTM282UkecQKwrGBiDWSqPK5UdaGlubWgru7WA1S2tEBUdk9yiLH
 yIO498OtiCWC6Rx+c7Wyrcnu22TzID/phtOyBTQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 16 Sep 2020, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> >
> >> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >>
> >> In the ongoing effort to make the Git project a more inclusive place,
> >> let's try to avoid names like "master" where possible.
> >
> > The two sides of a PTY are called 'master' and 'slave', and I
> > understand there is a push to move away from these words, but
> > calling one side with an invented name that is used by nobody else
> > in the context of talking about PTY, while keeping the word used to
> > call the other side, would lead to confusion.
> >
> > A better change is to drop "master_" altogether without replacing
> > the word with anything, and call them just "input", "output" and
> > "error".
>
> If we really want to use a replacement word for 'master' instead of
> just dropping, I may be inclined to suggest 'parent', in the hope
> that PTY implementors will start following what Python folks are
> doing, at which time they will give us a synonym for 'slave' method
> called 'child' we can use.

Good idea!

Thanks,
Dscho
