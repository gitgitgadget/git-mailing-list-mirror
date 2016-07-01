Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 550FE2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 18:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493AbcGASro (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 14:47:44 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:38314 "EHLO
	mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbcGASrS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 14:47:18 -0400
Received: by mail-it0-f46.google.com with SMTP id h190so23745845ith.1
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 11:47:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TqxSbOdY++6KR4pnWCOyusoGNEiMJLk+u2ccmH+jphY=;
        b=QB61W3DYMQGH3mk6wpcLzu9HtcUssrdJa2uN5CWX4EnED2iidM9hFuwTcZcT+1evnd
         clIYdz0+S4sE9fD4NsoamJ5v7WKpP/eClGENlCjrwlMkssf4K41+nW9FZRNWQmuiOlWb
         Sfc0mpVXl8z1GP39cVBOhg7XSP3b6lG3PQwCPQ6CxiTwdNAJuf+UITtUoYrIZ1y3EZZ5
         SAbZo91e7wlBm6mMQ1jB0nzF28bW1sf4lVN/OfYzh9TGjcGRvbK9u7WLG9uTeGpbiQzp
         QqDCc6PXnaO1cGCmqeECVjEhQ/7SF6+ES/CMcneWTrnhSGEyK7+pensbA/wnOG5BymbM
         nkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TqxSbOdY++6KR4pnWCOyusoGNEiMJLk+u2ccmH+jphY=;
        b=S0PUMfMuVh/V9fHS8jxHQulNkCMBzNMuKMEIyQdVYrgAymr8PxXuF/LkZHWhvBFlC0
         okuoX4wHo5ZAPBw7tqdom0v9L6O81muntghYEEbrKejRWiA+eXSKWo2K2BJ0EJZi+nh2
         nFJmI+/Aej+8mof+I1nO22qiahlbaA7jEb/lP8y1IuIB88syZ5eDQHlnM0TWPLC2pbI9
         Cfo9cj2unaj0Q5f/kIDJeM608cAQxjHYeINzFKpcWjOHZpMuqJvrWnR+ztllpZ1EARKZ
         kng36zsehYu1mnAl5PwSwiGjzBe1ocl86WuPXjREbvpdfjQ/OsSoApGjQVNbMK2FZtbZ
         kG3A==
X-Gm-Message-State: ALyK8tLvi/6v5M/N/18zhYXWW8i2GK6qPAVRgUvME6e1sJ9y3NHBRXI0DMXS9NXAvcgAbDN4W56nE0cg8cIAtQ==
X-Received: by 10.36.33.22 with SMTP id e22mr1053778ita.42.1467398820480; Fri,
 01 Jul 2016 11:47:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Fri, 1 Jul 2016 11:46:30 -0700 (PDT)
In-Reply-To: <xmqq4m89z0gl.fsf@gitster.mtv.corp.google.com>
References: <20160623162907.23295-1-pclouds@gmail.com> <20160625052238.13615-1-pclouds@gmail.com>
 <xmqqeg7id6ns.fsf@gitster.mtv.corp.google.com> <CACsJy8BU0fDVR54hMpA6qVknj+QxWR9Z-i1gRgpaJ6hp+SB2xQ@mail.gmail.com>
 <xmqq4m89z0gl.fsf@gitster.mtv.corp.google.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Fri, 1 Jul 2016 20:46:30 +0200
Message-ID: <CACsJy8BBQqxzT8jdaysyeDv3ja=DTD6R-whA3Lhr3pEs-2x8dA@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] nd/icase updates
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 1, 2016 at 8:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Makes sense. But then if opt->ignore_case is false and regflags
>> happens to have REG_ICASE set, should we clear it as well?
>
> I think .ignore_case is set iff '-i' is given, and .regflags has
> REG_ICASE only if '-i' is given and the user said she does not want
> literal string match (i.e. no '-F').
>
> So... can .regflags have REG_ICASE when .ignore_case is false?

Yeah reg_icase is more like a subset of ignore_case. Ignore what I wrote.
-- 
Duy
