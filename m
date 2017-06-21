Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E9FD20282
	for <e@80x24.org>; Wed, 21 Jun 2017 04:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750991AbdFUEwN (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 00:52:13 -0400
Received: from ikke.info ([178.21.113.177]:49334 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750836AbdFUEwN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 00:52:13 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 318FC4400AB; Wed, 21 Jun 2017 06:52:11 +0200 (CEST)
Date:   Wed, 21 Jun 2017 06:52:11 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Small issue with "add untracked" option of 'git add -i'
Message-ID: <20170621045211.GA30634@alpha.vpn.ikke.info>
References: <1497278015.7302.13.camel@gmail.com>
 <xmqqwp8hnm1v.fsf@gitster.mtv.corp.google.com>
 <xmqqshj5nl3o.fsf@gitster.mtv.corp.google.com>
 <1498013726.5419.1.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498013726.5419.1.camel@gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2017 at 08:25:26AM +0530, Kaartic Sivaraam wrote:
> 
> I tried applying the patch and building it locally. For some reason I
> couldn't see the change in effect. What could I be missing?
> 

Did you make sure you used the git you built, and also the relevant
subcommands?

What does `which git` and git --exec-path return?

If you did not install git, but try to run it in the compiled dir, you
can better run bin-wrappers/git, which will make sure the correct sub
commands are run.
