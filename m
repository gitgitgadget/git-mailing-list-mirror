Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8922D2035F
	for <e@80x24.org>; Tue, 25 Oct 2016 19:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932655AbcJYTKm (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 15:10:42 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37860 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754065AbcJYTKl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 15:10:41 -0400
Received: by mail-wm0-f43.google.com with SMTP id c78so41970761wme.0
        for <git@vger.kernel.org>; Tue, 25 Oct 2016 12:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WNswqKzJy0AEFBtFmTuTdcCvLsdgSW7ky3XIMt6XXX4=;
        b=E0BwSPNK7NzpFcKFuGUt2rljf5bv64SsreTtp3ta3anmLwzMWlepIADkKLFTWeYPYj
         XHErqr9Gm/r8gK62K/58uz3iXc1t5rVelWG7VBbpFGwPcjNRHwLsPNyjFua3JaLKamu1
         zoqKcKVxkTwvlAXKUdGabeaSDz8HoBecvice7ioPa2F4kuiU7QonIhwlyxcvwLXkzuH1
         Koi/LTUHGgoTl7cVfP5+R7MQdiUWlGG/VpauJ9OBD8ODtm3n9fIqp2KVQFZEtdrORp0i
         U00MtbpFIqVVRNwEAlVRITqwm7uZaS2WFH1wZSb+I0Fr1c8/qtTYrbyJUWy6JG460if6
         We4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WNswqKzJy0AEFBtFmTuTdcCvLsdgSW7ky3XIMt6XXX4=;
        b=ehZCr5kjV3ZNunYMFvRctMbE7vT/QGfPTBvgcGLyJKSvULCe8bAdLkaVacahFOAfHx
         2PZx+DFtQEqi59VDWrvoNzTNuvuBkCUOy0KbUwBAH2Beo7x9X0LjhoTVOBv2CVGqkIot
         D9Ub9mUOQjV9aHo7K8tfBBzyqguMIbOjN0JqJxRIY5ASznw9Ni0OIAkwyxS8Wyyc1RW6
         d5XuOiT3iA6Pg9nLOsHUldKGr1hfzc6F3ekApHFy7nO1ARm4r2e/z5qahnKM9Vp+hYNV
         ieE5CknYYrYULmkXgWhbP/EfkO9fJXXTXhCsfJT2rJonah5g/+DsmKGq7JfK9SS8ooxQ
         5NEg==
X-Gm-Message-State: ABUngvfdYgUkEwIEMevkRhUxqHhz609UOxB3Pv2y8kzDfJ1Wr5oTYlm0rL8X1Dk8FeYbWA==
X-Received: by 10.28.207.129 with SMTP id f123mr1396889wmg.18.1477422640034;
        Tue, 25 Oct 2016 12:10:40 -0700 (PDT)
Received: from [10.42.1.91] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id s204sm5244918wmd.1.2016.10.25.12.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Oct 2016 12:10:39 -0700 (PDT)
Message-ID: <1477422638.3550.3.camel@kaarsemaker.net>
Subject: Re: password forgot
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Luciano Schillagi <luko.web@gmail.com>
Cc:     git@vger.kernel.org
Date:   Tue, 25 Oct 2016 21:10:38 +0200
In-Reply-To: <CAK99BNBop7aCbwbYUAVoKc9JRrR2d+SAa1=WOFuEzmdmTtNdog@mail.gmail.com>
References: <14FB7E4A-7134-4343-AFF7-9E17AC94ACE3@gmail.com>
         <1477412208.3550.1.camel@kaarsemaker.net>
         <CAK99BNBop7aCbwbYUAVoKc9JRrR2d+SAa1=WOFuEzmdmTtNdog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.0-2ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That is asking for your local computer password. This uninstaller also
has nothing to do with git itself, but with the third-party git package
you installed. The git project does not ship an 'uninstall.sh' 

On Tue, 2016-10-25 at 13:23 -0300, Luciano Schillagi wrote:
> sorry, I'm a little confused
> 
> and this? 
> 
> 
> 
> 
> 2016-10-25 13:16 GMT-03:00 Dennis Kaarsemaker <dennis@kaarsemaker.net>:
> > On Tue, 2016-10-25 at 12:52 -0300, Luciano Schillagi wrote:
> > > Hi,
> > >
> > > I forgot my password in git, such as resetting?
> > 
> > Hi Luciano,
> > 
> > Git itself doesn't do any authentication, so I assume you lost the
> > password for an account on a hosted git solution such as gitlab or
> > github.
> > 
> > You should contact the support team of whatever hoster you use, the git
> > developers cannot help you here.
> > 
> > D.
> > 
> 
> 
> 
