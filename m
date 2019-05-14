Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0B391F461
	for <e@80x24.org>; Tue, 14 May 2019 09:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfENJyt (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 05:54:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:36257 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbfENJys (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 05:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557827682;
        bh=kUJWgCJF7eSpN5hPieQgtEA7mBGb548IdXsE4CGzH1M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NEkc2SzUKtF6i8aPGrY0kWgUGSMlSvJJCMnGhppgwbNwi/OiCS/gBhtxuyOCPT5VA
         lR4fHXaITAL9N19SjRdZRqSCuWRU8IQ0k6YV8MlLV0gfA9yt4skIsUPMGYwi/Ec3As
         isflLZ75pqaYHWuZPMJzk7achi/YKywF+CBsqxEk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MORAa-1h2u3Y2IPO-00Pwqb; Tue, 14
 May 2019 11:54:42 +0200
Date:   Tue, 14 May 2019 11:54:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/difftool-no-index, was Re: What's cooking in git.git (May 2019,
 #02; Tue, 14)
In-Reply-To: <xmqqa7fqbahj.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1905141153150.44@tvgsbejvaqbjf.bet>
References: <xmqqa7fqbahj.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nvfUDdA3V3qTNOox9gGikeLmTig1Fds/RSOSN/sanEg4eQIvtfs
 4hqbRLVSf5pUjRyfW4UC6U6vw3NrsaYLSYWrgtY9UxlksnG1ugI6F5lySzotEehqEuUt6cd
 NKA+vhtJFiXCUhE0rTz3ZjzUU8acc3ULThXQY3DzMERnADqxZQRm0hYzTGJ52tbxtkepCjF
 IIg3Q/mmIfDH4fnGJQkqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M2EJi/dWXbQ=:UAVgW99m5DyCkPDrnEEGjN
 0Hy5nKbWWL3m6F1KDGoeO27nPGrPLvwD3BCdbKP96qknSFiQdDWdlkkwKSwxum6Zc8YI9xI42
 YrOdsz2Rsoc5emLPjkBNAsBOw31dJbMFXeVwXh4a7dFrhlpjffrC1OkjVtLiH4gmM+xKy0W2f
 yyQT4HtD0OXJNSxn4WIHxPHjk/pumN13En9vSzMdlnz/1riUKJsU2jpXubt55/eumNpDSOoqM
 g7Q+mjyVgoTbD/xPtTnywq+n1OFZLzX6gkeHAOdFariCH7JhdlNQQBuz08z1H7EqcqfqjCcKR
 TvvTHUg1gG3UMuaU9j4TbOwSmxCWDGQdWY6v8cL/FIDRxSx1txwUcXNs/476jhAZfZiK8bWuX
 PZDNB5imsfYiqcd/Hx5CtvvKoYpkWVA467zptFwmVUOwOt99/xAcFtETBhEpTUWXx4qkh7bwl
 FlBqWpJ3CdtjdvVYeZE7/TI9Ln96qr0CojHIwhNYek2z0tGXiKxMoBn/+BqbCNZreiLoUG4Qr
 TvL5mkj0+g5pI/I07q3oYYuB+wgpyf8uLq2pFv4YPFRLuFxW3vJItk5BU/l5GQt8zJzq2jBr6
 xfgDKW2icnJ8m8E2ft71y5BRTZmaoPmCz+xPvy5Cpkky1rosa2W2p6TT21jpifjBpz1psCOWx
 dWVqBfZBCkpgNyLLnwR0DnQEhAciRjQz2vKQ8IAvpRti7jcSwkcXMyvP3hkeR6MX5MoPa/ph7
 eNhSJavV3Sh08aqmBoOliNGuzLwCsh/nsJ52i9iiT8s150lN0QwcTPwsqVqXvrYzfz3XmC42k
 Tlqc0ZeC0Ca76IpBoCI7GAKSaw4dUpgUdREOHb+Nrh13p+cZ9FqPUvCDp9C9rN08fle1XnfeP
 e9ZhwF0nt6wvxWLE+LF3sPCTqIb+AGF+W8Ia3rj8qGsUcllLCX96/Ea84cgy1SB5Av+o+PEe2
 AUdAwp7MKig==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 14 May 2019, Junio C Hamano wrote:

> * js/difftool-no-index (2019-05-09) 1 commit
>  - difftool --no-index: error out on --dir-diff (and don't crash)
>
>  The "--dir-diff" mode of "git difftool" is not useful in "--no-index"
>  mode; they are now explicitly marked as mutually incompatible.
>
>  Will merge to 'next'.

Seeing as the following is a part of v2.22.0-rc0's release notes:

	 * "git difftool" can now run outside a repository.

maybe we could get this to `master` instead of `next`?

Thanks,
Dscho
