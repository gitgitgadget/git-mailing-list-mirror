Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A3511F404
	for <e@80x24.org>; Thu, 14 Dec 2017 12:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbdLNMh2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 07:37:28 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:39894 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbdLNMh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 07:37:27 -0500
Received: by mail-it0-f47.google.com with SMTP id 68so10749522ite.4
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 04:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:in-reply-to:references:date:mime-version
         :content-transfer-encoding;
        bh=dx0LBrd5Uv0Pzf+4Cmj6fID9AVbgbqz6oCwqSUI+k9g=;
        b=k814LHIc6f9D92gcXQt4WX/h2JJ8b/wzPWo2dRT5b0E7OOIfBij0US9Rm3y8AkMI4f
         f6YW3gZOQTmn8MlzX9ekG5oEuA938Jjekl22FNGUB6BFgqWxLZheUUd2XtyOLtzy7T3f
         1kdQeHCyfZruujrwB+kdvZAtABmzeW3ArEMYJW3zT5e3X7irzzyOH3GBRmYzga+duQfL
         mgF9aPy6myzeBc+ob5SnLnvO6QtCC1ZXA9re29KM2l2gIJPSSAla9OdfYEVkWkenZCve
         dEQshZ9FvjqdII0O9uALucwX1wBMCs4ZXAhh4V4rp4Gbc/V6+XhFFT09FqHbHjtnzlr4
         eogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=dx0LBrd5Uv0Pzf+4Cmj6fID9AVbgbqz6oCwqSUI+k9g=;
        b=hjPlJmSqPFHP2labGbN2GZcfmTNSaSLzI7Aky77Zjciv7HbiBnlHrpePdoXUh7EBWN
         bEcrODugwGvD35iHE5hJA9hyv9k5gwAHKgOILU/VUCBeXHzQc9kRX2kYNBV/1EkBq+Z+
         evRKohvRkxUx03+SSJzwNxzL4uQ3xneOxsdTEvJvA5zIOT1XPS80MNo4MBRi+cBuwCI2
         rYWfWDVMxQ1jdSgnHfz38pUT0u/kWvMlKhY2x2QfPgIBn8jlQRKuLJOUbokz8PUQiyZw
         /5X/qc2Q+dmMXUBOtgwE0sCTgrDR3dHqbib5TdEMarCTGepsm4aMFfX54YAd5uClHuX+
         BuPA==
X-Gm-Message-State: AKGB3mKJQT/sDZSk6BFzrVTqL4rJPls3koq5xHkJxzEoYn5zx/BdmTSH
        Hkzad4leir5DrUtrot04SBM=
X-Google-Smtp-Source: ACJfBoso0NH7q7j/Yu6YYEKP/Acc6X1XYUC4WTpgrMwj7odEyciEt7OH24Wkwrr0h82C8H9TJLC3bQ==
X-Received: by 10.107.20.129 with SMTP id 123mr7175135iou.36.1513255047101;
        Thu, 14 Dec 2017 04:37:27 -0800 (PST)
Received: from unique-pc ([106.203.33.3])
        by smtp.gmail.com with ESMTPSA id v9sm2822722itv.35.2017.12.14.04.37.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Dec 2017 04:37:26 -0800 (PST)
Message-ID: <1513255038.6351.2.camel@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2017, #03; Wed, 13)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
In-Reply-To: <xmqqzi6mutcc.fsf@gitster.mtv.corp.google.com>
References: <xmqqzi6mutcc.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Thu, 14 Dec 2017 18:07:18 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems my series that fixes an error message in 'git-rebase'[1]
(apart from a little cleanups) is missing. I guess I addressed the
issue that was raised in 3/3 as a v3 for that patch[2]. Are any more
changes needed?

[1]: <20171127172104.5796-1-kaartic.sivaraam@gmail.com>
[2]: <20171201060935.19749-1-kaartic.sivaraam@gmail.com>


-- 
Kaartic
