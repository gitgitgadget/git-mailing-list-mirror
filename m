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
	by dcvr.yhbt.net (Postfix) with ESMTP id 36ED42035B
	for <e@80x24.org>; Tue, 11 Jul 2017 18:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755802AbdGKSEJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 14:04:09 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33944 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755326AbdGKSEI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 14:04:08 -0400
Received: by mail-pg0-f66.google.com with SMTP id j186so759509pge.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 11:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=L9WkzVZoX2aD8gPXqJTkqDIpxEZwg09fGlMxSlGp3N8=;
        b=tQeKaN+Pfc3qF8myMEI9Ldot2ZhR7/MqQowKQbv+TKikZevc9dR/ai5nNM3iOAxI39
         IS6DdJ2z5ixrw3H9t5qE6nmTYLM2ZwWAxbA1y6CaOWCj6vnV2cfD6pGB7gunCpXFshSu
         2fwDLglGNaxPw1dGaAH04Y36Byk0jiAaRUlp92VgdkA8NHPqTVStLnIQy5GfPdfW6rOj
         oJpR02qe4477rA+Lu9VXhAGZzVI6+cNKqkWEphAOrmiTpPYYlkMTqtk1CbjRJWvTsKzg
         3wVriumNTunXUH3OOpwfh9VTXi39W+iv+lxXHcjOmA7N/LE0+likqilU7qFFz3OvZZ33
         thSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=L9WkzVZoX2aD8gPXqJTkqDIpxEZwg09fGlMxSlGp3N8=;
        b=AFr6+bBU3GG4iwiXzI4QtsdfBCLg/yCuFkFCSr2pHI0v+55ATv00OEXsU/iXPW6FcN
         cQ1UuIl3uOvIfbzXIGe5Tf9LUHRcBog4xvKJs5hGPmc+mApny+lLqOGWlnfdXHG5I2pC
         z9V7wjTi5iV1eWBpyTNlf//gSnN71xnjhglPatnWWprNWrUtF/E9mEnDYZzeXzs2+FNy
         XspQuLreHRh7KCPPQDP/vHl2HWwrHT2fe+x22rPI0wjp6UoyEo+G1aaLy0XdpN8K/xPk
         f24flehg/VJfRrAmPVJk5EwfE1YwNG+BqVMO7yzlR2GoRwFaTg20+BwyJhbC/EaxOzRT
         0igg==
X-Gm-Message-State: AIVw111Y5paG3G3M/kdZx3rZDWizigWTVZBNFMdC/RCIQsXXiQVxa6hj
        OI2EcSfxPVBsVGViQuY=
X-Received: by 10.84.141.131 with SMTP id 3mr954065plv.224.1499796233219;
        Tue, 11 Jul 2017 11:03:53 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id r9sm1059413pfi.114.2017.07.11.11.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 11:03:51 -0700 (PDT)
Message-ID: <1499796241.3180.1.camel@gmail.com>
Subject: Re: [PATCH 4/4] hook: add a simple first example
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Tue, 11 Jul 2017 23:34:01 +0530
In-Reply-To: <xmqqtw2j2c6r.fsf@gitster.mtv.corp.google.com>
References: <xmqqinj4ayqb.fsf@gitster.mtv.corp.google.com>
         <20170710141744.8541-1-kaarticsivaraam91196@gmail.com>
         <20170710141744.8541-4-kaarticsivaraam91196@gmail.com>
         <xmqqbmos5add.fsf@gitster.mtv.corp.google.com>
         <1499779787.1740.5.camel@gmail.com>
         <xmqqtw2j2c6r.fsf@gitster.mtv.corp.google.com>
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

On Tue, 2017-07-11 at 09:03 -0700, Junio C Hamano wrote:
> But does it even be useful to enable it?  The commented out "git
> status" output already lists the modified paths, so I do not think
> anything is gained by adding 'diff --cached --name-status' there.
The script *doesn't* add the output of "diff --cached --name-status"
near the status output. It adds it above the first comment and of
course in an uncommented form.

So, should we remove it (diff --cached --name-status) altogether?
