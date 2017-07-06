Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62783202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 14:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbdGFOro (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 10:47:44 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34524 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbdGFOrn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 10:47:43 -0400
Received: by mail-wr0-f196.google.com with SMTP id k67so974532wrc.1
        for <git@vger.kernel.org>; Thu, 06 Jul 2017 07:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=LMuXMM8CmN3lro7teELWgIetfqYlyOgKEmX7+zNrjjQ=;
        b=tXb8QhZMCuUrzJXZ5Ls/GNUh0WRswW8vxQnA5HoYrF65E+2xSI4XF6rXHncq49zfjx
         dSZZyFrHXXK+A2mCUGKHxUycPFkpHz00w485VBszGqz29TwkKQk1G9kP/JFodrnofjoR
         vzIi8I+ltB4l+bMMVLqQ+XBCu8SknsXVvT1vg0o7seBomcB1OZ8f/cWn593swViU6N8M
         aQznXctJyi4pp8o/SArmy3DhRMSt7y2+yyN6kZHRCJPyERG9WrK1KeCzIo0fN1VviUpK
         2B9lwuAvY2f67zh29XurrP+6EXmQTDPmJ7gThWRP2an19IobDGE1r4lOjG0zZDkKvcM9
         tsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=LMuXMM8CmN3lro7teELWgIetfqYlyOgKEmX7+zNrjjQ=;
        b=Wob3dU1LtoIYbefEuszJ8IovuEclorhmKuLCnps4fAgP3KF4rH8RaW5HKSdaQbTzBL
         /OP7e559q73rQ//eNIT9YrZrpE1SOfFv1A1RofJPZog2bnPDfFqVUHIZekeOj/Tldhwd
         7XfJdgRMnWYBbCCMuEu2xOWAKPYRHlcT7BhyO6BHbKq6GLaI3hD+pEHQjdRmN1/ZXeX9
         5G/x6Eyh+oLgDH1jG3U4bSOcVyI0jjyZ6WDVzcqwGlce57OBZCjpOt6HJ+7KCdXK14EW
         v7VhrKs7lt5X8oHWojZUNjISbTNRfxWMbMXqwUJLyBh3Cluo639DVL5QqWioqx2zeFB/
         WMfQ==
X-Gm-Message-State: AKS2vOxERE7YTvKSagn7/uPTWBKuJBffeezzk+hty47FCfh07DhkiKuu
        ynpdQ9MWmVunOQ==
X-Received: by 10.223.150.89 with SMTP id c25mr40456273wra.15.1499352461962;
        Thu, 06 Jul 2017 07:47:41 -0700 (PDT)
Received: from localhost.localdomain (x590e3e05.dyn.telefonica.de. [89.14.62.5])
        by smtp.gmail.com with ESMTPSA id c2sm368990wre.22.2017.07.06.07.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Jul 2017 07:47:41 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] comment: fix a typo in the comment
Date:   Thu,  6 Jul 2017 16:47:11 +0200
Message-Id: <20170706144711.31002-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.2.643.g201124e73
In-Reply-To: <1499311044.1776.1.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Wed, 2017-07-05 at 11:18 -0700, Junio C Hamano wrote:
> > Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
> > 
> > > ---
> > >  Though very trivial, I wanted to correct this as I didn't
> > >  want to ignore it after seeing it.
> > 
> > Thanks for sharp eyes.  Sign-off?  (or Sign-of? ;-))
> > 
> I should also thank you for your sharp eyes!

Speaking of sharp eyes...  That Subject: line really needs a
s/comment:/commit:/, doesn't it? :)

