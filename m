Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25A85202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 18:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751073AbdKSSzT (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 13:55:19 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:40398 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbdKSSzS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 13:55:18 -0500
Received: by mail-wm0-f52.google.com with SMTP id b189so14657305wmd.5
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 10:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9YrlTIizXOKifg7F7UdNIxq7ARsPm5W6/qjiuOrTUAo=;
        b=OZ42pbdXCgtuiuYA5jQb0FKUc4vxPivTPqSxX3LZ0DfaXoADIk2Go3s9PoXBAKal9W
         Q0pcCmhUmZDier1glQuzhRU2Mdhrhij5Nj+vPIJwkpIfABDCKe4LlTGQ7OkJw8NqFmgm
         h7+nq6KUtr76ZgoZZsstVdlOowJZ2w4BWD+meb4o1Sz76JJx611v8degWEadFyMh7pPZ
         h1ynD5BFYraC++w4GwmphsruCGDZkEd72qozH5vuDmKE92+sVRhmCN7XVfe0pf4prH8g
         YCNU7TKEaTZk9C7GNaogPn7pcGPzghHkN+oM6R1HraCo0XxLGAyKko1LALjlRtW9DWEq
         ibdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9YrlTIizXOKifg7F7UdNIxq7ARsPm5W6/qjiuOrTUAo=;
        b=bsFP2P5NWXDwm7tGDz7B1CA8jrtAZTwYVjsn0VIoCfvRHfS2UK31lsLSFsXQaKx/QD
         uXVcOkH70mm9IrmiKRGc2aGuZXc64jK5ESofypvg+v+We7becTonZliri/VDqC4nb+UY
         Rnr2OR5GFUlC9Wl+sP/E1PGIWComNxq9O3RioUVTVQwVu7/L4pbYbMOue3zYCUNeDUcn
         7R9CtIrS36xo9ctEO2sczHDWkmv5Q1pYUTRPl/nx7FqJxYyrQ/KuauyxI2ygV7Wqtss/
         MP0VZGPbhgEOHA+MJ7q6fSP9Wilumel8PdoBu4Qef/n4v6AfOy1o1LkYPtS1GqXVDqMM
         Myjw==
X-Gm-Message-State: AJaThX6MRrqVPSQX3m4/8BIDIukG3xoY3VAv0/g+pqyl4GIJtKfyYcxT
        W/APNrrUhkpclb0gdZ98WKs=
X-Google-Smtp-Source: AGs4zMaX0wop4MBWHpShc6PxJwytodRlcxcuCKXgL9hSOQ8QDnRGKj/1AdGomoHZn9SNlwtRcMcwFA==
X-Received: by 10.28.157.7 with SMTP id g7mr7635841wme.99.1511117717587;
        Sun, 19 Nov 2017 10:55:17 -0800 (PST)
Received: from ?IPv6:2a02:8071:3185:fe00:8422:e311:5963:4b31? ([2a02:8071:3185:fe00:8422:e311:5963:4b31])
        by smtp.googlemail.com with ESMTPSA id l31sm15791808wrc.50.2017.11.19.10.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Nov 2017 10:55:16 -0800 (PST)
Message-ID: <1511117715.11184.0.camel@gmail.com>
Subject: Re: Documentation of post-receive hook
From:   Christoph Michelbach <michelbach94@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Date:   Sun, 19 Nov 2017 19:55:15 +0100
In-Reply-To: <alpine.LFD.2.21.1711191241580.6781@localhost.localdomain>
References: <1510872031.23230.7.camel@gmail.com>
                 <xmqqpo8hu1fi.fsf@gitster.mtv.corp.google.com>
                 <xmqq375dtwnr.fsf@gitster.mtv.corp.google.com>
         <1511112703.8109.5.camel@gmail.com>
         <alpine.LFD.2.21.1711191241580.6781@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2017-11-19 at 12:42 -0500, Robert P. J. Day wrote:
> On Sun, 19 Nov 2017, Christoph Michelbach wrote:
> 
> > 
> > On Fri, 2017-11-17 at 12:24 +0900, Junio C Hamano wrote:
> > > 
> > > So an updated suggestion for the text would be:
> > >  
> > >       This hook is invoked by 'git-receive-pack' on the remote repository,
> > >       which happens when a 'git push' is done on a local repository.
> > >  
> > > Oh, wait.  That is what we already have ;-).
> > But this text suggests that the hook is always invoked when a git
> > push to that repo is done, which is not the case. How about adding
> > "and updates are reference in the remote repository"?
>   "referenced"?
> 
> rday
> 

Sorry, meant to write "a" instead of "are".
