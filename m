From: Andreas Ericsson <ae@op5.se>
Subject: Re: StGit hooks
Date: Wed, 28 Nov 2007 15:58:13 +0100
Message-ID: <474D8205.8030401@op5.se>
References: <9e4733910711271417l32ed9a77p9915aa34a780665b@mail.gmail.com>	 <9e4733910711271512g790364e0ka4839b2be9fd4935@mail.gmail.com>	 <20071128093403.GB12977@diana.vm.bytemark.co.uk>	 <20071128101718.GA13940@diana.vm.bytemark.co.uk>	 <474D5482.5020609@op5.se>	 <20071128121905.GA15953@diana.vm.bytemark.co.uk>	 <474D69A7.6020404@op5.se>	 <20071128132605.GB15953@diana.vm.bytemark.co.uk>	 <474D7710.4090303@op5.se> <9e4733910711280653q119f2c2n173eaebdda6cd774@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-15?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 15:58:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxONC-00044Q-DH
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 15:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756569AbXK1O60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 09:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756413AbXK1O60
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 09:58:26 -0500
Received: from mail.op5.se ([193.201.96.20]:33794 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753397AbXK1O6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 09:58:25 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id DCC871F08054;
	Wed, 28 Nov 2007 15:58:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7VVz4xt9Oj5y; Wed, 28 Nov 2007 15:58:16 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 695BD1F08052;
	Wed, 28 Nov 2007 15:58:16 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <9e4733910711280653q119f2c2n173eaebdda6cd774@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66351>

Jon Smirl wrote:
> I would expect 'stg init' to switch the branch to using the stgit
> hooks and only those hooks. Branches that were not inited would
> continue to use the user hooks. I don't have any user hooks, but this
> is what I would expect to happen.
> 

Obviously the stgit-installed hook will have to check if the branch
the user is operating on is managed by stgit before it prevents git
rebase (or whatever it's supposed to do).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
