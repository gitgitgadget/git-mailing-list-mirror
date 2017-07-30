Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46C292089D
	for <e@80x24.org>; Sun, 30 Jul 2017 11:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750991AbdG3Lg7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 07:36:59 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33176 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbdG3Lg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 07:36:59 -0400
Received: by mail-pg0-f65.google.com with SMTP id u185so5595680pgb.0
        for <git@vger.kernel.org>; Sun, 30 Jul 2017 04:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=8jImsprB6lggyxs0MYalhRnHHXir83VpZ9G1C5x+Pi0=;
        b=LVCCRQOHqovS1llXz+0llDHAuvSTIVXnQqBVA7LUR8LWAJs6ZLLQV4+U4ltTdtAg2B
         a6Exv8PVFieWUIz+MIf7JdHpBkhIEqKx9dYCjCnEaGE8eqwdz1atKt1LKZZBgSD2wsY+
         DQJb/vh003/tnMDuHvmShJPvx1wHTrqF6hnjanplDoISWXDh7WdXYHZPceCXjg81n2nu
         OyJHSu/RhRsQRPecZ0Cv7KL4JzCZoX/spMU5n8tvo3hhktbjAmmEVNdsI/hxoQVHx0hX
         jOlgsJ++8qJh+R4jeN3ox+ROu8/nF6S3TbRtff3MBFD+rbywlv4xmPvPEs1z16SPtqd6
         Pc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=8jImsprB6lggyxs0MYalhRnHHXir83VpZ9G1C5x+Pi0=;
        b=lbdzmBUtFKXA5u/xYqt6bs57ZH5mjgMGJEiFXtmcD6CfFs4L074tcvAYAxr7tlLN/9
         HXEwA/UB/n5POOndESxOVJxs3OIsjnkvBxkwhilbsiOC4SrTtRMlQ6rv6k6S3vtGS8jR
         6C1FaiekqacW0Nbsya4Dr7yYdvxU0/hADDKCXXEcJm2FHIs19oTnWVxRs/6iaGdESDn0
         xrRPGOnNPcGFxmQkH+pXvCV9mrecBOIO08Ie8fSdCdreLC4HtJvsji5vw3F8sTWRDHPo
         DHl7Y8etkEq7u93FxDzEVLgK3WLQ53R4tZH3ZFXCZeak96bu9PbSV/216dQjsRiOBmei
         em7A==
X-Gm-Message-State: AIVw1118z28bMMCapI42JjMp5B/1jvadd87Egqu4TG+IaycI3bknNcxW
        ldSh2TitY4Qe+A==
X-Received: by 10.99.113.7 with SMTP id m7mr564554pgc.55.1501414618430;
        Sun, 30 Jul 2017 04:36:58 -0700 (PDT)
Received: from unique-pc ([42.111.163.163])
        by smtp.googlemail.com with ESMTPSA id i133sm11562858pgc.0.2017.07.30.04.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Jul 2017 04:36:58 -0700 (PDT)
Message-ID: <1501414648.12254.2.camel@gmail.com>
Subject: Wrong thread
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
In-Reply-To: <20170730111326.12139-1-kaarticsivaraam91196@gmail.com>
References: <0102015d7f0c9403-16bd1de5-3b6c-4d23-a3fb-75a26c378c62-000000@eu-west-1.amazonses.com>
         <20170730111326.12139-1-kaarticsivaraam91196@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sun, 30 Jul 2017 17:07:28 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, sent it to the wrong thread. Please, ignore this patch.

--
Kaartic
