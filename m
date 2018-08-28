Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0266C1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 19:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbeH1W7N (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 18:59:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46601 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1W7M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 18:59:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id u24-v6so1113003pfn.13
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 12:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sYtcU6PMALC0skaRCmgGcH1BIDWLkX99k3J642Ixfyw=;
        b=Q22S0eoMUaPso5QBnyLm0cbzGjcZWIxg8eEdK5MOCwO8DM2LMlfjjvRxhTOY77zwhF
         pnKvzAcjsRl1QOal1WJe+CyAJZMMI1AwndWgsm7HZDkwFs0twPepVXXVhkF+bfoGjVvN
         bsA6rcAghJR6scyyWZ5IMNjiUlUQsElZGc6wYYooerlIETWNC6kosJ5OO8O6+ofPbMJS
         YSe+YE+wWk57+DoA9WRsacPhwqKiXQw8pKpq26OXPlZztZJzQ7QkOhlOgkAA8WinEZjQ
         vpX3M1uFqxv3rAEdTsRofrHfvnLw6VrdTf4MDia/K2B39/4zNFQrePuNxcaQhJVVpopW
         TrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sYtcU6PMALC0skaRCmgGcH1BIDWLkX99k3J642Ixfyw=;
        b=owDA7Z+q7Uzl5P5UYemiQ4bRrAPylyvYrqR//MA+GOvfMCJTeE/Xs55Q2LyxGwJLc0
         X8uKolBV54pn1YeFe5Jum9lhSH3tkT47CWWWpLWPehqg0ks8VsdpLgYxLT6UziuZ6hDl
         oFEudFlxQltx0z8jwBblE01UCuEKwhUvt9J/u91ylXO2kP0J0wxNMs+LZi+K3RdZFnba
         KfeJ9cokepo2xJraLcQO3GgTOe1DIxEvzTNHL4MSFPA0XUqujLLs7AJQMNSkBcTqJXw7
         9jvb2y+G6AKWq6yVO4mnmti6lvCnU0VwpRpSaiwTa4e38B8Xgqp7nYz73e8WMv+rULIb
         avsQ==
X-Gm-Message-State: APzg51BaAK96wzTwLe/c4zOJ0Peh9OEUmgA0deLwfCt0slmicb8GHioI
        uAjKc4u9PzWSXRKbD8LUVmM=
X-Google-Smtp-Source: ANB0VdYC6vn5CKN2j0W9lqXd1UwETWC5rxOEzzU2XQwMAVR5OQPfIEVV+AxPLNNEu3iGskM8xy8NsQ==
X-Received: by 2002:a63:842:: with SMTP id 63-v6mr2729432pgi.44.1535483171386;
        Tue, 28 Aug 2018 12:06:11 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h69-v6sm3148677pfh.13.2018.08.28.12.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 12:06:10 -0700 (PDT)
Date:   Tue, 28 Aug 2018 12:06:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Contributor Summit planning
Message-ID: <20180828190608.GA46388@aiede.svl.corp.google.com>
References: <20180813163108.GA6731@sigill.intra.peff.net>
 <d5d3fe71-d52b-ac9b-d48d-d288b6569e5a@gmail.com>
 <20180813171535.GA8476@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1808271458450.73@tvgsbejvaqbjf.bet>
 <4f0e85ed-6402-65b2-442e-67a1a7a7486d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f0e85ed-6402-65b2-442e-67a1a7a7486d@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

Derrick Stolee wrote:

> A focused aside, since you brought up the online "standup": it seems the IRC
> channel has been less than ideal, with people trying to participate but
> having nickname issues or being muted. You also describe another issue: the
> timing. Having a real-time discussion has its benefits, but also it leaves
> many people out.

For me, the real-time element is the entire point.  If timezones are a
problem for some people, I'm happy to e.g. alternate with a different
hour.

The current IRC experience might be a bit unrepresentative, due to
https://freenode.net/news/spam-shake:

| As you may be aware there has been a prolonged spambot attack
| directed at freenode (and other IRC networks) in recent weeks,
| targeting a number of individuals involved with freenode and the
| wider IRC communities.

A kind person configured the channel to withstand this spam attack.
This involved users having to authenticate to Freenode using
https://freenode.net/kb/answer/registration#nickname-setup so that it
knows whether you are a spammer.  Sorry for the inconvenience.

My offer to +v anyone affected by the channel's current settings still
stands (just /msg me).  Zero people have taken me up on this offer so
far.

> One idea to try next time is to create a mailing list thread asking for
> statuses, and each person can chime in asynchronously and spawn a new
> discussion based on that status. Perhaps we can try that next time.

I don't want to discourage a good idea.  The logical extension of this
(not one thread but a whole list) reminds me of the Kernel Newbies
mailing list <https://kernelnewbies.org/>, which appears to work well
in that context.  Given my current time commitments, I wouldn't be
able to participate, but I would be happy to see other volunteers set
something like that up if interested.

The usual practice of sending email about current work on progress to
git@vger to get feedback also still works, and that is something I can
commit to continue to spend time on.

Thanks,
Jonathan
