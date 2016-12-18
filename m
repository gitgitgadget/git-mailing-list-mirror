Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 586781FF6D
	for <e@80x24.org>; Sun, 18 Dec 2016 12:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760810AbcLRMRd (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Dec 2016 07:17:33 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33352 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760585AbcLRMRc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2016 07:17:32 -0500
Received: by mail-pg0-f68.google.com with SMTP id g1so3490048pgn.0
        for <git@vger.kernel.org>; Sun, 18 Dec 2016 04:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=86Xk2NFQZfrppdnIr0TcNaSqdQcrUoAI95Hghe0Jz90=;
        b=sJXSZNHtmQqRtRQJaCZfGFjVh3Bg0Jc8nsK0IJnLhqgee2QhtAMzwkVGAtFFVyLElZ
         lDAAa1ANbYyah+osNW06Ybfb6y6/sgkXljVmVrE4qtQ6/PqElykf6Xu/6eBeo6c2HOtE
         +m1JNoFgAX9Awr0yMU8ShhsldtvYshasxsmttk6aj3GOR9HZVKRfAXQGAOY2agi+3RMv
         5TyLQPAZFa0D/sLjCoIYqfuOfpOJPk3r5df2omcfVmhEE/OC/Q5eFZJRZjjPafVJQwXz
         vl05YR/FHOK0BwQNfH7URBPdvMYBTCWZVZunK7fgUgOz6hAjxvZAYMZHhK8kQIPt7jQO
         Mgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=86Xk2NFQZfrppdnIr0TcNaSqdQcrUoAI95Hghe0Jz90=;
        b=RLh3cKqSeB4n2pM3Kpt5QLavwUr+p953KaEBlxuqcgRo+y/IlH2JbDfHxGvn6vYvzQ
         QMuNEqfnG8kaGrjXCwNg9K/46KxRriahBYvrKV6c5WiTnmTmwfjMCokt2vTw/8LWjsO+
         ejScqCxSIKXXvGb1uvmC8EkiQhDyiAjkk7eItlZXJIBWe5+g01jzyLq9qqCmAhrCyYma
         wUFusGWQ32wLh/VVEgP5qmnijAyz02xi3BNQiMQqjAHP0FXP1N/xzDJb59SLoVkrrCn7
         X/91eufFpc2aFB9zkdJuZ+4L0dFd+DvG8CCs2a126L5pCDZIpGBfnNDjEl7EuR3XjgyG
         sPfw==
X-Gm-Message-State: AIkVDXIw/J0Lk7GMC+G4KPkW/kyUWckG24sHRgAH9XSTWo29QY/ehnnbzCpgZwgsFLkFXg==
X-Received: by 10.99.143.72 with SMTP id r8mr4784694pgn.128.1482063451507;
        Sun, 18 Dec 2016 04:17:31 -0800 (PST)
Received: from unique-pc ([14.102.13.66])
        by smtp.googlemail.com with ESMTPSA id y29sm24135859pfd.63.2016.12.18.04.17.29
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 04:17:31 -0800 (PST)
Message-ID: <1482063500.10858.1.camel@gmail.com>
Subject: Suggestion for the "Did you mean this?" feature
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Date:   Sun, 18 Dec 2016 17:48:20 +0530
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I have found the "Did you mean this?" feature of git as a very good
feature. I thought it would be even better if it took a step toward by
asking for a prompt when there was only one alternative to the command
that was entered. 

E.g.

> unique@unique-pc:~$ git hepl
> git: 'hepl' is not a git command. See 'git --help'.
> 
> Did you mean this?
> 	help
> [yes/No] : y
> usage: git [--version] [--help] [-C <path>] [-c name=value]
>            [--exec-path[=<path>]] [--html-path] [--man-path] [--info-
> path]
> ....

This would make it even better for the user as it would avoid having to
correct the mistake long commands that had only a single error
(considering history feature is enabled). 

Is this is a good idea ?


-- 


Regards,
Kaartic
