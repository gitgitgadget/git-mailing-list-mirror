Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A88B207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 20:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751681AbdFZUpp (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 16:45:45 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:33721 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751403AbdFZUpo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 16:45:44 -0400
Received: by mail-yw0-f174.google.com with SMTP id 63so5141300ywr.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 13:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=9Sss13oylh/ypZLR0yHw7SdSNgszUKP9oIsxNrTj+vA=;
        b=f/il0o0yBkrgQEXqvvO+lpvWE2a+eBWHynBGJJ44Zk0BZbXIT+XNsaeuLqn/ZEYBrc
         o2kTLWmfzyBd12HSWXyxaVHLcGgWS1gZ3/j9XnHT0mrjWjTiSpx9ZURpMv10tG6ATs8a
         QJF1BEtmA6gpeeEA3SsmlKOMMjdeq16qWwTm1iJ5/nvh6jKTdLZriwNhFPni+83L7sk5
         0Fs+3whVg0P6qEqn8ZFE2FZQTIm3r0JrPz7ofMVSBYBPzD+xw8I8mOaD/49vUpie7gkp
         SPWjiN/yI2fEeqxmjYlShajP2SqG37adO6AoHnLpjUvcrKA4+o2o+z5sX0lXHAyVWDbP
         11cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=9Sss13oylh/ypZLR0yHw7SdSNgszUKP9oIsxNrTj+vA=;
        b=g4pIpWORRdvIKIu/KfmsDRMRDJLeZtsf8HIKcUSjiWGDM6XDJE8Hgq4/fLepSAw5kl
         hczr7d6JHGCvTxP2xABmhKYpZgnLS/W09hKwhpF6lEPk5HvVZo1tZVRlqeg+Ltk4H61a
         UKcxQcf5Oo5FXGP2MhnnUYXP0jvWLMnDmII0J64X6K52h7oUozkKXbcaCU2H0n9ICHgG
         TEOXA5u2Ih3rDJlJFZh0Aj3gyug+pYbLqRz4CE+3Axpa0gytGGlTnHF7gBGyeyxyW/PE
         tEWjaIwp5W+8tYtYfDdKdsrM0NGaTEKBofummLte8O2+Xhx30pPXMtHxGZDTYsQ/nPmy
         qlpw==
X-Gm-Message-State: AKS2vOyPDEAJt5HwyQnSnEv41Bd1jTqm2REXZQ6vdmzQJLqhF5+ctvkY
        qr2yHvCURFnTAAIpmBCfgBef+sym9qdp
X-Received: by 10.13.206.4 with SMTP id q4mr1549184ywd.152.1498509943063; Mon,
 26 Jun 2017 13:45:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.83.12.79 with HTTP; Mon, 26 Jun 2017 13:45:42 -0700 (PDT)
In-Reply-To: <CAHaNChewK_4a7sPgZqWTNSmchiSbKOJUrpCrGLmcnR+cw6J5qw@mail.gmail.com>
References: <CAHaNChewK_4a7sPgZqWTNSmchiSbKOJUrpCrGLmcnR+cw6J5qw@mail.gmail.com>
From:   Gyandeep Singh <gyandeeps@gmail.com>
Date:   Mon, 26 Jun 2017 15:45:42 -0500
Message-ID: <CAHaNChecHzZqzafe4P85Kz4BtJuisO+krCvm=yPW9wGMXWJK_A@mail.gmail.com>
Subject: Re: Bug: Cannot kill Nodejs process using ctrl + c
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Environment:

OS: Windows 7
Git: git version 2.13.1.windows.2
NodeJS: 8.1.2

Steps:

1. Create a js file with content

const http = require('http');
const fs = require('fs');
const port = 3000;
const app = http.createServer((req,res) => {
    res.writeHead(200);
    res.end("hi");
});

app.listen(port);

its a simple server running on 3000 port.

2. Run command "node ./app.js" inside git bash.
3. hit "CTRL + c" (2 times) to kill the process.
4. If you look at taskmanager, then you will see a node.js process
still running. or if you try to restart the server it will say port
300 already in use.

Notes:

1. This was working on first version of Git 2.13, it broke after the
first version.


Thanks


Regards,

Gyandeep Singh
