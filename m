From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: configurable home link string
Date: Tue, 15 Aug 2006 18:15:05 +0200
Organization: At home
Message-ID: <ebsrsn$tgq$1@sea.gmane.org>
References: <11555958491891-git-send-email-yashi@atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Aug 15 18:15:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD1Z3-0002sn-Qd
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 18:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbWHOQOr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 12:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWHOQOr
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 12:14:47 -0400
Received: from main.gmane.org ([80.91.229.2]:12222 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030361AbWHOQOq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Aug 2006 12:14:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GD1Yt-0002q5-5o
	for git@vger.kernel.org; Tue, 15 Aug 2006 18:14:39 +0200
Received: from host-81-190-28-152.torun.mm.pl ([81.190.28.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 18:14:39 +0200
Received: from jnareb by host-81-190-28-152.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 18:14:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-28-152.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25460>

Yasushi SHOJI wrote:

> I've always found difficult to figure out git URL for clone from
> gitweb URL because git:// and http:// are different on many site
> including kernel.org.
> 
> I've found this enhancement at http://dev.laptop.org/git when I was on
> git channel, and thought that it'd be nice if all public gitweb site
> show it's git URL on its page.
> 
> This patch allow us to change the home link string.  The current
> default is "projects" as we all see on gitweb now.
> 
> ie. kernel.org might set this variable to "git://git.kernel.org/pub/scm/"
> 
> Signed-off-by: Yasushi SHOJI <yashi@atmark-techno.com>

There is similar improvement in gitweb-xmms2, where the git clone/fetch
URL for an individual project is visible in the "summary" page for project,
see e.g.
  http://git.xmms.se/?p=gitweb-xmms2.git;a=summary

I plan on implementing such a feature, with an improvement that URL is not
displayed if $git_base_url (your $home_link_str) is not defined (e.g.
repository is not published)... or you can reimplement this feature.
 
http://git.xmms.se/?p=gitweb-xmms2.git;a=commit;h=8e327dfbdebedd0c5fc02fe606fd4675b43237d7

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
