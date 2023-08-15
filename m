Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3ADC001B0
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 17:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238951AbjHORtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 13:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238950AbjHORto (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 13:49:44 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A794E1BCC
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 10:49:43 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40a47e8e38dso29731cf.1
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 10:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692121782; x=1692726582;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HLvjDk3PlDRGvo1MXhlmyEQIrCHjIwrPWAyaoHxgNmI=;
        b=UitisEknTxtYpaaMnehgKrNZ7iVus5QMd1NNVH5wGm0SKCtFTctZuoGlwz0iOq1lfo
         YBjxvSKt4yx6uCxOMItKEM1/9LsblGwmruo3qY8XiC7MNqsGaMfuB0HLY7fzk70Bb+r6
         YTh+CUubHTn6hpsw9JornoZ6iV37EJwVSQiDQslJsh9hA+jCUTgROimn0D5ROrWbhplo
         aMd7gEn5oKm6bJKIl6YqnTgW+l5wf/9qe4loSfw7rFAEkwozmoWqzhRuXS0ouKtMg8Ns
         quJVaub+mNDaQIOdy4f8gOLKMg/EBRLVXK43mRZlbIYGF/BwENF/wgQOBmErMjyvZXHG
         w1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692121782; x=1692726582;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HLvjDk3PlDRGvo1MXhlmyEQIrCHjIwrPWAyaoHxgNmI=;
        b=RscXIGNyLj/ItpU0sQ0NbJFZ2F1wU2+Z00oaN1quLUn947nQVRb2Dq5d+XKkWMRhsd
         nik16yTCNT8WJLlZUF74kodizepoGhENSzg4MN3lERbuNaWXPXevM74k9VNGxrb0W2zI
         flbmLqa0y9BmdhiU/l19OyRT/fpZpooEJQ4IVKDz6S74FVVvKJg2c0R7nj4GpNtQoVh0
         +qu39JzggXseWGxQZxHADOiXxZSxpRIYr/DUWGPeMSjJXEW5jCLPPtfRo2lPgSYNEYc/
         7pnfGWNKXygp/J+6iSIKZiFmwMnmFHzOel365iFAUuSWtWkRbhN4YDIq6t/USj4IsTPq
         cf+Q==
X-Gm-Message-State: AOJu0YweQrs8FPAEMYpPyanX4GnnUjalQcvWgBspXq8b9040tlYp5O05
        h0pIroIZfU4vW+4FKQTrR8qnnwWJiYi45N6NqzELvxyYpXwDQTk+eQs=
X-Google-Smtp-Source: AGHT+IEoGjbu8JyEh3ICp4b9aYSZcuRQaupUbR+iDs9CmcFGdw4YYg2sqmCyGhNoVplgQNNpPu0auZ40mwayEH6xCaY=
X-Received: by 2002:a05:622a:156:b0:403:b6ff:c0b with SMTP id
 v22-20020a05622a015600b00403b6ff0c0bmr28477qtw.6.1692121782440; Tue, 15 Aug
 2023 10:49:42 -0700 (PDT)
MIME-Version: 1.0
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 15 Aug 2023 10:49:31 -0700
Message-ID: <CAFySSZDpzywKv01ZzFcL2xY2Eb_Sjm3cWqQGAoecPH_79tQ+XA@mail.gmail.com>
Subject: No Review Club this week
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since Glen has left Google, we'll be taking this week off from Review Club.

- Calvin
