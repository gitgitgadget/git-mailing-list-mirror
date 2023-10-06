Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148F0E94139
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 22:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjJFWpV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 18:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbjJFWpU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 18:45:20 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94267CF
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 15:45:14 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d894b8b9b7cso2390734276.1
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 15:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696632313; x=1697237113; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lmH1W3jpUf3VPdjFq48jK+/HQIijHD19FoYmx7cCRvc=;
        b=HGR+s9bwaGhr8ECur/G8AbiQxbVkVKS01KQWiX3ftrs0lWDh2TY0KX36sHzHokPcx9
         nN1Ca/QffohSAXSPtq4gkWeDdAQVlt6fA+3ZhaEgWiVYPf3ICk/yOa/kELr6Qp08gpY6
         9JzF0UIj/46cRm4Qh7HC8gspwZyYjRsnfQavH2mr//TUWQnsh4YWAQKG8kv2ZdRhprLB
         nKxcyZTNYAbIh3odJjI49VZdE/jMfcGV6/c0dLBl8w3z/obgRrApx+1sOL3M/Hi1e10k
         w07Z2E/lkOKPRcRvXXvkNmYamMo4jAJ8SqYrATGvtS/8T3ke+iByqr9QUX5/xeN7C/hh
         Cx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696632313; x=1697237113;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lmH1W3jpUf3VPdjFq48jK+/HQIijHD19FoYmx7cCRvc=;
        b=TafSdzT2N+S0iE+1IDWS1MP8w1Q5EJDOBfw1MQZHRglRudoYzFFqBuy1PeOYSuIwJX
         bzNA3cQMFtLp8HZohtNP8WPcBp/JQB+2yYMXsnBcKb0/D+kiMescea1l8rKwZ5xLJb6J
         onm1k2nSuygDlq/mddOEXGIZ4J7MLlLXeR/BW7y4twk/m698oyOPN/JhOUT3PF4mN4QV
         YEZo+KaTNJV6F4B2mGAZIH/+1Gp9DOS+zYtioikyQV1WpciN3CbFkaqvswWrhIgVhPsJ
         nVx1zxPgjEUZcahuKRjChcFjbgQs4gRxBzyrpEiM12QhDWjWKl7acLT9E3iCWjZ4G2QF
         3/Ig==
X-Gm-Message-State: AOJu0YwKz42XO/kpDfS9BwOzfJjgzU5V5NFBd1YmAfJuXYmYl9nd7Zrz
        XfjFcbc/DPCdP/eJgsK8Uys4eTIAXCDUqXkf8S4O89UY/epf0+k=
X-Google-Smtp-Source: AGHT+IFn/rBK2xWEjkeMcWL545Y6aUDWWSrnKB8snT6uIhuAyyEQFfR0pWyWfzuUc+5SSrcLs/+QtAZJ5NX5bB9OzCo=
X-Received: by 2002:a25:a287:0:b0:d66:b73a:8356 with SMTP id
 c7-20020a25a287000000b00d66b73a8356mr4714013ybi.14.1696632313148; Fri, 06 Oct
 2023 15:45:13 -0700 (PDT)
MIME-Version: 1.0
From:   Naomi Ibe <naomi.ibeh69@gmail.com>
Date:   Fri, 6 Oct 2023 23:41:35 +0100
Message-ID: <CACS=G2zsJxP+NWuosZyrFGctJptHNYTrULErRo_Ns41KeMuMqA@mail.gmail.com>
Subject: [OUTREACHY] Permission To Work On Tasks
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So I went through this link
https://github.com/gitgitgadget/git/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22
 and I found two issues that interest me.

First issue is here https://github.com/gitgitgadget/git/issues/635 ,
involving changing the "die()" error msg outputs to all lowercase. I
found a few files here https://github.com/git/git/tree/master/builtin
where the "die()" error msg had some uppercase in them (add.c in lines
185, 203, 205, 211 and 571) (branch.c in lines 521, 525, 581, 597,
599, 627, 629, 643, 650, 652, 776, 926, 954 and 968). If I'm allowed
to work on this issue, how many files should I edit? The last closed
issues related to this issue had edited five files.

Second issue is this https://github.com/gitgitgadget/git/issues/302 .
Is it still available to be worked on? I notice it was opened in 2019
