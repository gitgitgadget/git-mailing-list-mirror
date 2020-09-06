Return-Path: <SRS0=Ralj=CP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A2BC43461
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 21:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2680B20C09
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 21:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="AjvfIsy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgIFVAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 17:00:04 -0400
Received: from avasout04.plus.net ([212.159.14.19]:48931 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIFVAC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 17:00:02 -0400
Received: from [10.0.2.15] ([195.213.6.112])
        by smtp with ESMTPA
        id F1lXkqPT3rXCcF1lYkzKio; Sun, 06 Sep 2020 22:00:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1599426000; bh=T1JTZy4bw7OqRrdv0KhKtTCpsOGG0cJ17UhUOk6Krp4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AjvfIsy7qwLIdlobKflfVP7y8+1p9QlR9JmLbeW4SnAyJ+oUiLw/HAiT1zKQtdxVD
         L613P1XnwlXHJwVF0mZGlEvu/f7FLPzt9XVDaiIO8smpWsTALFxLnJMemROSxscmlK
         zJUtXOF067rnFj+DoOg/D32KMaRitht9ltKSwEcWtH7grYcWDHAWtd4jBpzu1gLa3G
         61qn5TSCTPJR73PT+bZU54Lzdmdi7a1vHciQZ/pk8yILZCPQ2MHM/NAqSjErVfcWXZ
         AtlF6OUAIougouF7bgzyBgcOok2y46cZ8melsbpIBfJ63kiT/s0P79G+zXvWxJp2/b
         uWThvwMmHgvig==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Q+xJH7+a c=1 sm=1 tr=0
 a=/rD2idLCdDHnmLflUbi9CQ==:117 a=/rD2idLCdDHnmLflUbi9CQ==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=eym-DvZL79KvhJxXCF8A:9 a=QEXdDO2ut3YA:10
 a=XIN47DDIDVcA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v4] submodule: suppress checking for file name and ref
 ambiguity for object ids
To:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>
References: <pull.725.v3.git.1599425259773.gitgitgadget@gmail.com>
 <pull.725.v4.git.1599425636107.gitgitgadget@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <cc71351a-6792-5003-c3df-b60ab87e5220@ramsayjones.plus.com>
Date:   Sun, 6 Sep 2020 21:59:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <pull.725.v4.git.1599425636107.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHR9eXLvMrLq/Iqz8D09Op6avFsCw2IvsjPF2zhV4v/B75dotYSDc6ot0ESmMh7Y3gtKnMFZK3HhtAHiJVBWlsGobSEdLyqLo5pmfeS0DKzl4/6/EGZK
 1pvCk/Dt4yhy4Ok+yCAfTSGeklynZ0d8qJyPTBNqdqfdypoS9zYkuCbtiCx05CXmgdJyRuBrWwvWgA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 06/09/2020 21:53, Orgad Shaneh via GitGitGadget wrote:
> From: Orgad Shaneh <orgads@gmail.com>
> 
> The argv argument of collect_changed_submodules() contains obly object ids

s/obly/only/

ATB,
Ramsay Jones

