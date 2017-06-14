Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C728920282
	for <e@80x24.org>; Wed, 14 Jun 2017 23:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752376AbdFNXDn (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 19:03:43 -0400
Received: from mout.web.de ([212.227.17.12]:62684 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752121AbdFNXDm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 19:03:42 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MYeys-1dHPhQ1MCw-00VPcL; Thu, 15
 Jun 2017 01:03:30 +0200
Subject: Re: rs/strbuf-addftime-zZ, was Re: What's cooking in git.git (Jun
 2017, #04; Tue, 13)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
References: <xmqqshj34ldr.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1706141245520.171564@virtualbox>
 <20170614111043.xlfsgclbyrqektb3@sigill.intra.peff.net>
 <e9260c40-c49f-d7f6-70c2-a28c1b3104a2@web.de>
 <alpine.DEB.2.21.1.1706142303510.171564@virtualbox>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f80aa20c-dd7e-41e6-f35f-5c633c169732@web.de>
Date:   Thu, 15 Jun 2017 01:03:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1706142303510.171564@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:A41dz11D++B+kfMN1TbkSbFOagDujyrrlApn3QuvnrmRz3LalGe
 e+zX8HcVyNnpFHG8xkUJwAoD7qxwtse0E7RGhpa7b44vpOt/+UwEoP1sPPWcZx6hrf5D1po
 SktO9lHF5uJUjaKpAyimd9ZC4KEw5kGRLyRlqYqZZTKLSAZItykpJ41bjVBqmFkiAsst3EG
 auJg9xSccg+AO3A2B48cQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jnS2OwK+R4c=:v86uTtIGnlx3+S6+Yn0zRq
 +r5sLkSghg5iPZq3X2IQR4lsQj8KCj/dfhLrdcFlgYdwAVC4yTkhOvrAGqFSi8mSrgCus+dDk
 PLQwXaSdlqYhmAmqR2j9nfX2/+zL35C3ajtaZ8RoAWPnaM7RP7p3CUbqCkYC8qJ/mOLa4z3x+
 qk2SAKszoB35aYQ3eFi+HOJzue9Kl0YtldcnLyTOuZeh6uitXf6VRhX7q9bKTbUAOViS0UaCc
 E2ChCIfNK6B3O8D6hvAmCONNgu/lkaUWyx5MqiKkHEnAKpYmCMqEZqNeUBkJbV6qy0AKeLSc/
 OGNE3pWRuEbuK5sGt4Lq17o4GOrpZrrEFQgwQPuLzGHWyEVOWRN0IFsdi1mbkLaJ/Z/ertmDE
 D0g0AtPehQHGgue9NPFDhDbOIy+oL1A85CsPHUu/0AE5SJS0M8s2SI2GR4HOkt+mZZrdg0WSr
 vtb4njRbAnmh8XSASvEmXBgTxlcFfW7+onO9pvnVhXc3SDzL6iUBgS3L8qzjzHvecwYrGe7MA
 iVOPJ5XD0LE7+hq2IOLxLCzyDjRcduOLFj0ew/5cabpr8HTCqXvqirOSq3YAVBzsDPM1ELgks
 AaLCB9pMjVu5gIeNqqagt2bdyEPjB3PjimrpwTv632qGz6mzsuHNuebnpdo+ttGUydjSlAOwP
 o0BL588MOSaqbb6JTVMwZnbqJCsdXPG0UBjBecOtAi0QrxvqXFraPAzpRtZUs+O3excBcccPe
 /gwTiC0pwiP6fahw7/8PujaH1G8bJMdRapK9H95IIRMidqQueckZLVcdjh5bIqFe7oWwJzRLv
 dVyO/sB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.06.2017 um 23:04 schrieb Johannes Schindelin:
> On Wed, 14 Jun 2017, René Scharfe wrote:
> 
>> Does someone actually expect %z to show time zone names instead of
>> offsets on Windows?
> 
> Not me ;-)
> 
> I cannot speak for anyone else, as I lack that information, though.

Before the patch %z would always expand to +0000 on Linux and to the
name of the local time zone on Windows, no matter which offset was
actually given.  So it was broken in either case (even though it got
at least some aspects right by accident for some commits).  Based on
that I'd think handling %z internally should be OK.

But there's more.  strftime on Windows doesn't support common POSIX-
defined tokens like %F (%Y-%m-%d) and %T (%H:%M:%S). We could handle
them as well.  Do we want that?  At least we'd have to update the
added test that uses them..

Here's the full list of tokens in POSIX [1], but not supported by
Windows [2]: %C, %D, %F, %G, %R, %T, %V, %e, %g, %h, %n, %r, %t, %u
plus the modifiers %E and %O.

René


[1] http://pubs.opengroup.org/onlinepubs/009695399/functions/strftime.html
[2] https://msdn.microsoft.com/en-us/library/fe06s4ak.aspx
