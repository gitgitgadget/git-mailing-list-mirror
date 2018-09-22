Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 127A81F453
	for <e@80x24.org>; Sat, 22 Sep 2018 18:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbeIWAKf convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 22 Sep 2018 20:10:35 -0400
Received: from h3.fbrelay.privateemail.com ([131.153.2.44]:59426 "EHLO
        h3.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726004AbeIWAKf (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Sep 2018 20:10:35 -0400
Received: from MTA-06-3.privateemail.com (mta-06.privateemail.com [68.65.122.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 1824180977
        for <git@vger.kernel.org>; Sat, 22 Sep 2018 14:16:07 -0400 (EDT)
Received: from MTA-06.privateemail.com (localhost [127.0.0.1])
        by MTA-06.privateemail.com (Postfix) with ESMTP id F2DD260049;
        Sat, 22 Sep 2018 14:16:05 -0400 (EDT)
Received: from MacMini.local.mail (unknown [10.20.151.249])
        by MTA-06.privateemail.com (Postfix) with ESMTPA id F3E0A60043;
        Sat, 22 Sep 2018 18:16:04 +0000 (UTC)
Date:   Sat, 22 Sep 2018 20:16:03 +0200
From:   Sebastian Gniazdowski <psprint@zdharma.org>
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Message-ID: <etPan.5ba686e3.762c4412.1ba0@zdharma.org>
In-Reply-To: <87musajun7.fsf@evledraar.gmail.com>
References: <315083291.15466.1537536854535@privateemail.com>
 <20180921222454.GD11177@sigill.intra.peff.net>
 <87musajun7.fsf@evledraar.gmail.com> <87musajun7.fsf@evledraar.gmail.com>
Subject: Re: Very simple popen() code request, ground-shaking
 functionality openned by it
X-Mailer: Airmail (506)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22 września 2018 at 01:30:36, Ævar Arnfjörð Bjarmason (avarab@gmail.com) wrote: 
> Duy's  
> https://public-inbox.org/git/20180920161928.GA13379@duynguyen.home/ is  
> another recent thing that reminded me of this, i.e. that suggested  
> "\\|/-" spinner could be made much neater with non-ASCII.  

Here is a IMO very large collection of spinner-like unicode animations: 

https://asciinema.org/a/ex8z3z6d5m7uv4buww0o2qeq2 

This comes from Zsh world, it's a plugin with spinners to use in Zsh scripts. I've never managed to see even 1/3 of them. 

> I'll just add that a 3rd thing that would also make sense would be to  
> add a feature to configure the value of these GIT_TRACE_*=* variables  
> via the .gitconfig, that's been suggested before (too lazy to dig up a  
> ML archive reference), and would make this as easy to configure as  
> Sebastian's suggestion.  

Yes git config setting of this is most convenient IMO, most expected to occur in ~/.gitconfig, in which it would be set once to a favourite gauge-box script, and rather long long before looking at this part of config again. Or maybe in the beginning, dawn of such gauge-scripts (if there actually would be any new group of such scripts; but as it's a quite broad problem (see last `PS.' paragraph), then who knows), when some unstable gauge-box would be breaking login/passwords prompt (but that's stdout not stderr, shouldn't go through gauge-box-script) or "fatal: ..." messages, etc., user might be disabling it temporarily or choosing an alternate gauge-box solution, editing the config option ;) So not rarely edited in the beginning. (I don't know how much important would a fancy gauge box be for a regular user; I can tell it would be quite important to me). I think this is more convenient and clean than `export GIT_*' in .bashrc/.zshrc, rarely edited, just sitting there. 

Guys you seem to like the idea, I hope someone will approach the coding! 

PS. There's much room for improvement in the git-process-output.zsh in the Asciinema video, gauge scripts won't be simple. In general, the number of 0..100% sequences (like: compressing, resolving, etc. – they all go 0 to 100% on their own) should be somehow predicted (does Git know this in advance?) and the gauge should be divided into that many segments, each filling up per one corresponding 0..100% sequence, together forming single global 0..100% gauge.

--  
Sebastian Gniazdowski 
News: https://twitter.com/ZdharmaI 
IRC: https://kiwiirc.com/client/chat.freenode.net:+6697/#zplugin 
Blog: http://zdharma.org
