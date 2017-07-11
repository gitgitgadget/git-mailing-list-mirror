Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28141202AC
	for <e@80x24.org>; Tue, 11 Jul 2017 14:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933228AbdGKOlo (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 10:41:44 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33666 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933164AbdGKOln (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 10:41:43 -0400
Received: by mail-pf0-f196.google.com with SMTP id e199so199122pfh.0
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 07:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=Ps/2tZ0VhbDwf81If/w+UQbro4mv9BeHR6Mf8nINlcc=;
        b=k6fCv8809ewrr5S5X05NCrgLIi925uw7lIok01xOizrorzu82TEaOrQkcPC+q4iBTo
         dvAPhMRo8tT1H47xqvEkV27SwvCedR8pvGAFqmFrN1extYvBI8gBVBFkLCY1KM3H348X
         A6tX3W0L42b2wpi80ZTWIsgPhPf/NmCbc/sDfdZBUp9QtBdlDtWZfism1s6ni0goTBGH
         0KFq3PWZLFk5b7yk4v21XE0YBfAVf7wvpFrRINYhRBju1PP2peG4A/etPOHNl9cC1sq0
         1/GAnXHxZsKhngkMcPJcBJDIBKl/gO5FoxYbJiKj2hW7yuJefvyKOO6FwGspaehz/uxe
         GW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=Ps/2tZ0VhbDwf81If/w+UQbro4mv9BeHR6Mf8nINlcc=;
        b=ta4jMg2/6i0quFaF92DXP7VvaSIVf8cgNdBePGX3npSvMoMBvXC/0k6Xl/Z7c1exLr
         yNehK8aQ1RPP4aYtOGRLx1TETjE7zrwgzZto1KdVXCMoOLeP50MFVUtg0whAFD1tvmWb
         3KsMUsZHUzjOoTutLzQQNokVXRS5lu5kwOZlQqblOP7ayq96vYuVjH05DVMICOiVINxF
         wc6EvMZCqK2nbRb8qcrq17DJA8aS4NyFAHpE0/eisceH1DsHuRCHiq8lv9+9x5Kpw5Oi
         KfvV92g0CM9X1gy85HtFHnTuqfeYgXc6sMHIJQOcIky9fd/QZ3U67z7VD1ZfxYdKyUO2
         B+4w==
X-Gm-Message-State: AIVw113kaaZoMSMXcR/ZtBp0BDxol5zAkHbiOmmx7HdItPuaiyASikZ2
        uxO3VIDNN5wVQw==
X-Received: by 10.84.231.197 with SMTP id g5mr258113pln.71.1499784102930;
        Tue, 11 Jul 2017 07:41:42 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id p77sm237874pfd.62.2017.07.11.07.41.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 07:41:42 -0700 (PDT)
Message-ID: <1499784112.9558.1.camel@gmail.com>
Subject: Re: [PATCH/RFC] commit & merge: modularize the empty message
 validator
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, me@ikke.info
Date:   Tue, 11 Jul 2017 20:11:52 +0530
In-Reply-To: <20170711141254.7747-1-kaarticsivaraam91196@gmail.com>
References: <20170706044640.GA11020@alpha.vpn.ikke.info>
         <20170711141254.7747-1-kaarticsivaraam91196@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, forgot to add the RFC suffix to [PATCH]. Please consider it's
presence.

-- 
Kaartic
