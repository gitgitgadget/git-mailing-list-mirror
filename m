From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: stgit: lost all my patches again
Date: Tue, 27 Nov 2007 23:24:02 +0100
Organization: At home
Message-ID: <fii5dv$qc4$1@ger.gmane.org>
References: <9e4733910711271417l32ed9a77p9915aa34a780665b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 23:24:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix8r0-0006yc-KY
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 23:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbXK0WYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 17:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbXK0WYL
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 17:24:11 -0500
Received: from main.gmane.org ([80.91.229.2]:47459 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907AbXK0WYK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 17:24:10 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ix8qb-0002Yf-79
	for git@vger.kernel.org; Tue, 27 Nov 2007 22:24:05 +0000
Received: from abvx114.neoplus.adsl.tpnet.pl ([83.8.221.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 22:24:05 +0000
Received: from jnareb by abvx114.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 22:24:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvx114.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66268>

Jon Smirl wrote:

> My fingers are too trained in doing "git rebase linus/master" instead
> of "stg rebase linus/master". This has resulting in me losing my patch
> stack again. I updated stg to the current version and tried "stg
> repair"  put all my patches are still empty.
> 
> What's the easiest way to recover?

git reset --hard $(cat .git/patches/<branch>/orig-base)

or perhaps "git reset --hard ORIG_HEAD"; with new rebase working on
detached head "git reset --hard @{1}".

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
