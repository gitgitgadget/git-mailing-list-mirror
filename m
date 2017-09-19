Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D05492047F
	for <e@80x24.org>; Tue, 19 Sep 2017 17:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751074AbdISRIL convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 19 Sep 2017 13:08:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:46688 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750892AbdISRIK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 13:08:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CAA9AAD26;
        Tue, 19 Sep 2017 17:08:08 +0000 (UTC)
Subject: Re: What's cooking in git.git (Aug 2017, #05; Tue, 22)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
References: <xmqq4lsz2x6r.fsf@gitster.mtv.corp.google.com>
 <7D99B245-4D22-4C9C-9C43-C8B8656F8E6D@gmail.com>
 <xmqq1so0wyjd.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1709151816390.219280@virtualbox>
 <xmqqo9qbx14b.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1709152214100.219280@virtualbox>
 <xmqq377nwtbe.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1709181637420.219280@virtualbox>
 <xmqqbmm7s9ja.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1709191733450.219280@virtualbox>
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Openpgp: preference=signencrypt
Message-ID: <905a4adf-a6bd-7484-f81c-0381f7200cfc@suse.de>
Date:   Tue, 19 Sep 2017 19:08:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1709191733450.219280@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: fr-xx-classique+reforme1990
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 19/09/2017 à 17:43, Johannes Schindelin a écrit :
>
> C'mon, don't *try* to misunderstand me.
>
> Of course there need to be updates as to the state of patch series.
>
> It's just that mails only go *so* far when you need to connect and
> aggregate information. You need the connection between the original patch
> series, the latest unaddressed reviews, links to the branches, history of
> the patch series' iterations, and ideally links to the repositories of the
> contributors with *their* branch names. And then, of course, your verdict
> as to the state of the patch series and your expectation what happens
> next.
>
> To relate that, you are using a plain text format that is not well defined
> and not structured, and certainly not machine-readable, for information
> that is crucial for project management.
>
> What you need is a tool to aggregate this information, to help working
> with it, to manage the project, and to be updated automatically. And to
> publish this information continuously, without costing you extra effort.
>
> I understand that you started before GitHub existed, and before GitHub was
> an option, the script-generated What's cooking mail was the best you could
> do.
>
> Ciao,
> Dscho
Hi,

Would something like patchwork fix your need ?
They now seems to have a REST API, which means it could probably be pluggeg into
Junio's scripts and work seemlessly for him (or any other happy ML user) while other people can browse
through the web interface.

I used to work with this one:
http://patches.opendataplane.org/project/lng-odp/list/
It is not the best  example as the patch status are pretty much never updated on this one.

But it would solve most of the points you raised, while keeping fully compatible with the way people actually work (including Junio).

Nicolas


