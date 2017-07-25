Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAB741F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 18:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750882AbdGYSbd (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 14:31:33 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35012 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbdGYSbc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 14:31:32 -0400
Received: by mail-pg0-f66.google.com with SMTP id d193so15123236pgc.2
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 11:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:in-reply-to:references:date:mime-version
         :content-transfer-encoding;
        bh=OsVYJPhGpO/5+GjH0Tk/ZzGn7eHiNZ2fxeUbx7bpOJw=;
        b=Glud4RPQHWJlebNMKvNnJ/WWM+iF6Ud8D+h+N5FLv/3QaDDWmWzxcxsLWCWUhdmytE
         PKrHDd7FmWLhbHVSgovzOc9SgyHQTuq5a//VkPtVOsPgDVs0gFaL+dkOxTZLFUNDqER2
         E9XUQeIX2PCX596cV1XSbQhAi9LPsitAMr17aU3A+HBed7NYXAoo7aa9okqMVl5PN7E+
         wuWqNceTPdpkQbOfgpWH56E6bIUeSazjzzMy49sko2YqGIGFEvqVH23VFe2/bpluNdzD
         wm4K/qSzdXw7JRH0Df7sNj0Ve6GF0Td26fl+ruMhcFE/f/BEDN0+jRsAiG65fScwIzMF
         V3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=OsVYJPhGpO/5+GjH0Tk/ZzGn7eHiNZ2fxeUbx7bpOJw=;
        b=jxjrvTleBM+QLzJew0wlsAkwd9KeTuLL++jOgL2Wos/VhpIHwZ2sB8wbU4g1iYn1zo
         mQQQQ8Jc+7a9LmGXonk/EARuegP6KwaAUIMcx8IzCCDS5v1mgObJyXj0nB0UVSt66sV6
         FiD+r1ZxZPLGF7UgcUwB2D8OpkeNSPDCNOlPZqmOgKEo9G9YLyFYpglMd7rL420wxyCS
         GMQHh7x+Gv0DExFm2/7gTQH/c/OHlD0pVCxMmiVU9L9VWb4KwZHHJcsK2LLRmN7f2JUL
         v4jn+PzgIn2xW+TCqbaOIWS/45bIhwH7MA+UPiAJC7r2Ax0iTDxbF62/EEBeslFiqhJ2
         KsVw==
X-Gm-Message-State: AIVw1129/eKLN/S8bc7kzc4HuT4ehNfNqhzWVPKANuGUdarbYyxXq4GT
        nrS9rwzmmIomlijjeVE=
X-Received: by 10.84.247.9 with SMTP id n9mr22378079pll.287.1501007491321;
        Tue, 25 Jul 2017 11:31:31 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id 205sm23957216pga.65.2017.07.25.11.31.29
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 11:31:30 -0700 (PDT)
Message-ID: <1501007517.11979.4.camel@gmail.com>
Subject: Re: [PATCH] branch: change the error messages to be more meaningful
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
In-Reply-To: <0102015d7b021c6c-8741d523-c7d7-4be5-923a-cd4a925842a0-000000@eu-west-1.amazonses.com>
References: <0102015d7a301def-0d802f3e-6052-4e32-b331-c42c3160012b-000000@eu-west-1.amazonses.com>
         <0102015d7b021c6c-8741d523-c7d7-4be5-923a-cd4a925842a0-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Wed, 26 Jul 2017 00:01:57 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The second patch differs from the first one only in the commit message.

-- 
Kaartic
