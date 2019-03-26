Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BE6B20248
	for <e@80x24.org>; Tue, 26 Mar 2019 21:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbfCZVIi (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 17:08:38 -0400
Received: from n1nlsmtp02.prod.ams1.secureserver.net ([188.121.43.194]:52082
        "EHLO n1nlsmtp02.shr.prod.ams1.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727997AbfCZVIi (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 26 Mar 2019 17:08:38 -0400
Received: from n3plvcpnl110358.prod.ams3.secureserver.net ([160.153.140.31])
        by : HOSTING RELAY : with ESMTP
        id 8tIGhLcxa1z7s8tIGhkfh8; Tue, 26 Mar 2019 14:07:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=m-mooga.com
        ; s=default; h=Content-transfer-encoding:Content-type:Mime-version:Message-ID
        :To:From:Subject:Date:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=1qBG0vp1MIyCURqFHTZFHBMuEGtcgZAS9zt7CJkHoUo=; b=pwkEiQa8bCB4Eo2/aq4ekF52wY
        kUxznxO2B9QQtzZGPXfI9lrPde89OIUFgel1hensAbTJMsyqmBhQIEUSs9pGQpZWs8qMyICJS13YK
        OIUJZ3doBWyewX9XlhZPFfNlIVle3r84+tMPxR8DBFQegOpgjYhuVZ7cjpuvLlHMg8vlhB3ttKHD8
        YE2wzA/bzZe3vhQ6GYTuZlR7tZknfeuJOR6udMa9tPI/czp3IZHY0kdwudGb4OJaw6wsvFT35EtQ7
        wbUopVwNlxEw0W62+4n9mmiPy9Zpxil7IjL1djoW0M+TdXw5q/XQk5ekz9htwgJm2jP9BeAToeUBD
        dN7RoF8A==;
Received: from ip5f5be6e2.dynamic.kabel-deutschland.de ([95.91.230.226]:37291 helo=[192.168.178.31])
        by n3plvcpnl110358.prod.ams3.secureserver.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <contact@m-mooga.com>)
        id 1h8tIG-0053Un-3M
        for git@vger.kernel.org; Tue, 26 Mar 2019 14:07:36 -0700
User-Agent: Microsoft-MacOutlook/10.17.0.190309
Date:   Tue, 26 Mar 2019 22:07:19 +0100
Subject: [GSoC] microporject test_path_is_*
From:   Mooga <contact@m-mooga.com>
To:     <git@vger.kernel.org>
Message-ID: <38B8E527-2338-485E-8840-29121F259687@m-mooga.com>
Thread-Topic: [GSoC] microporject test_path_is_*
Mime-version: 1.0
Content-type: text/plain;
        charset="UTF-8"
Content-transfer-encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - n3plvcpnl110358.prod.ams3.secureserver.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m-mooga.com
X-Get-Message-Sender-Via: n3plvcpnl110358.prod.ams3.secureserver.net: authenticated_id: contact@m-mooga.com
X-Authenticated-Sender: n3plvcpnl110358.prod.ams3.secureserver.net: contact@m-mooga.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CMAE-Envelope: MS4wfCVYLNwnVD++23IWuKTbmzcoyIK0+CtGT/0hkAufvqVLYT0pcyEtx8uczXTn3jKFPOrkgCfsa5ISz0KnZeWKgq/GFQuC2FL01fAqy79XrA81nDzZCGDv
 emttX8WUQjo+/8Z21TtrwT8HqDTqWaFq7zmv4B0CzpQ3DedHJTY3AsPPrKG+yMlj7VTC6YtplTa2B78tsl3NDeFsawqx2SjugmE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,=20
I am still a bit confused about the task itself=20

it=E2=80=99s just text replacing for example:=20
t1400-update-ref.sh , line 194 -> `test_path_is_missing`  has to be =E2=80=98test=
_path_is_file=E2=80=99=20

Thanks


