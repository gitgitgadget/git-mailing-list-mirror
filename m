Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF6861F78F
	for <e@80x24.org>; Mon,  1 May 2017 17:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751221AbdEARHR (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 13:07:17 -0400
Received: from ikke.info ([178.21.113.177]:50714 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750871AbdEARHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 13:07:16 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 79CD5440082; Mon,  1 May 2017 19:07:14 +0200 (CEST)
Date:   Mon, 1 May 2017 19:07:14 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Robert Eisele <robert@xarg.org>, git@vger.kernel.org
Subject: Re: Bug: Git rename does not work if folder naming was changed from
 lower to upper case on OSX
Message-ID: <20170501170714.GA17703@alpha.vpn.ikke.info>
References: <10d4f73b-b4bd-4cf8-5727-cdaf10ab713a@xarg.org>
 <20170429201813.GA19256@alpha.vpn.ikke.info>
 <xmqqshkpic0e.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqshkpic0e.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 30, 2017 at 06:47:29PM -0700, Junio C Hamano wrote:
> Kevin Daudt <me@ikke.info> writes:
> 
> > Note that git does not store that files are renamed. So a remove + add
> > is the same as a rename in git. Only git status shows it when you for
> > example use git mv directly, but this information is lost on commit.
> 
> Are you sure about the last sentence?  I do not recall teaching
> anything special to "git status".  If "git status" says A was
> created by renaming B, and if you committed that state was-is, "git
> show" on the result commit _should_ say the same thing, I would
> think.

Yes, of course, you are right. Git status also detects a file being
renamed instead of relying on it being recorded.
> 
> > Instead of storing it get relies on detecting what (parts of ) files got
> > renamed, copied etc.
> 
> That statement I belieave is true.

Why are you reserved here?

Kevin.
