From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Backing git repos to tape?
Date: Sun, 25 Nov 2007 12:05:08 +0100
Organization: At home
Message-ID: <fibkt4$q6g$1@ger.gmane.org>
References: <027601c82f52$2433fdf0$5267a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 25 12:06:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwFJ0-0006HZ-Uh
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 12:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbXKYLFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 06:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752644AbXKYLFZ
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 06:05:25 -0500
Received: from main.gmane.org ([80.91.229.2]:57781 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752556AbXKYLFY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 06:05:24 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IwFIa-0006Gy-Vv
	for git@vger.kernel.org; Sun, 25 Nov 2007 11:05:16 +0000
Received: from abwq234.neoplus.adsl.tpnet.pl ([83.8.240.234])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Nov 2007 11:05:16 +0000
Received: from jnareb by abwq234.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Nov 2007 11:05:16 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwq234.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65967>

[Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>, git@vger.kernel.org]

Joakim Tjernlund wrote:

> Is there a preferred way to do the above?
> 
> To do a full backup I could just copy the whole repo, but how
> do I do inrecmental backups(and restore)?

Try git-bundle. There were in the mailing list archive the recipe
on how to do an "incremental" bundle...

...ahh, there it is, by Johannes "Dscho" Schindelin:

        git bundle create retort.bundle --all \
                --not $(git ls-remote the-other.bundle | cut -c1-40)

Message-ID: <Pine.LNX.4.64.0711231132120.27959@racer.site>

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
