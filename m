Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D4F920282
	for <e@80x24.org>; Tue, 20 Jun 2017 18:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbdFTSuN (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 14:50:13 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34810 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbdFTSuM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 14:50:12 -0400
Received: by mail-wr0-f196.google.com with SMTP id y25so17453338wrd.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 11:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EOTY9Pf3LxNJjVcC1cyy/KiOsLzpJq5YHJbgrgbxU0A=;
        b=ScRlvY81jIL7v6qkrLfPmoZvBigRiyYzaCzQJ9d3b8H9LHj7M7jLZvxXXGYeYTS4+5
         58Afhzcu3m5WCz0JWW7n/bJ4QvU4p3t1qwh+/uxiOw3fttuoh+3ZtslF+hvFf0AXNVW1
         OK5uZp22hLkbhozHhkzHAqvlpSgbGNN8V/IuJA8nof9Pm9UoKr3QH1W9EUJpF5cPZLMr
         97IaBT12ugmR15uSAXwu2HvIjcmsdyPILKLyYZpWpGyKmTWf3svsMJpqAoGUffng5OaM
         1WKW9/rRaJG/XDTuJBARWQX2UfPBG3xLYB5MCxO/9tI16T3fbFryuyz2OXWOO9FQGX39
         0J5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EOTY9Pf3LxNJjVcC1cyy/KiOsLzpJq5YHJbgrgbxU0A=;
        b=shoyeSaqf2R/iYx8oP6nQWZDZb/GgYWWrfv8/czs6hW+g+cGpG1QqZCoOpwXMT3zq/
         U9KABwrRFNVWTetA/KI2bsqb+2nW6hJte1wtQOVS+FPc/vZgZDkhYYM+H64yDRoLpWjb
         v1LHKoA+M2CTuGDDXbJdUi77HWdL6OtAP8y71cPgZUQ24ryPorsl3mcCU/pMGOYqlLEo
         gzxN0cdHIsv54uc8RFNx7C2/gdO8iXJVzLkaTR4JqR5HSBPz8iMVKnow455XuNSrxH9b
         7w1w2nC9daR+5aHEgiKeAfdQTZkG1iiFs958ZcQDnQItFu/e45El7bleDgfEHeQu9DP9
         62qA==
X-Gm-Message-State: AKS2vOxJwFqEnuTljQhETudwHnAMazUt5GdjgbIOSjS7EZcZlxT4Qzwa
        Hk4hNyukVnWIS5Ee
X-Received: by 10.28.215.145 with SMTP id o139mr3905420wmg.105.1497984610912;
        Tue, 20 Jun 2017 11:50:10 -0700 (PDT)
Received: from ?IPv6:2001:a61:10a1:8501:1d3:dd00:46a5:793b? ([2001:a61:10a1:8501:1d3:dd00:46a5:793b])
        by smtp.googlemail.com with ESMTPSA id b192sm11376166wmf.25.2017.06.20.11.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 11:50:09 -0700 (PDT)
Subject: Re: Transform log message during migration svn -> git (using git-svn)
To:     paul.mattke@s4m.com, larsxschneider@gmail.com
Cc:     git@vger.kernel.org
References: <8ce2bf074fcf4d6181a29eb3e7fff132@GTLBML3EX0005.bagmail.net>
 <EAA4B747-FA00-4A3B-88CD-AF8EBE1F8586@gmail.com>
 <90ee80a910884e1e98fa8a5001ae850c@GTLBML3EX0005.bagmail.net>
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <e7cb2b23-21ec-f124-5198-7bb72e601184@gmail.com>
Date:   Tue, 20 Jun 2017 20:50:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <90ee80a910884e1e98fa8a5001ae850c@GTLBML3EX0005.bagmail.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: de-BE
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Am 20.06.2017 um 14:32 schrieb paul.mattke@s4m.com:
> Well this is a possibility, of course. Our problem is that our SVN
> repository contains about 220.000 revisions currently. As a colleague of
> mine said that the command you suggest might take about 4 seconds per
> revision, it would take about 10 days to do this for our whole repository.
> So of course it could save a lot of time generally if such operation could
> be done immediately during git-svn.

My data point is this: A "git filter branch" run with ~2000 revisions
took several hours on a Windows 7 box. That number seems to be roughly
the same as your number. A comparable run on a Linux box took only about
10 minutes.

So: If your benchmark was done on Windows you might do that also on Linux.
