Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A5671F404
	for <e@80x24.org>; Mon,  5 Mar 2018 17:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeCERBc (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 12:01:32 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:42066 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751852AbeCERBb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 12:01:31 -0500
Received: by mail-pg0-f54.google.com with SMTP id y8so7055138pgr.9
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 09:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fjocAOLr+z1S6J+GQnbKF2nJ55Zk4hBZtlA1bUgjt20=;
        b=nR5lpXJXG1Cc6ihazbHnBPlHgOnGs1AeYA/dyFaCLpmq/lIRy/4ZIyAjV3zm0yubYx
         CMz1mBXKeDuf4cktNB4KQrePRFi+HrfHREFAkMNJnX60V1yY91WnB7Z1lyzFy0P9U/Bv
         ca604SDgJyIFhXHd+DJ/UPeVhMaYQyN35mijaqoYbUQsGoFH/juUNN0YpFrjB0Ls/eKU
         d3XL/IwUxExA0tLNAiDH5FwLsPnIQaL9qhCbC71Ppx3KTD7/Bi0lvISK3ATc0k2mYfBO
         zTA4DVdtY19P7TUKjwV4caiYfSQgOZbNxB6hE85iGOx5Jl9kbVp6IAB3fHVBVFpsjsny
         zXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fjocAOLr+z1S6J+GQnbKF2nJ55Zk4hBZtlA1bUgjt20=;
        b=VRk1lI6fNZTqoZQBM32n4XSPFMuOTG509bddq/5IMeKgCWF3ITRGZ+FZwpmWcA539B
         Ntk/gmF6LUrFxFmi9Hp+ZbNigPrMiOkq+IYF7uRwiylHLNAeP+YI0e0GbVafqUmGDbxC
         wRDXbm7IYlBVU69gJyZs6gKCDniaF43FiIKBbiFH+y5wB+Hmy9NItRBTbMbjsvXxK621
         OABj4MZ5VA92UO6vqCri84kZQSkkoNybINmvuUOWXpQ7bmlBjCY7wNzUzwa/AofM735T
         TQ/J7zM5iU0m/MAV+W/Kp9JRC2OX33wRJ2xyd5U6sWy0J14hzD+VAkirvdPA5fVKmv1j
         wghA==
X-Gm-Message-State: APf1xPBJpEfO6K0BXUIAWO6sYNTQpElK0U/AOwXai0lkQd+SFijoI0ub
        gA6dsJQOt/aOUvkgHSNEpDu0z83Cnwo=
X-Google-Smtp-Source: AG47ELuGSMbPF4xM7B2b4p56dQSMhIE1LN8JGjS9EMuysz7ESADizFK5hUAcrjf91Ac2G8VEghGXPA==
X-Received: by 10.98.27.10 with SMTP id b10mr16035268pfb.121.1520269290386;
        Mon, 05 Mar 2018 09:01:30 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id g67sm19444509pgc.60.2018.03.05.09.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 09:01:29 -0800 (PST)
Date:   Mon, 5 Mar 2018 09:01:27 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Contributor Summit planning
Message-ID: <20180305170127.GA72475@google.com>
References: <20180303103010.GA21068@sigill.intra.peff.net>
 <20180303103957.GA24498@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180303103957.GA24498@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03, Jeff King wrote:
> On Sat, Mar 03, 2018 at 05:30:10AM -0500, Jeff King wrote:
> 
> > As in past years, I plan to run it like an unconference. Attendees are
> > expected to bring topics for group discussion. Short presentations are
> > also welcome. We'll put the topics on a whiteboard in the morning, and
> > pick whichever ones people are interested in.
> > 
> > Feel free to reply to this thread if you want to make plans or discuss
> > any proposed topics before the summit. Input or questions from
> > non-attendees is welcome here.
> 
> I'll plan to offer two topics:
> 
>  - a round-up of the current state and past year's activities of Git as
>    a member project of Software Freedom Conservancy
> 
>  - some updates on the state of the git-scm.com since my report last
>    year
> 
> As with last year, I'll try to send a written report to the list for
> those who aren't at the summit in person.

Thanks for kicking things off!

Since I've been working on protocol stuff I'd like to spend a bit of
time discussing protocol v2 :)

-- 
Brandon Williams
