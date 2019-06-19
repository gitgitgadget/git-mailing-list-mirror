Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D9CA1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfFSVhL (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:37:11 -0400
Received: from mail.farhan.codes ([155.138.165.43]:61910 "EHLO
        mail.farhan.codes" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfFSVhL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:37:11 -0400
Received: from mail.farhan.codes (rainloop [172.16.0.4])
        by mail.farhan.codes (Postfix) with ESMTPSA id 3CE22FD05
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 17:37:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=farhan.codes; s=mail;
        t=1560980229; bh=yAFYC9XSto57VAC3QQpsBs5vgi1dl6m1Wy4Asey4ilU=;
        h=Date:From:Subject:To;
        b=QSdxHFMV2q4grWw74xMa0fPeaYA3kmmlKCswJcgWEqbAm06MfNkTKkQTO9KFIxUSk
         gpSzZOL8/PwmMjRqT75VM6yFmSu6vp8gsxexxqq+d3RgTJ6IlluILSXwLzpJGQANMF
         xLBgzN5KvAVRwYEVXaTFT0rIUO89Qtw4XZZc8MFM=
MIME-Version: 1.0
Date:   Wed, 19 Jun 2019 21:37:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.1
From:   "Farhan Khan" <farhan@farhan.codes>
Message-ID: <d6baf00c68fa166601c2beb74cd2040b@farhan.codes>
Subject: Understanding DIRC section of .git/index
To:     git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,=0A=0AI am trying to understand how the DIRC section works, specif=
ically the "index entry" section. Can someone point to where in the code =
index files are generated? I am having trouble locating the exact place.=
=0A=0AThe documentation (Documentation/technical/index-format.txt) sugges=
ts that the code does the equivalent of stat() a file, then write the dat=
a into the index file. Is this accurate? Is there any htonl() bit rearran=
gement? What about for the mode or flags?=0A=0AThanks,=0A=0A---=0AFarhan =
Khan=0APGP Fingerprint: 1312 89CE 663E 1EB2 179C  1C83 C41D 2281 F8DA C0D=
E
