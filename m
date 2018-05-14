Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1620B1F406
	for <e@80x24.org>; Mon, 14 May 2018 19:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbeENT5f (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 15:57:35 -0400
Received: from ikke.info ([178.21.113.177]:56830 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751422AbeENT5f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 15:57:35 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id AC1AE4400D0; Mon, 14 May 2018 21:57:33 +0200 (CEST)
Date:   Mon, 14 May 2018 21:57:33 +0200
From:   Kevin Daudt <me@ikke.info>
To:     "Barodia, Anjali (Nokia - IN/Noida)" <anjali.barodia@nokia.com>
Cc:     "repo-discuss@googlegroups.com" <repo-discuss@googlegroups.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git push error due to hooks error
Message-ID: <20180514195733.GA22721@alpha>
References: <AM4PR0701MB2116C3BBD0A1E4892EAB09BB8A9C0@AM4PR0701MB2116.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM4PR0701MB2116C3BBD0A1E4892EAB09BB8A9C0@AM4PR0701MB2116.eurprd07.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 14, 2018 at 05:44:06PM +0000, Barodia, Anjali (Nokia - IN/Noida) wrote:
> Hi Support,
> 
> 
> I was trying to push local git to another git on gerrit, but stuck with an hook error.
> This is a very large repo and while running the command "git push origin --all"
> I am getting this errors:
> 
> remote: (W) 92e19d4: too many commit message lines longer than 70 characters; manually wrap lines
> remote: (W) de2245b: too many commit message lines longer than 70 characters; manually wrap lines
> remote: (W) dc6e982: too many commit message lines longer than 70 characters; manually wrap lines
> remote: (W) d2e2efd: too many commit message lines longer than 70 characters; manually wrap lines
> remote: error: internal error while processing changes To ssh_url_path:8282/SI_VF.git
>  ! [remote rejected]   master -> master (Error running hook /opt/gerrit/hooks/re    f-update)
> error: failed to push some refs to 'ssh_user@url_path:8282/SI_VF.git'
> 
> I tried to push after deleting the .git/hooks, but still get the same error.
> Please help me in fixing this error.
> 
> Thanks with Regards,
> Anjali Barodia

Did you remove the hook from the remote repo, or the local repo? Because
this is a hook which runs on the repo you are pushing too. Something
like pre-receive or pre-update is causing this.

Kevin
