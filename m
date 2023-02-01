Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8EAC636D3
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 23:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjBAXkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 18:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjBAXko (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 18:40:44 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288885DC36
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 15:40:44 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id bx13so48387oib.13
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 15:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SkTrTEJ0/4bFY03f/p9xfj33VElAh/I1Mw5tXsgsPtk=;
        b=oKgihsh5srkQoRnaD5KQaJGF+XGuhtseiBk5Wtw4Y8ammDHssz7rvbEq1LEpJF9gBK
         hCvniGse2/F3CF5VGhPGH7xvZ7d4dm/icR38ieGTHIvTfTGmOMWpvaw9+zC/0PuWfARf
         zVmtjOjSZUXIDmfsnsOWfIsI9XtDJi25Egk7zKzERBMspNJhTuea7d9ly7Vxoy9GM877
         /Up477XQg9s11fh3975I2JRQ02mW5e9QjTWDKIy19QUkmh5PJVvAs5HFAeh+cRD0iZsU
         +4IZR7oIuUJg5lNdeW3vehWdfbKDCQMhZGX5WuV9msMlYe0zKmGgQKN7JN399VL02Ds2
         KUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SkTrTEJ0/4bFY03f/p9xfj33VElAh/I1Mw5tXsgsPtk=;
        b=4IbtiKcGVyI4ORSz+IeRwx3Q+DEkhjEcuvJckZ8kYsXwDDRhWuRrMi4B5SJtfj0C7A
         kuGjUJVznYQdiCV1vsrPF1hH6IsKOwYFyhMFYZw/MyM6+2sHOkkMPQG5rI43nT4gbWRt
         sBTZcA3UCXz2OP1CkOhoneyH7DDJ3T/1b1UoJ976/uPTz1v/bAYRy5np/3BHRxzIUzpL
         mjygtpbhT9H0YooNvkknmKVDpAzI/R557RQbqCJhgAFHMzdnSlhU2qI9lMoPp8ApmYrc
         Vpd6Zy77b/qmzX6rXPFpxndH+rhTXx4kwxjkTX7xsAKYnLbhAkSQtORt/tdkBq2zUu2x
         hkRA==
X-Gm-Message-State: AO0yUKWTHB0LN5FyqlYliK8KaZCQHv3gtXQQRpgxNpSR3hMr5FrZIlcg
        bK6RAED+fk+cgqcOCxXPhKN9g+yCdM/xX05VXbBUcpDiaH6Jdlcq
X-Google-Smtp-Source: AK7set/wVyCyDxFFmibcThQDrEuNnY2ilZPdjUTGYS5nLjJjNUlK9QwUIAfJxtg7LMFrl5mnU3Nxq/5z5G4mi6lJz9E=
X-Received: by 2002:a54:410d:0:b0:35b:29de:894c with SMTP id
 l13-20020a54410d000000b0035b29de894cmr28153oic.295.1675294843286; Wed, 01 Feb
 2023 15:40:43 -0800 (PST)
MIME-Version: 1.0
From:   Sukhman Bhuller <sbhuller@atlassian.com>
Date:   Wed, 1 Feb 2023 15:40:32 -0800
Message-ID: <CAPbKZMNXCPLrbe7DCifRh-tszk6+FpcRTrfvkWvFnz_gG8_T9A@mail.gmail.com>
Subject: Git Security Mailing List
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,

I am a developer at Bitbucket (Atlassian). My team is responsible for
all things Git here at Bitbucket. We were caught unaware by the recent
security patches and realized we are not on the Git Security mailing
list. Is it possible for me and my team (~8-10 individuals) to be
added to the security list? If so, I can provide the necessary email
addresses and other information that may be needed.

Thanks,
Sukh
