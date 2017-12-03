Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.1 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4301820C11
	for <e@80x24.org>; Sun,  3 Dec 2017 14:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752088AbdLCOP2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 09:15:28 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:45754 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbdLCOP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 09:15:28 -0500
Received: by mail-yw0-f195.google.com with SMTP id y187so5745079ywd.12
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 06:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :to;
        bh=tGwmFB2G5be1jHnWRMGE/RQXQ3e39lnVk2uO1+72/gw=;
        b=YfPvoQSPMrOjaGb/TvTs1rSntzG2K/whBNYXErTtw0R1NHARaynycmXgpKha+Zf25B
         1saemkl9TmkKT/U28lAg6CAa2Vo0remnztoquzq2mz0HdKaTCvPZy3+85iztHpvJZyRc
         ehhE4F9tqi1nMqB1FPMU899SDfg1MsTx4CorTCelRYm2FO1USdCbJtSwgA3ihJ6p0VUE
         FRfpnRaQUlVBnpH3v0jGR8bv9OlXtO3WdE8+qq6woi+r1CcZL3ewWO/onWDUZA3gmiMf
         Rei9sui84t9ElB8VngWIuOBXSTErhVNHt/tbZ+DUYAJOgh/AxgnuzYLA7Cyow/R8596w
         SwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:to;
        bh=tGwmFB2G5be1jHnWRMGE/RQXQ3e39lnVk2uO1+72/gw=;
        b=Ajz8siyqrm4cdoeGBa6FgngBwJ6w+fvINXQcahmfjLw96Et2+Dtxe6nKFMcKuoc9+O
         RsHfnya01pe8gtJWEVsbRrwCHmXI+zhLCaHt6enWP/NgFPhF5ToqpjcqlY+IFhv+Q3wB
         6oinOWcl0fHm6kNKEB9YHZ9Ua/d+KvobZbyDHxJ6a/TlftnUVUQRrrhg4HUoy17+eqJj
         QhZHKMQeoYHiYtIsCZr+HLNM7xS0sl/9ThxaZ7bnx93SkJAfI2zasJcK4N5qWjRazpKX
         wCPJsqMR/4qez5YKOaxLGLfoPf7DRG4ZzQkywtdh7MG3salK/E5eB/x15fBfsJRPCTQ1
         aonA==
X-Gm-Message-State: AJaThX4ojogqNRTWWpteEfD+YChtQ96bwni1B+2Y/04rM8Vs13KuzdLX
        YnrLu5UrdZ3uZYDS+DJICoxag07/yMo=
X-Google-Smtp-Source: AGs4zMbGPJbVneS0aDw1qOOMWHPKnXJEwy+vy6grPh9nrUPOsmxyvWQ0uBfd75qclxjBEVYe1QX/Gw==
X-Received: by 10.129.157.87 with SMTP id u84mr8176881ywg.232.1512310527341;
        Sun, 03 Dec 2017 06:15:27 -0800 (PST)
Received: from ?IPv6:2600:1:f208:4f2f:4cb4:959b:abe8:176b? ([2600:1:f208:4f2f:4cb4:959b:abe8:176b])
        by smtp.gmail.com with ESMTPSA id y188sm4896555ywc.27.2017.12.03.06.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Dec 2017 06:15:26 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Jacob Chassereau <chassereaujacob0@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Sun, 3 Dec 2017 09:15:25 -0500
Subject: DARPA icon test
Message-Id: <9B0EDF8D-E911-4544-BBF2-DFABAE317009@gmail.com>
To:     Chassereau Jacob <jakechassereau@gmail.com>, help@asmallorange.com,
        git@vger.kernel.org, feedback@mxtoolbox.com, PRAcomments@doc.gov,
        AOLcopyright@aol.com
X-Mailer: iPhone Mail (15B202)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


https://www.w3.org/Icons/DARPA/inline.html


Sent from my iPhone
