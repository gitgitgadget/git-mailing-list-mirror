Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F844C761A6
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 17:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbjDDRPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 13:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbjDDRP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 13:15:27 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7822683
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 10:15:02 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ek18so133551995edb.6
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 10:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680628500;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iFSghdiCNRALWM+gvl3WlYglQ4tT6kPEZBTdjQLR1uU=;
        b=o+4ttZLLvdTwTYxu7sT3TYPwHKQBsS3z/vCTG7ni+qqtqxSGisxG1wmUmduBffwduH
         LDeZtbIKsKlQflBOiaadXOYH98qDiF80eRErXxmu6HUfAHP7u4SXc3MW/VvI81ojUTWp
         AC3aKl6RlMfpsJnRYXF813nfHu+fl1oKMJx+A0yHHc97Y4Oh5qmBKAd4KJY5p5gj9zx1
         1RzqG/0uLAUdCZDYUE7RKh/cF3MbKVepIw4VOJuZ+sx5U7T9mrPdTZiZu/KRvuV+LSew
         /KrQxKQ4smor5rTWdPU0XyMcP9nL5abagGT6g2xb+kqIELYC5ql+1en5pemJquB+j+Mg
         BPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628500;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iFSghdiCNRALWM+gvl3WlYglQ4tT6kPEZBTdjQLR1uU=;
        b=agWMtGZcPBgwhdcOpRSkjjTefKm3dFZeLs5R75JM9oJTrBjZp3ywrbjP6ng27A1P22
         SpPH4/0ctKl7R25cs+cwTUMcq6kxHxgMo1TI1DllBOOxaL/zBqKHZWfopd0No27E/rAw
         iKtDnBdOxcMFQOoohCct56+pBAQLrZ6VpcRhTSq8V5vpqqC52vqOeOVb6VEimeGx3GT6
         SVxWh2w9kt7zdZB/pNXQb93yK/EM2id9HR9AspRLMIa1sddR98Pb6cOeMd2MjlROxOxD
         bPTIC0BCKhaiUX+ekqJqfoYaCRU5WYz46/iqk58FpYTVhQPq4/WXt1iJtv3OoYAbwN2G
         ScKQ==
X-Gm-Message-State: AAQBX9eoW38mX5fDET5V1Mw1LBo353Ut2AbCe+d7MF+EosSH8/1YnWO3
        n3m5W/rMWgwpn5BmDhGXC+W+KplbLi5gybrkW31fNGSO/26qKI3Izsmn5Fz0
X-Google-Smtp-Source: AKy350ZWQKyXu9fxESjWud/w3z9+y7o1kbO5eePJI8cHhYJmMDPf1NT51fo4lD2tr7zE+7g2XW31qLLTWSAwukEVnVA=
X-Received: by 2002:a17:906:fe43:b0:93d:1b82:3c13 with SMTP id
 wz3-20020a170906fe4300b0093d1b823c13mr146534ejb.7.1680628499701; Tue, 04 Apr
 2023 10:14:59 -0700 (PDT)
MIME-Version: 1.0
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Tue, 4 Apr 2023 10:14:47 -0700
Message-ID: <CAJoAoZ=q6ppzErzBT2VygdHbfhezYtFSkM3rLtt+gTvdSrLEHQ@mail.gmail.com>
Subject: Video conference libification eng discussion, this Thursday 16:30 UTC
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello folks,

Google is hosting a standing engineering discussion about libifying
Git, for contributors interested in participating in or hearing about
the progress of this effort. Expect this discussion to be free-form
and casual - no powerpoints here!

We're hoping to hold this meeting every Thursday at 9:30am Pacific
(16:30 UTC) via Google Meet.

To get an invite to the video conference and the notes document,
please reply to this email. Please also add points to the agenda
(template follows) if you want to raise awareness of them.

I'll reply to this mail tomorrow-ish with the topic we'll discuss
during the meeting, and I'll reply again afterwards with the notes.

 - (asynchronous) What's cooking in libification?
   - Patches we sent regarding libification
   - Patches for review related to the libification effort
 - (asynchronous) What happened in the past 1-2 weeks that interested
parties or intermittent contributors need to know?
 - (asynchronous) Where are you stuck? What eng discussions do we want
to have? (We'll choose a topic from this list a day ahead of the
meeting.)
 - Session topic: <TBD>

 - Emily
