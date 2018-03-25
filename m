Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 952521F404
	for <e@80x24.org>; Sun, 25 Mar 2018 16:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753726AbeCYQ66 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 12:58:58 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:40059 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753525AbeCYQ65 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 12:58:57 -0400
Received: by mail-pg0-f54.google.com with SMTP id g8so6408470pgv.7
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 09:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:to:cc:in-reply-to:from:date:subject;
        bh=o73FdaCGQwr5/9S1K1IVEALX/k80di8h9MYX0xoqb3E=;
        b=ZUW+Jl2/hCiNZr9kpa+gLJ5HxSRsObCYatk+pru6U/AGf7KycOTfjsoGzl6SHdS1ka
         7FmCchUxtwhGYi7hfmheskEZevdrbDNrkhhWUgZ21U5rY0v4wd+1IMLwXlmzEqbIw3MQ
         4ciB24rjdf05lqOYnUKuSd0Ms60p+R3l+sGFlcd1dfiaI0ZBMws7VetLZAJKBBSG0txb
         QKN/qkh1iSZdZF/TD24tDR+0rTaqjUqdsZhPuaddTVfjRRki+M4/IK/zEpDVtFXx8czo
         25slVfSHAGzqyalUEqnM5XZ26+UEhc/9gNYM/aXlv/TTV0xyRJOL1bcDvODqCKamR8iH
         WxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:to:cc:in-reply-to:from:date:subject;
        bh=o73FdaCGQwr5/9S1K1IVEALX/k80di8h9MYX0xoqb3E=;
        b=UteUvd05OlenqEY+XKiPFuaVsGYuwM25jtwsLPQxbeIl0mu6+x/N98pIouFPWskUVR
         4CwhJuQBrOIAgBLijijONwtchMEFdUP6jkKf+xt0yoJm6wAUQNqg+dNnCCJx1dx5vn8y
         ++Q09DNW2poM6Jw06lrQC4WOhd9T7A0oZJ1I//kpAoaPE/fkkxGb/NbsznM6MSsJb8a0
         8WndEjfyKV4zicxvGh0YenjFVElY8CDXUv08WSNr1Z64LBgIdG0noKg1HWT6xjY2zI5o
         +cL4Y0/0UJNkfwCzDosxwBh2pxU/AOcbBWby9D/YUP4NCk26fuS0Uu8D+TUJBWzWZFCy
         p2RA==
X-Gm-Message-State: AElRT7GT7Bn4ffFJ5X1+0PWmUgDX1QuXerYYrLQiaFcYd0FT+6IxYj59
        TvIyy28FsUANbmPYmFc110qUKVDF
X-Google-Smtp-Source: AG47ELsUBPW1lpS1Kz7ccZKwSQIZerhdy/3GcZqfDqhPVH+dmL35D5kd5xyS6FComnLiJXuIOz/4tQ==
X-Received: by 10.99.127.82 with SMTP id p18mr20687149pgn.188.1521997137084;
        Sun, 25 Mar 2018 09:58:57 -0700 (PDT)
Received: from localhost (softbank126094196092.bbtec.net. [126.94.196.92])
        by smtp.gmail.com with ESMTPSA id s89sm29938407pfk.54.2018.03.25.09.58.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 25 Mar 2018 09:58:56 -0700 (PDT)
Message-ID: <5ab7d550.dc96620a.4b512.feab@mx.google.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     git@vger.kernel.org
In-Reply-To: <1521996898-7052-1-git-send-email-orga.chem.job@gmail.com>
From:   Yuki Kokubun <orga.chem.job@gmail.com>
Date:   Sun, 25 Mar 2018 16:45:45 +0000
Subject: Re: [PATCH v4] filter-branch: fix errors caused by refs that point at non-committish
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

References: <1521996898-7052-1-git-send-email-orga.chem.job@gmail.com>
Content-Type: text/plain

Sorry, I forgot add a line of "Reviewed-by".
I'm gonna send the fixed patch again.
