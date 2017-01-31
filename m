Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B7871F6BD
	for <e@80x24.org>; Tue, 31 Jan 2017 20:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbdAaU2u convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 31 Jan 2017 15:28:50 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:7556 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbdAaU2r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 15:28:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 50BB81E307A;
        Tue, 31 Jan 2017 21:28:44 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 80RpCnpcmo_E; Tue, 31 Jan 2017 21:28:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 0EDEC1E3080;
        Tue, 31 Jan 2017 21:28:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rXwB1U_QNGlC; Tue, 31 Jan 2017 21:28:43 +0100 (CET)
Received: from [192.168.178.30] (aftr-185-17-206-94.dynamic.mnet-online.de [185.17.206.94])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id BC40E1E307A;
        Tue, 31 Jan 2017 21:28:43 +0100 (CET)
Subject: Re: [PATCH v3 2/3] refs: add option core.logAllRefUpdates = always
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <xmqqvat11k1i.fsf@gitster.mtv.corp.google.com>
 <20170127100948.29408-1-cornelius.weig@tngtech.com>
 <20170127100948.29408-2-cornelius.weig@tngtech.com>
 <xmqq37g0us5p.fsf@gitster.mtv.corp.google.com>
 <20170130233702.o6naszpz32juf5gt@sigill.intra.peff.net>
 <xmqqbmunrwbf.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <ce8f90a6-d719-63c7-95d0-b2538270e263@tngtech.com>
Date:   Tue, 31 Jan 2017 21:28:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmunrwbf.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/31/2017 06:08 PM, Junio C Hamano wrote:
> I think it is probably a good idea to document the behaviour
> (i.e. "--no-create" single-shot from the command line is ignored).
> I am not sure we should error out, though, in order to "disallow"
> it---a documented silent no-op may be sufficient.

Yes, maybe abort on seeing "--no-create-reflog" is a too drastic
measure. I presume that the best place to have the documentation would
be to print a warning when seeing the ignored argument?

Or did you just have man pages and code comment in mind?

Cheers,
  Cornelius
