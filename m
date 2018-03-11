Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAB671F404
	for <e@80x24.org>; Sun, 11 Mar 2018 22:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932540AbeCKWEq (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 18:04:46 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35238 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932538AbeCKWEp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Mar 2018 18:04:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id x7so12650028wmc.0
        for <git@vger.kernel.org>; Sun, 11 Mar 2018 15:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b6xXbKFb5ux6AWf4fP3ClPPoPvrLJuxVrEGBRrgZowc=;
        b=cVM73IoEBzMeusg8O/5B0AzyZ/wG0QEPWJBeHZgeohOngj/JlWAMpX9vS7Kz8WDPSn
         j7xPrD3uPUYM7yDunjiF+pysG70fULV0fx8gUHoT50FM7zdkcR1A2bQwKbirPAOzsAmM
         cWvPi451udEkV81cHY+0LSwP6qhpU0mdv3Wr/nhuLxYkseCfT6pZujp0mzBanlg59CLk
         ohmElvZodSn8SHgUqknqfnY05faZa88Oqc39qUlAKy598Vj3MUkXfdqv7tRxvttbbkat
         UaUTUYj09JFVJMo/PMXE4C04/7rXxNJ7DATB0lJWvp2X+GFqMqMRt40CAL84Htxc+OYV
         +OfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b6xXbKFb5ux6AWf4fP3ClPPoPvrLJuxVrEGBRrgZowc=;
        b=Yxvt1zERzTwTot50sSO4umbjmJIoamgU8sNmpBUij3cUjnUuCuTE+xZveXXtHP63tj
         DvEQfB+khsU6wM89FOat7kRJuU6ZrY9SJUApfNBKJF0vhwR95jBVfkc4aAVXT89baCTc
         9Aet4jol234jUVOF2D/Pe5qec6tPdXlQl0uaQ0m8ex93rCARvhA+WbBXQ5uqsr6/3LG3
         OHHhZ1qI8240MC6KrDm+GulFAFLZEG+gh2K71k74tvBfNuajN9j8Sn0rjoaP30riiYJ/
         EYw1VLxA+enHWVLlcp4KGeXJYAASWF3uwRx6ZP8p5m4qXK9/hS1YhteYes8nJ2eTHRRD
         2X/w==
X-Gm-Message-State: AElRT7Ft85UEmV6PM0Z4806zu+dCeTYIN6i9KtWNTh1LQJkNmT/obrHF
        bg4YceAX9b1O0eMrtKeqKjo=
X-Google-Smtp-Source: AG47ELsmUh+obFloNnNw/bN0Kj/Mr2l1aBGd0xioCBBZ5OsyT9YtgqH6Zem3T5aWHF631EeD64NcqA==
X-Received: by 10.28.236.196 with SMTP id h65mr1977201wmi.148.1520805883685;
        Sun, 11 Mar 2018 15:04:43 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id x107sm7041721wrb.97.2018.03.11.15.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Mar 2018 15:04:42 -0700 (PDT)
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com>
 <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87vae8yq15.fsf@javad.com>
 <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com>
 <nycvar.QRO.7.76.6.1803111324390.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <d18a6e73-ce6f-b4aa-8ead-7aaabddf454d@gmail.com>
Date:   Sun, 11 Mar 2018 23:04:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1803111324390.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

I`m yet to read (and reason about) your whole (very informative) 
reply, but I just wanted to address this part first, as it might be a 
clear end-game situation already, due to a mutual agreement, all the 
rest being purely academic, interesting, but not any more (that) 
important to discuss.

On 11/03/2018 16:40, Johannes Schindelin wrote:
> 
> > For myself, I do actually favor Sergey`s approach in general, but 
> > _implemented_ through what Phillip described (or a mixture of both, to 
> > be precise). But, let me explain... :)
> 
> So as you explained later in this sub-thread, Sergey's approach is
> essentially the same as Phillip's.
> 
> I still do not understand Sergey's approach on a fundamental level. I
> mean, I can follow his instructions how to implement his algorithm, but it
> is as if I had a blindfold on and somebody guided me through a maze: I
> understand *what* I am supposed to do, but I have no clue *why*.
> 
> And admittedly, I got very frustrated when a document was thrown my way
> that is too long to read in one sitting, and all of my attempts at getting
> clear and comprehensible answers to specific questions were met with "go
> and read that document, I am sure you will understand then".
> 
> For something as fundamental to my daily workflow as an interactive rebase
> (*especially* when trying to maintain the branch topology), this is no
> good at all.
> 
> Since you already confirmed that there is essentially no difference
> between the two approaches, I will simply go with the one I understand, in
> particular I understand *why* it works.
> 
> But let's read on, maybe I will change my mind based on your explanations
> (which do answer my questions, thank you so much for that)...

No problem, I learned much myself trying to write those explanations 
in the first place, and I still need to read on yet myself, seeing 
how well my explanations actually fared :) Thank you for still 
holding on, though.

But I just wanted to point out that you can really just go with what 
Phillip described if you find that easier to reason about (and/or 
implement), there`s even no need for mind changing, as essentially, 
and in my opinion, it seems to be just a bit different implementation 
of the same concept (but not requiring temporary commits).

That said, *if* we decide we like temporary commit U1' == U2' consistency 
check (especially for non-interactive rebase, maybe), we can produce 
these after the fact for the sake of the check only.

I will come with a follow-up, but all the rest might be less important.

Regards, Buga
