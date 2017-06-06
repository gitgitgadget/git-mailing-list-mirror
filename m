Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9401F209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 22:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751471AbdFFWpa (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 18:45:30 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36792 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751424AbdFFWp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 18:45:29 -0400
Received: by mail-pf0-f193.google.com with SMTP id y7so6990807pfd.3
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 15:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NBA+iZpAQHjRNA+F5JDhYDsMpSBMKJXx18CkkWKFQ20=;
        b=MO6aEtsrgLpRnOu59acZ6Y3Pf21MtunNtp07lR71hOeazYGEjwf82/oEoiD2DmfEpV
         on0sW8f5gXJN+sw72wuNmQ861Mx4CNhvzDOHC7YtK23T0KTjglJzWLWom21RgD+g/8r+
         VExkuHZJTJUyjOkfDjcpwQwsy7QJwqx9QVIYCRSxVSwoXOUpgIf+lAjm4ATnRz7AhqYz
         k+xwVphJHa+muCVEwtH6Jf+TvaY0lnQ7AR9jX2y54qNkUeaRd5pkbj5+bfhhnulrbNmP
         fVDYpvNmj9Il9MrSM+e7VoH2SIJTnJDg3eVibkljUpU+LVJT3KGTfx+RZEMI2m+7ptX1
         kvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NBA+iZpAQHjRNA+F5JDhYDsMpSBMKJXx18CkkWKFQ20=;
        b=cGw1HxpqV4FIZLrG4RgVTX+pUcxvNKvuftI1vH621hDTYv/zWIX3vWc71Go+UV55Lk
         T1M55rjBD4uCxGMOedAXeh1LfPF9v0m9mdkOAMz+JrYm5+ylgRTWj+/2DKm+kh7qR898
         nUGWaY/vLfKnhepFQ2RBj/rwRZ706nYn9le4b+h9P0SOvnyTaFZl0F1bPrilx0REEDsd
         NMZTxXNhZ24uRJHCuAhB1OlOzTAYCikVXl8aud4rlJ6S3fghelfbVgJ8V9EQjCq8Tkyn
         24m9jPje/9KYRTbGWG1ZAfJfwSu7woeqcPHGOXHu+TErLKaWD46LMxM2z+Nc8ldvxw3R
         AUkA==
X-Gm-Message-State: AODbwcC+oz81lYgAJzQwHGbZ7wVB4UoBaZAnj9/HdlQNQwV1BOVFHTkQ
        9NBc11KDLxJ9zw==
X-Received: by 10.98.109.2 with SMTP id i2mr13498467pfc.186.1496789128383;
        Tue, 06 Jun 2017 15:45:28 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5be:2d73:26a4:30ee])
        by smtp.gmail.com with ESMTPSA id g13sm25721013pgu.54.2017.06.06.15.45.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 06 Jun 2017 15:45:26 -0700 (PDT)
Date:   Tue, 6 Jun 2017 15:45:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: pushing for a new hash, was Re: [PATCH 2/3] rebase: Add tests
 for console output
Message-ID: <20170606224524.GC21733@aiede.mtv.corp.google.com>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
 <20170531104213.16944-3-phillip.wood@talktalk.net>
 <alpine.DEB.2.21.1.1706011329350.3610@virtualbox>
 <xmqq7f0v46q3.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaM9ryT1gWx=L6S90HPCaDPNZ6H124HAJscpeJCQFDN8Q@mail.gmail.com>
 <alpine.DEB.2.21.1.1706021442190.171564@virtualbox>
 <20170602175455.GA30988@aiede.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1706070008440.171564@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1706070008440.171564@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:
> On Fri, 2 Jun 2017, Jonathan Nieder wrote:
>> Johannes Schindelin wrote:

>>> Maybe we should call out a specific month (or even a longer period) during
>>> which we try to push toward that new hash function, and focus more on
>>> those tasks (and on critical bug fixes, if any) than anything else.
>>
>> Thanks for offering. ;-)
>
> Undoubtedly my lack of command of the English language is to blame for
> this misunderstanding.
>
> By no means did I try to indicate that I am ready to accept the
> responsibility of working toward a new hash dumped on me.

It was a joke.  More seriously, I do appreciate your questions to get
this discussion going.

[...]
> 3) the only person who could make that call is Junio

I strongly disagree with this.

> 4) we still have the problem that there is no cryptography expert among
> those who in the Git project are listened to

*shrug* I still don't know what you are suggesting here.  Are you
saying we should find a cryptography expert to pay?  Or do you have
other specific suggestions of how to attract them?

>> How did you get the impression that their opinion had no impact? We have
>> been getting feedback about the choice of hash function both on and off
>> list from a variety of people, some indisputably security experts.
>> Sometimes the best one can do is to just listen.
>
> I did get the impression by talking at length to a cryptography expert who
> successfully resisted any suggestions to get involved in the Git mailing
> list.

I know of other potential Git contributors that have resisted getting
involved in the Git mailing list, too.  I still don't know what you
are suggesting here.  Forgive me for being dense.

> There were also accounts floating around on Twitter that a certain
> cryptography expert who dared to mention already back in 2005 how
> dangerous it would be to hardcode SHA-1 into Git was essentially shown the
> finger, and I cannot fault him for essentially saying "I told you so"
> publicly.

I think there is a concrete suggestion embedded here: when discussions
go in an unproductive direction, my usual practice has been to keep
away from them.  This means that to a casual observer there can appear
to be a consensus that doesn't really exist.  We need to do better
than that: when a prominent contributor like Linus and people newer to
the project are emphatically dismissing the security impact of using a
broken hash function, others in the project need to speak up to make
it clear that those are not the actual opinions of the project.

To put it another way: "The standard you walk past is the standard you
accept".  I have failed at this.

It is a very hard problem to solve, but it is worth solving.

> In my mind, it would have made sense to ask well-respected cryptographers
> about their opinions and then try to figure out a consensus among them (as
> opposed to what I saw so far, a lot of enthusastic talk by developers with
> little standing in the cryptography community, mostly revolving around
> hash size and speed as opposed to security). And then try to implement
> that consensus in Git. Given my recent success rate with SHA-1 related
> concerns, I am unfortunately not the person who can bring that about.
>
> But maybe you are.

I think you are being a bit dismissive of both the work done so far
and the value of your own work.

I am happy to solicit more input from security researchers, though,
and your suggestion to do so is good advice.

Thanks and hope that helps,
Jonathan
