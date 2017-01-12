Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1373C1FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 20:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750806AbdALUvz (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 15:51:55 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:31782 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdALUvx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 15:51:53 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id RmKzcVw2I0KuvRmKzcL0Qd; Thu, 12 Jan 2017 20:51:09 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=dMqb2CaVAAAA:8
 a=NEAV23lmAAAA:8 a=HWn1QvWBVNGUGr_LAgwA:9 a=QEXdDO2ut3YA:10
 a=BO8FYlCJqdJ8HyhGhqgP:22 a=Bn2pgwyD2vrAyMmN8A2t:22
Message-ID: <26CD3D119EDA4327BDC6C599A19311A3@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Omar Qureshi" <omar@omarqureshi.net>, <git@vger.kernel.org>
References: <CA+-cb7TuPd-n-HZO-60cKAysmtTaVMcviC2W+bhxz7hikbY-RA@mail.gmail.com>
Subject: Re: git clone failing when used through bundler on Docker for Windows with a shared volume
Date:   Thu, 12 Jan 2017 20:51:06 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfFPrW6bSx0XP5x6Bbx0P0XuKW+y2GuKIfWI7AhyC0cPUYwR0UmKtNbBg6iHDgq4gR058q6M8xjxT4rj8weB/d5t0JPcq/QYZaMxLFMIJJgDfP8V23eNl
 P7fOBB0VGn+18VOK7rVlTxlOPqL4yYZgPk6mhHhKALNH26UXIirmGEVH+4lNOHhwJANUdKikH27SZfyTC1VZBEEviaLMy0vsDpM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Omar Qureshi" <omar@omarqureshi.net>
> Hi there, I'm not sure this is the best place for this, but, this
> seems to be an issue with Git when used through Docker on Windows when
> there is a shared volume.
>
> The issue is documented at
> https://github.com/bundler/bundler/issues/5322 and I've provided a git

I think this was
7814fbe ("normalize_path_copy(): fix pushing to //server/share/dir on 
Windows", 2016-12-14)

I've added a longer comment to the github issue (didn't have email at the 
time)

> repository that allows you to simulate the issue, for this the
> requirements are Docker for Windows with the Docker client installed
> on WSL as well as docker-compose installed via pip.
>
> Docker for Windows will need to be configured to have a shared drive
>
> Also, it makes no difference if a tag is provided or not
>
--
Philip 

