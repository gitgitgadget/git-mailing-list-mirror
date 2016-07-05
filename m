Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2721C20706
	for <e@80x24.org>; Tue,  5 Jul 2016 13:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932995AbcGENZF (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 09:25:05 -0400
Received: from plane.gmane.org ([80.91.229.3]:58114 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754491AbcGENYj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 09:24:39 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bKQL7-0006At-MN
	for git@vger.kernel.org; Tue, 05 Jul 2016 15:24:37 +0200
Received: from acvd198.neoplus.adsl.tpnet.pl ([83.11.109.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Jul 2016 15:24:37 +0200
Received: from jnareb by acvd198.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Jul 2016 15:24:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Subject: Re: Missing Package in git Installation Instructions (git-scm.com)
Date:	Tue, 5 Jul 2016 15:24:23 +0200
Message-ID: <577BB507.1060603@gmail.com>
References: <1467670411.13990.4.camel@gmail.com>
 <alpine.DEB.2.20.1607050807320.8378@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@ger.gmane.org
Cc:	git@vger.kernel.org
X-Gmane-NNTP-Posting-Host: acvd198.neoplus.adsl.tpnet.pl
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <alpine.DEB.2.20.1607050807320.8378@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-05 o 08:10, Johannes Schindelin pisze:
> Hi Chris,
> 
> On Tue, 5 Jul 2016, Christoph Michelbach wrote:
> 
>> Hi, I noticed that the instructions on https://git-scm.com/book/en/v2/G
>> etting-Started-Installing-Git don't work without dh-autoreconf
>> installed on an apt-get system which isn't listed on that site. Can you
>> fix that or tell me whom to tell about this? The website doesn't offer
>> contact information. Just tried this on a fresh Ubuntu 16.04
>> installation.
> 
> When you follow that link, do you see this text on the left side?
> 
> 	The source of this book is hosted on GitHub.
> 	Patches, suggestions and comments are welcome.
> 
> It links to https://github.com/progit/progit2 and I am sure your bug
> report would make an excellent contribution to the bug tracker ("Issues")
> in that repository.
> 
> It would probably be even better if you cloned said repository, found the
> respective file via `git grep apt-get`, fixed it, and opened a Pull
> Request.

Or you can even fix it from a web interface, if you have a GitHub account.
Behind the scene, GitHub would fork a repository, edit file and create
a commit, then create a pull request.  Very easy for one-off fixes, assuming
that you have a GitHub account.

-- 
Jakub Narębski


