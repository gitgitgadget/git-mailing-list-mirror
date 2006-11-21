X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Is there a way to trim old SHAs from a git tree (so it's not so
 large)?
Date: Tue, 21 Nov 2006 23:53:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611212349440.26827@wbgn013.biozentrum.uni-wuerzburg.de>
References: <455B90AD.3060707@freescale.com> <20061117103611.183640@gmx.net>
 <45632957.5070205@freescale.com> <20061121163206.GA22006@spearce.org>
 <45632EC6.5030902@freescale.com> <20061121165656.GC22006@spearce.org>
 <456330CD.9080503@freescale.com> <20061121183941.GB22283@spearce.org>
 <45637457.1010505@freescale.com> <Pine.LNX.4.63.0611212306060.26827@wbgn013.biozentrum.uni-wuerzburg.de>
 <45638212.8030501@freescale.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 21 Nov 2006 22:56:45 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Thomas Kolejka <Thomas.Kolejka@gmx.at>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45638212.8030501@freescale.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32052>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmeWn-0006t4-KV for gcvg-git@gmane.org; Tue, 21 Nov
 2006 23:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161023AbWKUWxy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 17:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031294AbWKUWxi
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 17:53:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:23973 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1031308AbWKUWxd (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 17:53:33 -0500
Received: (qmail invoked by alias); 21 Nov 2006 22:53:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp046) with SMTP; 21 Nov 2006 23:53:31 +0100
To: Timur Tabi <timur@freescale.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 21 Nov 2006, Timur Tabi wrote:

> I think you mean git-clone.sh instead of git-clone.

No. If "git clone" does not work for you, the compilation failed. Do you 
run git in-place? Then you _have_ to set

	bindir=$(pwd)

in config.mak. Otherwise, the git wrapper (you wrote "git-clone", but then 
you used "git clone") will look in $(HOME)/bin for your executables, and I 
bet that you have the other (official) git installed there.

> However, git-clone.sh is not quite working either.  I had to run 
> git-daemon on my machine, because git-clone.sh doesn't like the http 
> protocol, and my firewall blocks everything but that.

For now, shallow clones only work with the git protocol, i.e. via 
git-daemon and ssh.

Hth,
