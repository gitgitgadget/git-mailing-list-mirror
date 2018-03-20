Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E5EA1F404
	for <e@80x24.org>; Tue, 20 Mar 2018 18:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbeCTSpC (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 14:45:02 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:19528 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751843AbeCTSpC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 14:45:02 -0400
Received: from [192.168.2.201] ([92.22.3.164])
        by smtp.talktalk.net with SMTP
        id yMFnepO4SC0WbyMFoev4ec; Tue, 20 Mar 2018 18:45:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521571500;
        bh=4+shk2EMwU/CYYY58WsTStkD+FcaIjSWVLPkYWymE+Q=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=nMr6eXsD7w10bnjNzIUvZCnpgBqJVL6iXVYPDJdOqiGymKsHEMLK4LZG/GUOCXmah
         uNULRyP7pZWnYbH2e5Er727g6fwUibVlbZenQIqSf2A8m+3FXv3lEfe0y4GAecg5s2
         jIp7V/5hT4rF3bkoR3as0CIBGsmE4MKu2trA2FKY=
X-Originating-IP: [92.22.3.164]
X-Spam: 0
X-OAuthority: v=2.3 cv=Q+T8Hb+a c=1 sm=1 tr=0 a=8UrjQVoXl1ilnsKy4/PEMg==:117
 a=8UrjQVoXl1ilnsKy4/PEMg==:17 a=IkcTkHD0fZMA:10 a=PoFBXdE02otVkl7QMFwA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/3] rebase --keep-empty: always use interactive rebase
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20180314111127.14217-1-phillip.wood@talktalk.net>
 <20180320111057.23862-1-phillip.wood@talktalk.net>
 <20180320111057.23862-4-phillip.wood@talktalk.net>
 <nycvar.QRO.7.76.6.1803201707560.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <d1e9e836-5048-5d69-2f87-b1a4b341965f@talktalk.net>
Date:   Tue, 20 Mar 2018 18:44:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1803201707560.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIAhpCXr2KPW/n63OjLHHVGvm67iiwA640LlKbFwKby1u3XMViDLFX5hj9k+Hko1Xh26+EJ4zS0UG6jNA4KkmSllUkG0e0T9sA4O/EXyCFs4yuP45YGm
 G/KynZ10JVmhopxNIc1cuuUEutW4PoPdp+iIk2kNzaZDqx2dd0BrDuuQVKAdelI9jCQWYNVil1zO3fNuTISsu5JHvXI/P1gQRrMcfPgtQnjXn27nxepy+Ktp
 WIzn9h2/LI8IcANtpLeG+kUeWZvOyactJ2DhvNi8jfbQhZtnHQ/GcEHy7Imbvu3N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/03/18 16:08, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Tue, 20 Mar 2018, Phillip Wood wrote:
> 
>>  git-rebase--am.sh                 | 79 ++++++++++++++++-----------------------
> 
> Those are a lot of changes, but pretty much all of it is a change in
> indentation.

Yes it's a big diff for what is really just deleting a few lines.

> All three patches look good to me.

That's good, thanks for looking at these and the other ones

Best Wishes

Phillip

