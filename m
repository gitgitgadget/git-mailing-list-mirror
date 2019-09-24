Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B84CF1F463
	for <e@80x24.org>; Tue, 24 Sep 2019 10:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408111AbfIXKWd (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 06:22:33 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:42644 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405224AbfIXKWd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 06:22:33 -0400
Received: by mail-wr1-f48.google.com with SMTP id n14so1289118wrw.9
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 03:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mat.ucm.es; s=google;
        h=from:to:subject:date:message-id:user-agent:mime-version;
        bh=iMAPfzlmjdTiVsZq7D572DHr02otd87+XN9y2cb+rOY=;
        b=O6QjY5729J++cFNeZ64140InM2bHmU18bQcwBDjVCbI0ajE9g+A9T0ZMay6FEVOcQ4
         hhE2awF8vw2IiPz1M+aadjwERrWoZOW8VruaVquAELHoRhvW3N8JtzZBWfo2MnRRgyRF
         gCsdx5vrUdVfHBsw0aJpNl8CnL6TLv/o/3jRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:user-agent
         :mime-version;
        bh=iMAPfzlmjdTiVsZq7D572DHr02otd87+XN9y2cb+rOY=;
        b=TZrb37Tp+WEnEqGRxPIGiyx+6gZ+CS+cFMNV+W5HcvYQ3fCXEOtl+zsDliiaGzaXmZ
         +czuwPEaLGwFXqREb6nITUaf6IccdXuvX+M/18PovpnnMFxGR0iaUsLUrX1tjuAxIgSF
         1yROr7sPV1t3+YPaGw0+QxK2/fQti48AjYbtrjMCB1RoatxtBpygZ6ED1qCoRbn7LSWT
         4JpL0fbcRc6eeFuFvqWGsmFP5ercpT0O+34OcY5y72dJQCwnrXP3gqVn4sIXDfDI/I17
         3xB5w6vM91WJ7hGFzfPP+Q+PMPJnY6hnshdZNrPsGruG28vZ8P8bTnqEO7oz/0aQVDBo
         kCSA==
X-Gm-Message-State: APjAAAWvUWdQ950livD/MBovDaf/X8qzjLdsAYtmoz7l7vFwvx8YLOG4
        hTHRyo6zCBQQmlA7qq7s3DV4X2JQKYQ=
X-Google-Smtp-Source: APXvYqzzUtoL8YDjSvsl4QWk1Vx6Ayml5BmqqWudwFKuVqU4X+/LHotA++CQ5E5CLEB4h4Vm0yPocA==
X-Received: by 2002:adf:f4cd:: with SMTP id h13mr1637006wrp.42.1569320549542;
        Tue, 24 Sep 2019 03:22:29 -0700 (PDT)
Received: from Utnapischtim (gilgamesch.quim.ucm.es. [147.96.12.99])
        by smtp.gmail.com with ESMTPSA id e6sm1571243wrp.91.2019.09.24.03.22.28
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 03:22:28 -0700 (PDT)
X-Mailer: emacs 27.0.50 (via feedmail 11-beta-1 I)
From:   Uwe Brauer <oub@mat.ucm.es>
To:     git <git@vger.kernel.org>
Subject: I just pulled, and git log --graph does not show all
X-Hashcash: 1:20:190924:git@vger.kernel.org::waBMGRYtgBLGyK/k:0000000000000000000000000000000000000000000lYU
Date:   Tue, 24 Sep 2019 12:22:27 +0200
Message-ID: <87sgomyows.fsf@mat.ucm.es>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org




Hi 

I am confused, I just pulled 
but git log --graph --decorate
did not show all commits, 

Only 

git log --graph --decorate --all

 and from the emails I received the commits shown by --all

Should be on a new branch.

I confess I am a mercurial user not a git user, 

What is the reason for this behavior.

How can I now merge the new branch into master?

Thanks

Uwe Brauer 
