From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb, updating 'last changed' column on the project page
Date: Sat, 10 Nov 2007 02:58:06 +0100
Organization: At home
Message-ID: <fh337a$ggp$1@ger.gmane.org>
References: <9e4733910711091709k173bf23flf2824673f82de9bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 10 02:58:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqfcI-0007K5-Gk
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 02:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbXKJB6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 20:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbXKJB6R
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 20:58:17 -0500
Received: from main.gmane.org ([80.91.229.2]:58767 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442AbXKJB6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 20:58:16 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Iqfbw-0006CK-2J
	for git@vger.kernel.org; Sat, 10 Nov 2007 01:58:12 +0000
Received: from abvp178.neoplus.adsl.tpnet.pl ([83.8.213.178])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Nov 2007 01:58:12 +0000
Received: from jnareb by abvp178.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Nov 2007 01:58:12 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvp178.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64297>

Jon Smirl wrote:

> At http://git.digispeaker.com/ the 'last change' column is not getting updated.
> 
> mpc5200b.git
>       DigiSpeaker for Freescale MPC5200B.
>       Jon Smirl
>       5 weeks ago
>       summary | shortlog | log | tree
> 
> It still says 5 weeks ago, but if I click on the project last change is today.
> 
> What controls this? I tried running update-server-info

What does

  git for-each-ref --format="%(refname):%09%(committer)" --sort=-committerdate
      refs/heads

return? Does adding --count select proper branch, with proper update
date?

Which gitweb version is this?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
