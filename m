Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39B6C433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 21:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB8820684
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 21:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbhAVVcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 16:32:53 -0500
Received: from mail2.pdinc.us ([67.90.184.28]:59212 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730978AbhAVUJq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 15:09:46 -0500
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 10MK8xbM017544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 15:08:59 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 10MK8xbM017544
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1611346139; bh=ISnV/240N47bgc+XD3ZzDJ+P2/lcRr3QrGjw+/lV100=;
        h=From:To:Subject:Date:From;
        b=ElBf5O99iOFCM8OrJbd1WBPithhaNN3g7SbFCnTfGCNIEs3Xx/S78sFnN6I5n8ZCy
         T+tv10YAfhQMooPeCtIhpumD998mRJK92Ve7By2hLnnwiHiL9bRduNclzAdT3OPfrb
         ch6Zba71MhO16aiYnasLi8W24yzPDlENn/FFMwt51s9do8NhdTRU0hiPBU64tphn3t
         Y7/fA5bGXpMSTfOAVLRZyomgS1lta8OBr0+o9k1coI1H/e8Kvpw2/QOKnj+XPRHEop
         ezLKF6Ov7QOWq7BRDZEc8fd6CrgWqiP81dTVm3Aoadu5YJz69FIdwpSfl1hK6k5HcP
         jDYFyl3YUz0tw==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Subject: git archive setting user and group
Date:   Fri, 22 Jan 2021 15:09:10 -0500
Organization: PD Inc
Message-ID: <040201d6f0fa$724800e0$56d802a0$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adbw+ga/cq7+kMv8T5qOfuTIANVdQA==
Content-Language: en-us
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am about to make a release for logwatch tonight. Historically the =
files are owned by logwatch in the tgz file. When I use git archive it =
is owned by uid 0, is there an option to set the uid/uname, gid/gname =
owner of the files?

--
Jason Pyeron  | Architect
PD Inc        |
10 w 24th St  |
Baltimore, MD |
=20
.mil: jason.j.pyeron.ctr@mail.mil
.com: jpyeron@pdinc.us
tel : 202-741-9397



