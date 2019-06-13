Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C376B1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 17:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbfFMRLY (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 13:11:24 -0400
Received: from ariake.ledovskis.lv ([92.222.72.25]:60608 "EHLO
        ariake.ledovskis.lv" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729168AbfFMRLI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 13:11:08 -0400
Received: by ariake.ledovskis.lv (Postfix, from userid 1000)
        id 7A70F5DB84; Thu, 13 Jun 2019 20:11:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ledovskis.lv; s=mail;
        t=1560445866; bh=74bZ1Y6JUet0flrb6ZkCKL483vO35RkfCQEs5ql06Vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x8VSrSplxxy8eCufOxVrOtZ3QZj1gVGk6xcIpc+H9ryBIpbiMWFtsXZmuf+FMNztk
         SLoVrcR57udHIoScQC17cX4FRV5minrqH2+BhlU6SKwXis/PUNXSy8SqpOGnMcmWUp
         1AJe/0dIM0t7hFnwzviwvZtWT2TOWyaQHoXkaqQKWvwiwKQOEtsa+Cro0H4+0rRfcw
         zS8oBfizEN16LQf9/iqWsd7KF7Ti1dyA3wf/njcjxGzBg16ZU1JwAR6WpV73wshCcw
         upMgDdf0Tyg2FDcAFO17V90uY95coyPmSsjVt9QKcnRn7SVUOftd40/uaIF1qacKSO
         13kWIQpiAp9KA==
Date:   Thu, 13 Jun 2019 20:11:06 +0300
From:   Aleksandrs =?utf-8?Q?=C4=BBedovskis?= <aleksandrs@ledovskis.lv>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Espen Antonsen <espen@inspired.no>, git@vger.kernel.org
Subject: Re: Git status parse error after v.2.22.0 upgrade
Message-ID: <20190613171106.GC3919@ariake.ledovskis.lv>
References: <3bc58c33-4268-4e7c-bf1a-fe349b3cb037@www.fastmail.com>
 <nycvar.QRO.7.76.6.1906112127420.789@QRFXGBC-DHN364S.ybpnyqbznva>
 <38b0f33a-1da1-4231-802e-ae14d9843ad2@www.fastmail.com>
 <nycvar.QRO.7.76.6.1906122046400.789@QRFXGBC-DHN364S.ybpnyqbznva>
 <20190613093023.GA3919@ariake.ledovskis.lv>
 <xmqqr27xwjwj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqr27xwjwj.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 13, 2019 at 09:05:16AM -0700, Junio C Hamano wrote:
> are you getting it when you run "git status" command???

Yes, the regular old porcelain `git-status(1)`.

$ git status
error: could not parse '<<full contents of .git/sequencer/todo here>>'
On branch <<some-branch>>
nothing to commit, working tree clean

--
Best,
Aleksandrs Ļedovskis
