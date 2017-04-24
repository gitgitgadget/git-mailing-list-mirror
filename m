Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 412EA1FE90
	for <e@80x24.org>; Mon, 24 Apr 2017 11:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971414AbdDXLGB (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 07:06:01 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33914 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762479AbdDXLFS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 07:05:18 -0400
Received: by mail-io0-f193.google.com with SMTP id h41so48298428ioi.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 04:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47+B9ytLgxnHidYMNAG5IjW/mj3JXj07MO3S1+ye3Ko=;
        b=U7TfPEm4Q9IK7gW3kNBjrmKFUVjgWGMIfelnKWpa3MjKCuiI9rHm9sEQj7NolYClep
         CQ0csikouJ7rACHJ0W8pbDm/ii6JH6hEEFGnaA7QFB8JnArmt4exclHREiTS0oGUEJfb
         GAl4KXnMEYsv6b9QYSFO6rRCN+23ZSqHPycVTVDkFmjz9tU8ueV9biRtm1oXl8AnIYiW
         UPR1LEaw9s8+Z0+cou+ERhsqhsleg3AmTENWiVqBL7axnyCkm0Sl5t5xVvi38Z82G8L9
         FrCAGAoxnYS1Hb70RUZJApc1oXnmuuXWvVkQHdiqyivOslQeSGiOa+0zS3EMM3AP5jkk
         1R2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47+B9ytLgxnHidYMNAG5IjW/mj3JXj07MO3S1+ye3Ko=;
        b=bb1gyNW08/Kya5i+CtVPQ2FNHul+WsD8JzwKo7RJebhT+/5QP0Yh7ABO5G0+UJ7kDw
         d/H/wDmIq2iFfMRN+LN6ga7x//klkmbfOwq0C0uUVUETCQxjf773Ihyca5Tpa8ORNuEz
         UfyGaGZEJxns/zAQz9dEKIMcFElc/jTw1cBJB3iRqiqwWG6s7LkyV6Mfg0B5j+YL+myC
         /B1w2VbyKS9pNzmpwMTmP41iHVWK4/uBc6MmDqFj0E0Dm9ftq4QAhVx+vhKlwbOhcGTB
         63YIVL+0jWSJHF6zk52OvVqbVns18zxKNE0TlWAhoEcQ957lp5Snn0WZBttz+D+ZJD1/
         wdIg==
X-Gm-Message-State: AN3rC/7sZ45a/eHRH8ejSgm/QKHyHmBwd193dJlYuCCcAVNv8npETSmu
        Tk8nii6M8UOM/g==
X-Received: by 10.107.154.206 with SMTP id c197mr5949214ioe.109.1493031917879;
        Mon, 24 Apr 2017 04:05:17 -0700 (PDT)
Received: from atris (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.googlemail.com with ESMTPSA id y23sm4201865ita.9.2017.04.24.04.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Apr 2017 04:05:17 -0700 (PDT)
Message-ID: <1493031889.29673.19.camel@gmail.com>
Subject: Re: [PATCH] rebase -i: add config to abbreviate command name
From:   liam BEGUIN <liambeguin@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, martin.von.zweigbergk@gmail.com
Date:   Mon, 24 Apr 2017 07:04:49 -0400
In-Reply-To: <alpine.DEB.2.20.1704241225300.3480@virtualbox>
References: <20170424032347.10878-1-liambeguin@gmail.com>
         <alpine.DEB.2.20.1704241225300.3480@virtualbox>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.5 (3.22.5-1.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, 

On Mon, 2017-04-24 at 12:26 +0200, Johannes Schindelin wrote:
> Hi Liam,
> 
> On Sun, 23 Apr 2017, Liam Beguin wrote:
> 
> > Add the 'rebase.abbrevCmd' boolean config option to allow
> > the user to abbreviate the default command name while editing
> > the 'git-rebase-todo' file.
> 
> This patch does not handle the `git rebase --edit-todo` subcommand.
> Intentional?

no, this is not intentional, I'll make the changes.
 
> 
> Ciao,
> Johannes

Thanks, 
Liam
