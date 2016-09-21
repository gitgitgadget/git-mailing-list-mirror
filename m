Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 339C91F935
	for <e@80x24.org>; Wed, 21 Sep 2016 17:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758427AbcIURve (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 13:51:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34357 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756502AbcIURvd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 13:51:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id l132so9852966wmf.1
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 10:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=3GfabYC6Xb5iYGmXApGNHnwnPtaKEy9XxgiehXZFi24=;
        b=xCQb1tx7pKKwkKRxH1lnNp0whXmNw5ZaKLWo47ocB0BrWocUM9+1HqnOaueuBw7eI8
         h18C2AXcxaNnbxPUOHrVXvq6e9Zwb3ehzKt2MpK/IC9/7BC1z9XJtiTzLz3sXThJe5M2
         oiB1SrL+ipRSQc4J/Xprgw6HS75g0Kd9Fm8oXdfAEi5cczIXlqgCDlZZlhQQMGhh0cPj
         6d79W4O0sNEqQjHOvbIBfPfdDz5drYhZv+kZtd50c9rKtXyZIlp0RikZpZfSqSa9aP5I
         BEgm3Vch3cUOvP8iYx/+xaGytXZkBPL+o8sKbyKFZkulNwjOcGLO265nGkPEjBwQERM8
         6j9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=3GfabYC6Xb5iYGmXApGNHnwnPtaKEy9XxgiehXZFi24=;
        b=E5XPLws+9Xwp2vSEzpg0oAYrnGA+j3d/8GZ5NjurPwCESPX4XwhojmmBCSIGn11nRF
         YXMODxZu1oVK4gJ0j3FEHn6lc/GIFnWsSiZlLl9cp/0FoDpMrHVH0uUYeQtGwqXgOJP6
         bVjGu4CjqCTWiezUsb8XBaDSATfck6bi/eLpYdJPAut6EQIKe81brfVgodtVxGcNDnOM
         cZZvrrfSze+aHSMZqISfFzXbGfebwv/+dIz69KCi90KS4nXDPRoH9pz7Acj5TYCVvUDC
         N0Ul76XowttiDe9ZyI2nz+Ga1p95cBoxrN96RN0AoFFNy4/4w+ZDOSgeyL8KeGP2Cr4F
         KN8A==
X-Gm-Message-State: AE9vXwMwvb63XdgAznkKnE6maqOYm7jZGTD2cXmTQBBhmJxRSbmUokfrK1KWSwxHl2WC2g==
X-Received: by 10.195.9.73 with SMTP id dq9mr34125065wjd.31.1474480291816;
        Wed, 21 Sep 2016 10:51:31 -0700 (PDT)
Received: from [192.168.1.26] (enn40.neoplus.adsl.tpnet.pl. [83.20.3.40])
        by smtp.googlemail.com with ESMTPSA id xb6sm34671633wjb.30.2016.09.21.10.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Sep 2016 10:51:30 -0700 (PDT)
Subject: Re: [PATCH] gitweb: use highlight's shebang detection
To:     Junio C Hamano <gitster@pobox.com>
References: <20160906190037.12442-1-ian@iankelling.org>
 <108ce713-337a-801a-6c3b-089ef25a3883@gmail.com>
 <xmqq4m59b43v.fsf@gitster.mtv.corp.google.com>
Cc:     Ian Kelling <ian@iankelling.org>, git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <bef8e911-0f4a-2b42-3f98-98686bf2de44@gmail.com>
Date:   Wed, 21 Sep 2016 19:51:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqq4m59b43v.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 21.09.2016 o 18:38, Junio C Hamano pisze:
> Jakub Narębski <jnareb@gmail.com> writes:
>> W dniu 06.09.2016 o 21:00, Ian Kelling pisze:
>>
>>> The highlight binary can detect language by shebang when we can't tell
>>> the syntax type by the name of the file. 
>>
>> Was it something always present among highlight[1] binary capabilities,
>> or is it something present only in new enough highlight app?  Or only
>> in some specific fork / specific binary?  I couldn't find language
>> detection in highlight[1] documentation...
>> ...
>> Thank you for your work on this patch,
> 
> Thanks for reviewing.  It seems that there will be further exchange
> needed before I can pick it up?

Yes, I think so.

-- 
Jakub Narębski

