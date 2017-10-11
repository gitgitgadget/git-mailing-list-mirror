Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,PI_EMPTY_SUBJ,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CBE520444
	for <e@80x24.org>; Wed, 11 Oct 2017 20:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbdJKUZQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 16:25:16 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45552 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752275AbdJKUZP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 16:25:15 -0400
Received: by mail-qt0-f195.google.com with SMTP id p1so9055683qtg.2
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 13:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6VtRYzb/W5bsbzq5pWnJeGlHmbPlu6KgS8Qww7l5uG4=;
        b=JvnUyJv+F1WUOa2dZNMogAKyshUMDKi0pPxOx87iU6+8C/C4bxK0Ji19eK27AoigFc
         TwC2kN2vbASeH+REpc0v57ixDewhhCc/kZhK2p75ZmMRbjEo747oWAPK9/NKmRTTSDP3
         rhfk+g92pcMjnPOyxKVWubjvitjwQVPCTG7q48GfTP59YepS5KnNRjyZmq7YHuQ2aZKO
         MqP2PAu5Oq8xD8RCOygUTGot52Oq83SIOcJEu5bvsVkiJSvBWaThtyPaYRcxkge6R7w0
         UJTZBKwiA5BW6n9JCWr6EqUavtDu8lhkCMdq7ZfdPC3V3CiYOROqlAGYtn81aGo326un
         yoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6VtRYzb/W5bsbzq5pWnJeGlHmbPlu6KgS8Qww7l5uG4=;
        b=CHdyT/U0oa7KDj9N3snnCn+0scvGlQsewlKASz2fyiPZvu0ioDZga986HC5wlvLncV
         MgYBYFq5NgCPM5ox7LzzCKZeSh13pLT+77xwzVlp/yp4H2UCWfpRFHT45JVwuaUIMftE
         /acDxKlfqsA9PdQSu8HEWB9yWEyO0wKYz6H7kwcH0TZ3mSL8XTwj8VzdtvqlHX9RSqIU
         nQ7JHmH21mejnmL2g1ocpKY93qSKXRs4KhyjFrBaNM6H4EWw19VT7hFjtSGkGdQFkoCd
         kO6kX0TkVe2tQsw+++JCsZozq0ckrfzOE/agio4a7/aRgAdlMh0uoFn8/ubHdIuSMtQ9
         H15A==
X-Gm-Message-State: AMCzsaW/SCML96ar6mHyQL/Ul6gSodN/MjUpWPhBhKobeUeo9Wz4f70S
        /zEbmeCVo3r8TJO3BV+nSUA=
X-Google-Smtp-Source: AOwi7QADxoZKvU69ah7QKixYPoo1Y2ytz75q6SIOH4QBJryCNtvzxG/Bt4RiVws3dPUeM8audLeDLg==
X-Received: by 10.200.63.43 with SMTP id c40mr323357qtk.219.1507753514605;
        Wed, 11 Oct 2017 13:25:14 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f2:2a86:eb6c:5bd5:d213:6456:b036])
        by smtp.gmail.com with ESMTPSA id m28sm4780245qtb.55.2017.10.11.13.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Oct 2017 13:25:14 -0700 (PDT)
From:   "Thais D. Braz" <thais.dinizbraz@gmail.com>
To:     marius.paliga@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: 
Date:   Wed, 11 Oct 2017 17:25:04 -0300
Message-Id: <20171011202505.10113-1-thais.dinizbraz@gmail.com>
X-Mailer: git-send-email 2.15.0.rc0.39.g2f0e14e.dirty
In-Reply-To: <CAK7vU=3whGsx4L4KACSC+XDWQEbUWuZZZqTsW2R=CbF8d7rkuQ@mail.gmail.com>
References: <CAK7vU=3whGsx4L4KACSC+XDWQEbUWuZZZqTsW2R=CbF8d7rkuQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'll still try to make the test as suggested to complete this demand

