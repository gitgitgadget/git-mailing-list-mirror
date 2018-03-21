Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5270C1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 22:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753982AbeCUWeA (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 18:34:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:50931 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753761AbeCUWd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 18:33:59 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ld0E0-1eGg3k2wS0-00i9e1; Wed, 21
 Mar 2018 23:33:52 +0100
Date:   Wed, 21 Mar 2018 23:33:32 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Joseph Strauss <josephst@bhphoto.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Bug With git rebase -p
In-Reply-To: <44d0049acaf24e409849f929d7ae4888@EXMBX02B.bhphotovideo.local>
Message-ID: <nycvar.QRO.7.76.6.1803212332320.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <9a1c2c55ff7f412f8830dbdc4bc033bc@EXMBX02B.bhphotovideo.local> <xmqqlgenu6qj.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803201551480.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <44d0049acaf24e409849f929d7ae4888@EXMBX02B.bhphotovideo.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bjXUe3dadqUa61zGOASLIjetuoBgqzdquczDriE/XuKUxNt8nKe
 UnA1nAHj1gOCCo2vdQBwpDA7z4uNS7qBP7aZM4Wnmjh0jWPLHYQkZh0lbputZQYCnDFu3Q6
 P8ePvQxiT8G7v7osSh0zLnd+ljBwia04dQ3Xndo7QwapncMeBertbobsCmtOX7PJPlEbNre
 Ukjh8BSp3DQccEkSli9hQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Z3wtv+Ulddk=:2H+c2rgHe7zlGlxis7+1NY
 Bd3NIpQOPa8gMXX9VO1y5m1mfaT36NnQJuWzLaOfDL96XPSbtkaBGAr7ULRFbE/bGHKPR5dOn
 E5+qjbPNkpM/zuk0ycoqCi59QaXcD9jXwJZbtmmr8aUjb4uMunENb/s9cQ6np4wPFs//ECzSi
 abmDOZ2zZabILkiKQzmByeu2RI8NX4PeEmYOqx2c1aomicnUauEVE1TvmPpdebkZa/w0RCAPT
 9ffLQvSTI4t/2cMYocdLvk5pUu8bDDzyjoeySu/klleXz+oogEN35k7DduaXEnI8M4wIpVWsY
 WkLxDc7JaCcku7TzaFeKVj7XLiyOFPovGxb1YZU9qlnGqgJXJPZngtpsMl3SGXpDcJ1NaN+Hl
 m2gs2dIXdgJKxJ+tRX2VW4BO2cEcnU8qCJLE2BAgl3yMfWXfaROMu7yA6WAthlmkv/NLE94No
 IAaxhqQngDjF+FaM2g8OzrO1CAa/YjnHMdin58xOPYZeUULFECIcjNx5vu2Co8hNKAvgp9GcU
 N94v+7ljt5Y3dTow1kxVh4ybi3TKykAlRfY29iDkYUQ3yO30QSYbMiN3wbvqoaNTsnqlOQW++
 +B8yaOAQk+DFeVBnhBVtiG3vEMnhOYl5UDrBxEdGZ4xyDFGjpNbVuZkZKalhLQRZttFfd4glT
 iifU77HT5Ah9ENKc8Z0j6vPPE4+Wj8s3u9BYF6nJRsR84L5dWDbYKcoC6o0gF0wcqG7vDsjgA
 AK/vWNj2yEXtx+E4Gkqp0paG2BOkX/ugNm7ZcjFh95aJ48w5qBw0WNsaT7eqXoemoxU9Hn/z5
 AQkeBxQL+6CpIrmd587y4Eg1tEZETR76yL/HUrl6JTh9q2MlKg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joseph,

On Tue, 20 Mar 2018, Joseph Strauss wrote:

> Perfect. Thank you.

You are welcome.

I am puzzled, though... does your message mean that you tested the Git for
Windows v2.17.0-rc0 installer and it did fix your problem? Or do you
simply assume that it does fix your problem because Junio & I expect it to
fix your problem?

Ciao,
Johannes
