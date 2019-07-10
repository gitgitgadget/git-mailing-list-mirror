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
	by dcvr.yhbt.net (Postfix) with ESMTP id F3F2D1F461
	for <e@80x24.org>; Wed, 10 Jul 2019 18:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfGJSv6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 14:51:58 -0400
Received: from mout.gmx.net ([212.227.17.21]:36843 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfGJSv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 14:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562784712;
        bh=g7tayA4hU024U5ebPy19cWHOd5qkAB5XKtcDwnu+1+E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fI7dZtKBs8T0SQcDDkUjcDpiVvj6KX3WklE3lZwmCshZQV5cWsz3Hnr5FBD2nUrqj
         AB3EfvfxKWN+U3xMzMFDqVXM6VwueiYxRE2ED8uU8aQ4WRaUdwLkaDUEh/1K1+oGfZ
         +AgQE3UScsiRmRK6eW5oTyAJOysMmF65+g0/VBko=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MjjCF-1iDiQl2ziV-00lADH; Wed, 10
 Jul 2019 20:51:52 +0200
Date:   Wed, 10 Jul 2019 20:51:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2019, #02; Tue, 9)
In-Reply-To: <xmqq36jeva9e.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907102050100.46@tvgsbejvaqbjf.bet>
References: <xmqq36jeva9e.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nJeWr2NMqmw29/aOPMhjOrTzsUpVakrX5GeLXChupi0DhFhcq8i
 cK3UlKOzQN8uWl0cxCBVGbbVdFavl3KDCI9wa00OLswZBG9+QH6lMQxqcOttJJnK9yYagQH
 1rL3wFZSSUg+D01EA6G2aUNJtGYd6DrBYWhYn4uZEnkdLvGmnvrgpXPQpNjYYh308AWC2ui
 tNJV9G/m1wksOPoUJP0fg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sTAYan53Doc=:zDG8XvUfNqhD9viqf/55zy
 HhIMcWz3T6ZNHnKwjTuTslTONHVYi3gFDYsl/PkpsgCE6zvjbbKMDE2vrINbncbCd4mAWxse/
 LWNAKrcNtEAcIDOpC65PF6vS1MtCfU/gBMNM7JCV0r8+zTy2OaglKioyck6thGJODHR35pQtA
 UXWDeJWBDd80JRmBGkoiBZnn9xj7eNAHpoJhKs3p2TFIyQd+sZwpnlNCpGRTqUzbE+M8U+Q+L
 WcVaJgAKkZb3se+ZKKWCO8+9v/JarEK15hr5zQB0ZdRMbl7D64Y8X7DCunBfMAAfyxeFcDI7n
 eZc+bp8sdthC3gAClZjlmOsqEyL3OjeKwLMSv5sy8wZ/dff2r3XVyyrmVRbrxjzGtE2NTcIVZ
 QZqQd0w4EDpMtdNJKjXPodHRFe+ZmwF6UFVSPJrfgyAAM4Ktp6G87595QcDbDgme+/nW8ytu3
 Rw8yhmJnbhY56PC6zq+LR9/2IFz+z77ONVklYGPD/9YRM+mIy6eN089Ezl0k2W4QhmGPnXqKx
 bp9mHj3lHChcB6NYgahGlQz0OFRvyEOaY1aV/xjk6/OBAFbWkoNifm03mmltnP8w4tfDA4jo6
 2JveGPSL15VKyH1FjCYBWD2q1zX0T9QKSrNvWJDEfEM7YGwYFp8EqNP2rmOWHaFJUukUBAC/c
 5Qp2XXo4TF1DfhS7NVYRfMvQgqGsMnDgBs1CO6HpJMvhxDwBU3sVFPQKk9qHIHhAihFBrRp7J
 28E7Q94gimx+AqpBnQR9lIQSPk+pUV6LP+wGNPWKMiRDGk6LIHn1aKoxTZL9HtGysFPg36XZK
 pni1Ko6b+9tAQB3LW4FTpjJNkKm6YOhmnHxonHf8d8C825eHloZwv6HbfFobOLFzWKqKNFfpS
 PBm+YkAMVy7l8Wl8DZrTPSCLjRuYYmOzBd3Vi+/cqTAbiWOHjrUlE2x/NnJCai6LYfLqqfBxm
 gxqpV+XXOADLwXVuNCiykFr7oLHPkT13drXXZCfzGPP48SW+x495Iq4XybWMUewun2/+hzlYI
 il5Sm6CesP0J8OzsvR3UoRxSUMXH7lI6dfaPQgAfqUjjh0deb9v4cUJ1+6bb8Qa7Bc8yoAbgP
 Xq2tBV1M2T4h8Hs4csXvcIWMgQl5jrMNbPP
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 9 Jul 2019, Junio C Hamano wrote:

> * mt/dir-iterator-updates (2019-06-25) 10 commits
>  - clone: replace strcmp by fspathcmp
>  - clone: use dir-iterator to avoid explicit dir traversal
>  - clone: extract function from copy_or_link_directory
>  - clone: copy hidden paths at local clone
>  - dir-iterator: add flags parameter to dir_iterator_begin
>  - dir-iterator: refactor state machine model
>  - dir-iterator: use warning_errno when possible
>  - dir-iterator: add tests for dir-iterator API
>  - clone: better handle symlinked files at .git/objects/
>  - clone: test for our behavior on odd objects/* content
>
>  Adjust the dir-iterator API and apply it to the local clone
>  optimization codepath.
>
>  Is this ready for 'next'?

I am afraid that still, just like I said in response to the previous
"What's cooking" mail, this is not ready (which is unsurprising, given
that it has not changed): it breaks 1,384 test cases. For details, see
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D11495&view=
=3Dms.vss-test-web.build-test-results-tab

Ciao,
Dscho
