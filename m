Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 168A4202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 03:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbdF3DTw (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 23:19:52 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36041 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbdF3DTv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 23:19:51 -0400
Received: by mail-pf0-f174.google.com with SMTP id q86so59933496pfl.3
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 20:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=zj4LDGmsYc0zeYrizcGm9rhJrkPmlZvGR3r7vrdRMjU=;
        b=fDjXxFhbuOi/1KOPCDbbwrKteytOlB85yzS11XuuKeX/D/Se/QlL0R3HqgOVtn++/U
         Dggtl/sWyRgnSpj8w8lNbl+90b4NNj/2+tR4fV3r9p2WjMiPH9jvm1MOFvWAiyxjK5in
         UqlPWuL4Kl4jw6pMHrcLNTiI2r9f2yUYy4GbW/UI6tcR2AernM/rR8PlhnGs0OFzl3J5
         hftGV+gBnx708lAuDO9cJq9XOH1K04gPBiEfGL/13WzlbjjP6zsmbPi8vmOVYRdZ+nH5
         XjQr3Yb9vsQuf10G+6KYkaFEkYBI8aBST7jjiRIVvcH4Dz5tBSJknaeR+RyzLJV68Co5
         xGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=zj4LDGmsYc0zeYrizcGm9rhJrkPmlZvGR3r7vrdRMjU=;
        b=KOBrUmPAgv7AaXmrWEfol9neI9zcWgitcam5+uzp2Vac7x7GHEa9TP1BtLERw87aLM
         gJuWm6iz3p+10L/fc+o20H7wDIVOUaB51ZGFhkZ8QdhUjxuqK29+hQFgV4SlZjXvBii8
         waGP6FV07R80tv0+X5JiVLd/CTTX+Ro6g/0+qWQBGAcJMrl+gyigZneDD88cFX8iYir+
         /VBwzm2Rz+/KQdBFZG2KgulBBJBxkZxoOxgqkk9UoS3L95be6k5U6E9q1Z0YrZ9wiFo3
         QI1zYH+l6zDQU8rKMudE49P0qAhJlHb5Vy7+Z6wzC3ow+hLMkSRsagIEHl1m4r6CnJf5
         1MPQ==
X-Gm-Message-State: AKS2vOzmLHUB6dHTU0DCXgukrKvmgAuoJp/mUokDPqWvh8CfN5Km3jmG
        j4I3uCpc9KP64ql5n88=
X-Received: by 10.84.231.1 with SMTP id f1mr21747216plk.258.1498792790437;
        Thu, 29 Jun 2017 20:19:50 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id p65sm15502333pfj.8.2017.06.29.20.19.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 20:19:50 -0700 (PDT)
Message-ID: <1498792789.2063.6.camel@gmail.com>
Subject: Re: [PATCH 2/2] commit-template: add new line before status
 information
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Fri, 30 Jun 2017 08:49:49 +0530
In-Reply-To: <xmqqmv8qu08n.fsf@gitster.mtv.corp.google.com>
References: <xmqqshikvz1s.fsf@gitster.mtv.corp.google.com>
         <20170629170120.11479-1-kaarticsivaraam91196@gmail.com>
         <20170629170120.11479-2-kaarticsivaraam91196@gmail.com>
         <xmqqmv8qu08n.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-06-29 at 11:17 -0700, Junio C Hamano wrote:
> The rationale of this has changed in this final version, hasn't it,
> especially with the removal of the "include/only warning" bit?
> 
> We used to add a blank line to separate the "we are committing for
> somebody else", which is an optional part, from the status output,
> only when we have the optional part.  Now with your change, we
> unconditionally have a blank before the part that would have been
> shown by "git status" to separate the two parts out.
> 
Yes, modified the commit message accordingly hoping that's what you
meant.
