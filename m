Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_RED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAB7B1F462
	for <e@80x24.org>; Wed, 22 May 2019 22:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfEVWSj (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 18:18:39 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:33098 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfEVWSj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 18:18:39 -0400
Received: by mail-pg1-f169.google.com with SMTP id h17so2023628pgv.0
        for <git@vger.kernel.org>; Wed, 22 May 2019 15:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GzrdWwNiad2oGD9AS5+kO1gvKrcJsvpzDVH2U/QJpAU=;
        b=ngBSwbjgDToglVkU7RdLXrOUE/t/mmsOeHDSAlqdyr+5wONFmE/vemsLZ3hfHR9jYi
         uVLY8jLiw6hfdYzk727FexABcOjfFAbIEe4qC7UtSjUdZT77BBud2Nzu7Tb4W6XyKhxr
         XdEVSc7PLIA+zksPFcAfu+2RdkEyM9sbkSfN1bUfUm6Vz9Zm9R8KSeTgBYbYmtuyPWpz
         zd8+lsP9elTeJHxsFak08jNCNxukg+NyvVISftFU+gd58BWtfuCJdx78Ig/S2nQjb8/z
         3yDOsrqBXce7ouPkoaeGMxKpKAzGXaXcA/VmmSJVufNbkT4WOkEgGYc7TjrFPlbg8w80
         Z0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GzrdWwNiad2oGD9AS5+kO1gvKrcJsvpzDVH2U/QJpAU=;
        b=Mh4RrPiEsPWY+LEnt/VgbB3Yx4ErKlbyZ3DQl6jNKsgaX1UK663+KsPv8emYOK71yL
         93fA6uRqdUxGPRrWjRH+vZCGt6YprfJhoAxO1lklDi7J23IQ7tT/etSZbjHaXRm/1wOT
         OeKGfoPbR2nNdM23hjBXHs5UNjprTd7NEH5L4lAZjOBuyUhg36YdvPwM4o0lFjKzkCNF
         t0rBrbQErYFi+hqbTRBuMX1yD8SWDWgXHgOnwhRL7eadNGJqSqnCwVMB/6r4psDzDcG8
         KBd3Ez3jY2C0UBaisvrDof1xYJ+PtnpKX8O1VK716tWXgPxiuZFhXO+fRnVhiscUlJt/
         I3wA==
X-Gm-Message-State: APjAAAWS590WWqfzrN1yyuFrT0Ud3SAJW8Ixa/XSxq1hhHObx3R3iXsn
        HVnQoW8AgRCOFJIGwmnHXGk=
X-Google-Smtp-Source: APXvYqxCgY+9gXveX1I+/9DVPMD6ckVYQqfxLwXy0n0Jz8fwYiLp/Ero+It7oUOdkwdadJW1d/HE8Q==
X-Received: by 2002:a63:d252:: with SMTP id t18mr93846276pgi.131.1558563518792;
        Wed, 22 May 2019 15:18:38 -0700 (PDT)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id u20sm33840070pfm.145.2019.05.22.15.18.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 15:18:37 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        matheus.bernardino@usp.br, newren@gmail.com,
        olyatelezhnaya@gmail.com, t.gummerer@gmail.com
Subject: Re: [GSoC] Blogging with Rohit
Date:   Thu, 23 May 2019 03:46:56 +0530
Message-Id: <20190522221656.1473-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190522221319.580-1-rohit.ashiwal265@gmail.com>
References: <20190522221319.580-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

s/How/Hope/ 😅

> Thanks
> Rohit
> 
> [1]: https://rashiwal.me/2019/to-pick-or-not-to-pick/
> PS: comment section is now working, please leave your constructive remarks.
> 
