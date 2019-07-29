Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=2.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,EMPTY_MESSAGE,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MISSING_SUBJECT,PI_EMPTY_SUBJ,PYZOR_CHECK,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B89501F462
	for <e@80x24.org>; Mon, 29 Jul 2019 02:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfG2Cus (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 22:50:48 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:43571 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfG2Cur (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jul 2019 22:50:47 -0400
Received: by mail-io1-f47.google.com with SMTP id k20so116764268ios.10
        for <git@vger.kernel.org>; Sun, 28 Jul 2019 19:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:mime-version;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=L0/3Icco1XbDVOTACpKP9n2Bm8ByJZOwDTa6btHWYj2d80MVt1om282BrdZlNN6/vy
         BhZ9LdqwKe81ZH9VvZ1GM38nmY2wR38H6OY9U1h/nNDiQeB3oqGyexg8iMjjW0IJzJFK
         FM0r8EDC+Qu6rP/ocjuzXnKHR8M9YlD7/H9c1v7Hq8tAqeU0S2a9unRvjmSymgYsxAOP
         XiJicoJq6CnIzMmuojmEcFJ1/TY21DpCDKwPojsH6UEnRwHBu7aJrb1o/dbiexXPuG++
         E7f/scE0zSwpeIXFdNKkAadK57OnIcjAv/XY5NAwO5kN3kKT04coTVh5nu0PXhNmpCNn
         mnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:mime-version;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Q8Gyd7bBzbkoNEEtW4PMqCZgea28x6lYpyFWZgH44qZ10tWHdXq+xU3jU71WwYbizl
         ts4g/aCZiRHfRrRQIbgbzF6LyPmB85v2TVmo9SwX9vCUKIiXYDgVfCaU7JY8Bw8dW+W6
         Ta12u8nClj5602IZpq1FeeazYk6Y0dyEQDc2XAvWvLKSHVQAU0EO87ClaNT9bokSkgnw
         cP11oJbH0oZdjjawgDL6y2+iB4gNQ0YK3SweXpxYEjTC8ogIcOCY6EwITKIWXkZGw1hR
         cMRBLuLb6G2fRfuMCUBvWDAUQCakSPgoOSpH3JI8mQSU62i/B1Is3OFJLg5ygfku8u3l
         HFrg==
X-Gm-Message-State: APjAAAVLAn0wExktxTuFnHW5oXZxF/wek4juPE4amjNB7aNPunZorx9W
        jqBBMlWvx5I1fgKkOBCh3KOwYz/0uTo=
X-Google-Smtp-Source: APXvYqykhYLMY7gfYFlJaw081cKTFO327KPiVV1KEjyyulJBOCqiH7V2O1GhFy7jlSO5EaavZeWKWQ==
X-Received: by 2002:a02:cd82:: with SMTP id l2mr109122021jap.96.1564368646812;
        Sun, 28 Jul 2019 19:50:46 -0700 (PDT)
Received: from [192.168.254.28] (184-15-183-12.dsl2.chtn.wv.frontiernet.net. [184.15.183.12])
        by smtp.gmail.com with ESMTPSA id s4sm78476980iop.25.2019.07.28.19.50.46
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 19:50:46 -0700 (PDT)
Date:   Sun, 28 Jul 2019 21:50:43 -0500
Message-ID: <cao5qcnieps35m4x4l6mi7kr.1564368627551@email.android.com>
From:   Michael Anthony Rush <realrush81@gmail.com>
To:     "git@vger kernel. org" <git@vger.kernel.org>
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

