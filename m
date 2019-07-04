Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0B891F461
	for <e@80x24.org>; Thu,  4 Jul 2019 09:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfGDJ0X (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 05:26:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:54015 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727204AbfGDJ0W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 05:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562232376;
        bh=bZoAG1xf543Jd69nNLdYU+G7z2k98FB+MJdEj+6Rfso=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bay0RAQojUk4dN+Vy4qgodKsk/c7eBXZYJT+B73pMXjSygs45+Ov7Ut3cyT/sIOG1
         53mz0C8zE2IIHW8MDYL0RkhiIsmyY8CNUeT58o285NTtFvf6Rd+JMFUvCifRGwy2IN
         cr0XpmKNsjP09kcpDQ85tzZjODW+WoYGepNbiYNo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtOGU-1iWoIo0sjG-00unMz; Thu, 04
 Jul 2019 11:26:16 +0200
Date:   Thu, 4 Jul 2019 11:26:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: kb/windows-force-utf8, was Re: What's cooking in git.git (Jul 2019,
 #01; Wed, 3)
In-Reply-To: <xmqqpnmqzrbg.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907041125410.44@tvgsbejvaqbjf.bet>
References: <xmqqpnmqzrbg.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SSPin99DnNABatKjtFT34jXwMmdZ5yUnh0NAf2P/Utk/y+BFHFs
 OQPnANZaPZswVIaeafhjQ+2fTh2/C9OZJHT1ka4AaH0d1D/HoJpfaO5sfKnTGE/5SEpywJ3
 BowAzHq+WXCdGf4MlXLS3di+nnZOyFdC/NchTShe+Ry9mqTJgPifwsYuFTHZQzSYsUX5eKn
 R5FMg7qDmNugx3yxASJog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DyTEKxdT2rM=:g47mMISqgEc4gD2RLv3TXY
 KdJNE4wWyb/xDrR85gx+lA7nyWL3urjXtcmRp7DA0Gp8rwNXYoP0Heg+BG38Z8vuqFL3+1VSJ
 u0CGzdFO7hScOpcqXo478vlMCdc72z9RxnV/lREnbgDSd7VEAgFfKCL3zDGgrwhHQRXSUHRN5
 9V9ClhSNTMTm0PYWolWQyjWBtB4VzPx6jkYZfXXHvyl75vrxI/n6CsXzDvGLVHvB6WLpczlvR
 3w5UTt7yNwUdBTR3XUQcvuML2eYd6clKEqPaZektIx2Edfh49VI4fwjh84cMaGZZhb/hFMUUO
 5csQpGxb34N2OUaGMc+q+fWKu7Xw06IW0a6+Nx7oi/nDjXsM1rMfiZIddjyID07MqZUwod6an
 MUJ6VZ+tX87K2N/3fSJgxCBgSWXXTz+9UDWZTbfPxYMPHebXPtXtW9Fn93ResXhHvQRrSV29T
 FWuouiXw9KsKdmACyKAp8Y2svIG7LsE6i8QVBOCShUd/8PRuGpXFcoLP1rePRIKn3FV56XfR3
 7FSfN300WKETe2bmJYdECOa/LeaQnp9l6CyGVeK5FyuHe+wl9dZiFJ+A2UVLWOYFsjkLG/lcX
 qT4G6Kx2U5rPduxfbsTf3nqzyhwt8SeSlMf4dhfCXxm2VtGnTx96Lo5YM1RjqxRl3sQ4J+W6G
 EBSK9SRz0u3QT9lseetJKrX3cUdZtsy6PJ5ZLTYrRdFkHqUjmZv+jKSlf5PARDe49rInqqOXa
 xCn/IFniOxplNTn6KzU2EHl/JvjvtwfxtQf8w315PpZb2P6tL/qSGzpmZpjg+5y3jy5+NU3lQ
 F9d9kffoorxg8Gnho5GKOgwkWt8RhjmquYp5/bkYf+iS6OxvDtH/fdwrPZSKhUoDZDe0f/2bd
 jYjbHhmKB/y2f5ikCVQSHlT/RfiFtlxwoVZbdwF16wtlHjnxE1kcccClRJFScq35i11Ug8Emf
 244d10WmnWc6kjcdO5Ad6P7GqAagJABRfRIsHf1oxRDM0SIswWQTFRyfox0Omhl9bBhsgpCOG
 Wk8rf0ntTCOxbKFGzEpFIEu0ebjIDaVJr5kiN5kqQujx7sVxqM6jotfZzlIo/lmkvP/2Eh2Dj
 IHu7xjgV8Rvmx3vPvv5yLm/zpujq3EWTfzv
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 3 Jul 2019, Junio C Hamano wrote:

> * kb/windows-force-utf8 (2019-06-27) 1 commit
>  - gettext: always use UTF-8 on native Windows
>
>  Windows update.
>
>  On hold.
>  cf. <nycvar.QRO.7.76.6.1907031321270.44@tvgsbejvaqbjf.bet>

I submitted v2 in
https://public-inbox.org/git/pull.217.v2.git.gitgitgadget@gmail.com which
should address the issue.

Ciao,
Dscho
