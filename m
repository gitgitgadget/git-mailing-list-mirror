Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DAFA1F42D
	for <e@80x24.org>; Wed, 30 May 2018 16:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753484AbeE3QMO (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 12:12:14 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44377 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753256AbeE3QMN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 12:12:13 -0400
Received: by mail-pf0-f194.google.com with SMTP id q22-v6so9259012pff.11
        for <git@vger.kernel.org>; Wed, 30 May 2018 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t0UxDkPG4TfqCBRejWifUkXCK7wWus3Y00QltE8jb1Y=;
        b=Vn4+QN3FivIyaqhmf5JvwgR6COkg6QoTpydZ/ewHc9hr8O+hzUeYgEC9vVBllFIMtd
         sApDaMdrm5+qzHfqpWroCtwFE08gvsm4dvNCPFvZl64deU/XS/9PU3A0gKL2pxrXRt3T
         g9NuAuGZDIXo6fDIV2CNvZifu5yuF4qyTTHE0ECVPq0Cg3yjEuPQpCsVwjZiTqmlHMNM
         Kd0VKjgXm05yulxYmO3Y0N5hZA4IPw8M3Rdp3+QgNbenP8IgDT9vpYeed++u3d7+Sd9T
         qcJzE6pO5z7PohRsYVFQ66FhfObg5yl/nkgB43Jo+ErJ0X0hOpUvZ6JfLBTpp14FWWY/
         aW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t0UxDkPG4TfqCBRejWifUkXCK7wWus3Y00QltE8jb1Y=;
        b=ECwR2BdTjtsUD9zoZGucR/KyBkZEN/Eb9bObT82Fhf2XD5Wu2S6FSz1+lvHu5c7wpV
         0XhizEdtiGfd+N6IXhoFZqpDE/1gzWHmpMFZIlehqKo2pNGwI57S533xGuYGBvY+HGFG
         LWCXIkmUmrKQEWp8JQzhB0Yt8ersjgBz0Bg5lG05H6T36ge8Xwj52GMn9zRpZ25cHdp9
         iATvM6wOopuHibJOZfMY0AMX93IxBQQqHaoCDShHwzosSmeSQPB3tNyCJ6w5Tao+5mte
         mZpwW6f2veefT5aYGln0Y/EWDscDeXT0R2E3DjswDIvf99HDxOr5K6tfJ2qT/7RNReFX
         FvPA==
X-Gm-Message-State: ALKqPwc8GHeH9NM21WYOeojRtN1qk/9Zvptth9KghSJLHKrUga2np85V
        ++JwCjbYiH4v0Amr185SG/M8qQ==
X-Google-Smtp-Source: ADUXVKIele5V/CLEK0TLTRPtqA5tskdvPBeE0EEqdz7VvirjPa4/NDQA7Om1d8E9xVgcvahAbwhzZg==
X-Received: by 2002:a62:d044:: with SMTP id p65-v6mr3404846pfg.64.1527696732863;
        Wed, 30 May 2018 09:12:12 -0700 (PDT)
Received: from localhost ([205.175.106.99])
        by smtp.gmail.com with ESMTPSA id j1-v6sm58929701pfh.95.2018.05.30.09.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 May 2018 09:12:11 -0700 (PDT)
Date:   Wed, 30 May 2018 09:12:10 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2018, #04; Wed, 30)
Message-ID: <20180530161210.GA9211@D-10-19-29-76.dhcp4.washington.edu>
References: <xmqqy3g1d4xa.fsf@gitster-ct.c.googlers.com>
 <20180530160908.GA8340@D-10-19-29-76.dhcp4.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530160908.GA8340@D-10-19-29-76.dhcp4.washington.edu>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 09:09:08AM -0700, Taylor Blau wrote:
> [...]
>
> I have these patches mostly updated on my copy (available at
> https://github.com/ttaylorr/git/compare/tb/grep-column) but am out of
> the office for the next week, so I will polish and send these on June
> 8th.

Ack, that link is broken. It should be:
https://github.com/ttaylorr/git/compare/tb/grep-colno.

Thanks,
Taylor
