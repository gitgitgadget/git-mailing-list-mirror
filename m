Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0532202AE
	for <e@80x24.org>; Sun,  9 Jul 2017 13:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752350AbdGIN0U (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 09:26:20 -0400
Received: from mout.web.de ([212.227.15.14]:59736 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752317AbdGIN0T (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 09:26:19 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MMZck-1dbLd20wTm-008KLK; Sun, 09
 Jul 2017 15:26:06 +0200
Subject: Re: [PATCH] sha1_file: add slash once in
 for_each_file_in_obj_subdir()
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <f59c8256-716b-9305-2a4f-d4fe49f666ff@web.de>
 <20170709110016.nusy62u2morqvwmm@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f83adfa6-89f9-9c0e-bd69-eca56d3fcf25@web.de>
Date:   Sun, 9 Jul 2017 15:26:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170709110016.nusy62u2morqvwmm@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:9EkUftF5qIPVAlNoMY34dNJZI13G0YDiEqQsigQbz8p+3x9B+mn
 W6uzRxKl67hQnhLVbxMzeBNfeg/cnr4q6eOoIFwbOAYljXIUgQE+hc24mBZEs2hfamW/K+9
 pG8YDsWn7FEK9qoXf49ekj8sLq63aQP9sW+Y+9sosVcAwjfPk8jCin0BXkpgA/XW+3mhYd6
 XZhWFb8NFKyTqtx79PI8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:x9cmALZiDIU=:GBJTfueaYNhC0qYwpFUrnk
 cGTU2p3YsRB1oSWVFeveGcTVuMRLk2gAfME633nSpFIft1Ujkh7pBJlHDxwbSRoLCwWrXGsoj
 bPGKzzngRNGxjTb1+jpGiIBVeO0lw5SDgj/9KyvT6DVDyEIvXhNmCWu7ktq32u6Td/jo1NqBt
 4orvYYJvrjSyco/iSjunvmLyqN4rexk4O34sJy38SBpfBrRFmKxXdVjGjHaGR/Dl0ac31ImjY
 nWmAznXWt/b3sDYm4HQJcfT/OozHeMPehJjiPo/omtdMmN/+N+IFyvWSux7du/bUEDubK/ZVT
 r4DnPV91FVw+6RZrNJDEw7F+DGriz2DdHNjJKAuJ7/a9zgZUcYY85gKhIALU0EyJlJsgfuCf6
 VJOkDKoE/oN0izFJgtINH+IlzN1nzt9cqEGdNRAdmFp9sVeJFfGr8wBz0tQy3yAmVmNnaIIn2
 ltx+SBfApwvGBg9dqrDMbb2X1K5QIRKc7/Ghgn8SRgojR8U3P9rcmnqWPGYiV+Fb0AWEC3Q8D
 vYh1Q02Rfn5p9ChdxTuGXjXWAqhvqGYHV85vWe6NgNN9zQTd6VfBt2pa6PiPMEqbXma1YvB4i
 qmbOmysjW7gjLKUMJm7gNyDAsPuj4xiXLNMWrDTeE19Uv525KiGGZsizsY96Ql1qUnlV861Jt
 qxAQNnI+HrT3BrjzWVfYPPYJiLHDPjuxoI0EVgqpEJC46WBfSWf2/ywNqwcl69gJruIUyibGj
 qgujo12mnNnvR8R+lUeSrQyW13PyR1z/EhMMzKSDfIgrqDZNG3+0GcbMRQuWx/QjWoY0ZhxSq
 6vTVZoo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.07.2017 um 13:00 schrieb Jeff King:
> On Sat, Jul 08, 2017 at 10:59:06AM +0200, René Scharfe wrote:
> 
>> Add the slash between loose object subdirectory and file name just once
>> outside the loop instead of overwriting it with each readdir call.
>> Redefine baselen as the length with that slash, and add dirlen for the
>> length without it.  The result is slightly less wasteful and can use the
>> the cheaper strbuf_addstr instead of strbuf_addf without losing clarity.
> 
> This patch looks correct to me.
> 
> I'm a little lukewarm on it overall, though. I'd be shocked if the
> efficiency change is measurable. What I really care about is whether the
> result is easier to read or not.
> 
> On the plus side, this moves an invariant out of the loop. On the minus
> side, it has to introduce an extra variable for "length we add on to"
> versus "dir length to pass to the subdir_cb". That's not rocket science,
> but it does slightly complicate things (though I note we already have
> "origlen", so this is bumping us from 2 to 3 length variables, not 1 to
> 2).

Admittedly this is more of an OCD thing.  Overwriting a character 200
times or parsing a format string don't very long compared to the rest
of the function, but it's a bit itchy.

René
