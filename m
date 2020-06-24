Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FD7C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 01:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42BB62137B
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 01:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=whinis.com header.i=@whinis.com header.b="uhfOkzl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388161AbgFXBOm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:14:42 -0400
Received: from whinis.com ([198.205.115.165]:55082 "EHLO whinis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388029AbgFXBOm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 21:14:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by whinis.com (Postfix) with ESMTP id CA6B47C513D;
        Tue, 23 Jun 2020 21:14:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whinis.com; s=mail;
        t=1592961280; bh=DxnExhv1DB5KPFIUVL1SE/1TfuBcKRQzAAT6vaC9RhA=;
        h=To:Cc:References:Subject:From:Date:In-Reply-To;
        b=uhfOkzl5yv0HmBJutkGetpznhi79LD5OikNzP9o/Jz0CWcnewPnNY6+RLMUjv5M49
         OC2Qw4PiZrEHC5WEkY5t/D2P2dA3bV+AaGDjYRysJ7fDjVGSuB4+sfXBVPJ0U0Jdku
         7dnug9aV0dWwv2kFS3Pxzsh4oGLyvwzRQB4vDp38=
X-Virus-Scanned: Debian amavisd-new at whinis.com
Received: from whinis.com ([127.0.0.1])
        by localhost (asgard.whinis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dKfdYmr0nyCo; Tue, 23 Jun 2020 21:14:39 -0400 (EDT)
Received: from [192.168.1.117] (c-73-139-109-188.hsd1.fl.comcast.net [73.139.109.188])
        by whinis.com (Postfix) with ESMTPSA id 5BD077C511B;
        Tue, 23 Jun 2020 21:14:39 -0400 (EDT)
To:     gunnar.liljas@gmail.com
Cc:     git@vger.kernel.org, simon@bocoup.com
References: <CAAOnFsNUB_+NZMGnu2yasL8tk_KTfqPY6JiHOpvYHiyY_Lytrw@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
From:   Whinis <Whinis@whinis.com>
Message-ID: <fbf1321f-c7e0-976d-c62e-36089e675bf7@whinis.com>
Date:   Tue, 23 Jun 2020 21:16:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAAOnFsNUB_+NZMGnu2yasL8tk_KTfqPY6JiHOpvYHiyY_Lytrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Excellent post but I think your post also missed one other possible 
downside. Excluding developers afraid of politics becoming more 
important than technical development in projects just as many developers 
did and left python after their change.

