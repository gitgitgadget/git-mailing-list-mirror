Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEC0F20986
	for <e@80x24.org>; Sun,  9 Oct 2016 10:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932313AbcJIKE0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 06:04:26 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:51274 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932212AbcJIKE0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 9 Oct 2016 06:04:26 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 01CE5206CE;
        Sun,  9 Oct 2016 06:04:25 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Sun, 09 Oct 2016 06:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=5aK0XDTnC07eGD2
        Cfw1gZTtFgJs=; b=JhQaQRP62Dqi5Uowa/IE4yjInjrRaSfBdIWEWAKchxSYg/O
        obsQQcFlU4nNKfdJpcpVwXOPitdV90PbDZLbmFQj+QFkSNigNDFfPl5vCs02RJ77
        +sapi23w9JZ/U52sRxJyn071Q5sBHGjAVSVx5fi6qau1tRnoUuEPKqZr+LZU=
X-Sasl-enc: GZ1HmftDLKCX9aC0/t+2LV7aZ7aNqUAq3zcXyQj9zDhz 1476007464
Received: from [45.74.44.47] (unknown [45.74.44.47])
        by mail.messagingengine.com (Postfix) with ESMTPA id 45948CC07F;
        Sun,  9 Oct 2016 06:04:22 -0400 (EDT)
Subject: Re: %C(auto) not working as expected
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        git <git@vger.kernel.org>
References: <cb81631e-9623-9020-f955-ec215b493a50@hale.ee>
 <f35965e9-2901-b9b5-92e5-9bc7fe673637@web.de>
From:   Tom Hale <tom@hale.ee>
Message-ID: <65d8def3-df62-6c45-7d8f-79b6a8769bf5@hale.ee>
Date:   Sun, 9 Oct 2016 17:04:22 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <f35965e9-2901-b9b5-92e5-9bc7fe673637@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2016-10-09 13:47, René Scharfe wrote:

> %Cgreen emits color codes unconditionally.  %C(auto,green) would respect
> the config settings.

Thanks, I've never seen the (,) syntax documented before!

What's strange is that this works:
   %C(auto,green bold)
but
   %C(auto,green,bold)
does not.

Also:
Given it's very rare to want only part of a string to emit colour codes, 
if something like "bold" carries through until a "no-bold", why doesn't 
"auto" do the same thing?

-- 
Tom Hale
