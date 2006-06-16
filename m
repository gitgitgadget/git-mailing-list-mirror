From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Why so much time in the kernel?
Date: Fri, 16 Jun 2006 19:09:28 +0200
Organization: At home
Message-ID: <e6uok3$vvq$1@sea.gmane.org>
References: <9e4733910606160749t4d7a541ev72a67383e96d86da@mail.gmail.com> <Pine.LNX.4.64.0606160755170.5498@g5.osdl.org> <9e4733910606160825hb538d6fo4c9f1d7d9768e100@mail.gmail.com> <Pine.LNX.4.64.0606160906250.5498@g5.osdl.org> <9e4733910606161000t53328571u10a350eca894ccdc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jun 16 19:10:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrHpY-0006xO-2r
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 19:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWFPRJy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 13:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWFPRJy
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 13:09:54 -0400
Received: from main.gmane.org ([80.91.229.2]:62669 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750711AbWFPRJx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 13:09:53 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FrHpI-0006ty-Kg
	for git@vger.kernel.org; Fri, 16 Jun 2006 19:09:45 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Jun 2006 19:09:44 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Jun 2006 19:09:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21948>

Jon Smirl wrote:

> Is it a crazy idea to read the cvs files, compute an sha1 on each
> expanded delta and then write the delta straight into a pack file?

That's what parsecvs does (i.e. read *,v files directly).
See http://git.or.cz/gitwiki/InterfacesFrontendsAndTools

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
