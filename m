From: Georg-Johann Lay <avr@gjlay.de>
Subject: subversion-perl missing
Date: Mon, 26 Sep 2011 13:48:59 +0200
Message-ID: <4E8066AB.7000208@gjlay.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 13:49:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R89gS-00068m-20
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 13:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671Ab1IZLtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 07:49:10 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:42770 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391Ab1IZLtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 07:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1317037746; l=1261;
	s=domk; d=gjlay.de;
	h=Content-Transfer-Encoding:Content-Type:Subject:To:MIME-Version:From:
	Date:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=p+HGaMqLMIPWWyfFxzQ0DQBpO20=;
	b=KCjIMpmlP/TQMj6dirqRao7xJGhR/R7kgTsRO0UAot7JMw6feTWWULD0VEIxJeJzV6/
	bhiZwfklXDxolUMSQiv3AXEKoVddhQOys63MF8hyKg20AMGSXytttuaiZXQ62AkpZvg45
	pjp6OS/UwueUghcd+/st0m5qb6Ph2ouEJlU=
X-RZG-AUTH: :LXoWVUeid/7A29J/hMvvT2k715jHQaJercGObUOFkj18odoYNahU4Q==
X-RZG-CLASS-ID: mo00
Received: from [192.168.0.22]
	(business-188-111-022-002.static.arcor-ip.net [188.111.22.2])
	by smtp.strato.de (fruni mo26) (RZmta 26.8)
	with ESMTPA id t00051n8Q9e1fR ; Mon, 26 Sep 2011 13:48:59 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.24 (X11/20100302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182103>

Hi, I just downloaded git and built from source, version is

git version 1.7.6.4

I am particularly interested in git-svn, but running it I get complaints

Initialized empty Git repository in /local/Downloads/v4.5.x/.git/
Can't locate SVN/Core.pm in @INC (@INC contains:
/usr/local/lib/perl5/site_perl/5.10.0/i586-linux-thread-multi
/usr/local/lib/perl5/site_perl/5.10.0
/usr/lib/perl5/5.10.0/i586-linux-thread-multi /usr/lib/perl5/5.10.0
/usr/lib/perl5/site_perl/5.10.0/i586-linux-thread-multi
/usr/lib/perl5/site_perl/5.10.0
/usr/lib/perl5/vendor_perl/5.10.0/i586-linux-thread-multi
/usr/lib/perl5/vendor_perl/5.10.0 /usr/lib/perl5/vendor_perl .) at
/usr/local/libexec/git-core/git-svn line 42

I found out that a module like subversion-perl is missing, but installing it
via OpenSuse 1.11 would downgrade my SVN installation, so I skipped that.

Thus, being no admin and no perl guy, I am stuck now and am asking here for
some kind help, being very well aware that it's not a git issue but just about
getting some prerequisite for git.

Where do I have to go to get the svn+perl stuff? Couldn't locate anything like
that in subversion.tigris.org, so that I am stuck and need some hints on how to
proceed.

Many thanks,

Johann
