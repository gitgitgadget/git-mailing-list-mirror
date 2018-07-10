Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4EDD1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 15:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934156AbeGJPak (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 11:30:40 -0400
Received: from e1i428.smtp2go.com ([103.36.109.172]:45337 "EHLO
        e1i428.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933932AbeGJPaj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 11:30:39 -0400
X-Greylist: delayed 703 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Jul 2018 11:30:39 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smtpservice.net; s=m1fbw0.a1-4.dyn; x=1531237539; h=Feedback-ID:
        X-Smtpcorp-Track:Date:Subject:To:From:Reply-To:Message-ID:Sender:
        List-Unsubscribe; bh=0G4fXF9AM9mK2hP+iZ49gYnd4j7BopkKbUkeh15kxw4=; b=JQGf1N8e
        NPITarpSZN7v3BEMmTVn5xk674ubo+L7eka2BuxXMH6famogYZDqGk3raY4taaU/mFKHRNFhhGZVm
        9/Ps07B1iQ2PRuMe3sykW4oUvl238CrrVBlBObfscwVV1xI+7PUcheLO0yDd+NXYb6W3MzbMor+EC
        Er8nYIjxeBFEFheE8F2t33z6bt4we1XS8uKQxAFH/dUEQrN7QQthXFaXxFVsmMWgwUc1SwVYLPvz3
        0cOrmu1n5ErKRY44hMyQt6NTisomhW5bmmC/5lsDWMpG8wCgrLRf7wHSfaULnlg9hXi2/jE/vgWLE
        YxGDDLUHLIJLS61qKG0EM+C10Q==;
Message-ID: <2314380CD5BB4E75AD989D7CAC2EB93B@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Philipp Gortan" <philipp@gortan.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        "Git Mailing List" <git@vger.kernel.org>
References: <953845c2-4326-608a-c342-2d2141da561c@gortan.org> <CACBZZX6H4wxQ7hrO1Y1u6Qyr5gpK9GeCxpv-x2q3Eq2WCbkK8Q@mail.gmail.com> <alpine.DEB.2.21.1.1706141457500.171564@virtualbox> <74c84bda-4f3d-b2d3-91cf-e80e84fe46b1@gortan.org> <nycvar.QRO.7.76.6.1807101405570.75@tvgsbejvaqbjf.bet>
Subject: Re: git-gui ignores core.hooksPath
Date:   Tue, 10 Jul 2018 16:18:46 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Smtpcorp-Track: 1fcIefl24cnH2P.RH5TDoBuU
Feedback-ID: 66524m:66524aMf6O2Y:66524s8D2EnYH2H:SMTPCORP
X-Report-Abuse: Please forward a copy of this message, including all
 headers, to <abuse-report@smtp2go.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> Hi Phillip,
>
> On Wed, 14 Jun 2017, Philipp Gortan wrote:
>
>> thanks for following up,
>>
>> > Indeed. Why don't you give it a try?
>>
>> Actually, I already did: https://github.com/patthoyts/git-gui/pull/12
>>
>> You might want to post your analysis and patch there as well...
>
> I wonder what good posting my analysis did, if nothing changed as a
> consequence.
>
> FWIW I opened this PR with Git for Windows to fix it properly:
>
> https://github.com/git-for-windows/git/pull/1757
>
> I plan on consolidating all of the PRs at
> https://github.com/patthoyts/git-gui, too, and to try to get them into
> git.git.


>        I guess that means that I just volunteered as interim maintainer
> of the git-gui repository. However, I will really act as maintainer, not
> as "cleaner upper".

"Curator" is a useful intermediate level concept between active maintenance 
and passive benign neglect, if that term is a help...

--
Philip 

