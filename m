From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: wishlist: git info
Date: Tue, 13 Nov 2007 15:20:44 +0100
Organization: At home
Message-ID: <fhcbrr$ef$3@ger.gmane.org>
References: <fhad5q$iia$1@ger.gmane.org> <20071112222106.GE2918@steel.home> <4738D8AA.1030604@users.sourceforge.net> <fhaol0$p5r$1@ger.gmane.org> <fhbn50$uqu$1@ger.gmane.org> <fhbrll$ceq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 15:21:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrweK-0005kf-4l
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 15:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090AbXKMOVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 09:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753047AbXKMOVj
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 09:21:39 -0500
Received: from main.gmane.org ([80.91.229.2]:58488 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752585AbXKMOVj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 09:21:39 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Irwdw-0008KV-7I
	for git@vger.kernel.org; Tue, 13 Nov 2007 14:21:32 +0000
Received: from abvw125.neoplus.adsl.tpnet.pl ([83.8.220.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 14:21:32 +0000
Received: from jnareb by abvw125.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 14:21:32 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvw125.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64801>

Jakub Narebski wrote:
> Thomas Neumann wrote:

> You can always write[*1*] git-info.sh or git-info.perl, and install
> it as git-info in your git installation. And send patches here, to git
> mailing list, for comments.
> 
> Footnotes:
> ----------
> [*1*] Even if one of the most common complaints is "too many user-visible
>       commands".

On the other hand one of the proposed and long requested features is
git-explain, which is meant to show status of git command progress. If you
could incorporate proposed features in git-info (perhaps only with some
option: --state, --explain, -v / --verbose,...) there would be no
complaints about yet another git command.

What git-info / git-explain should show:
 * interrupted fetch / fetch in progress
 * interrupted pull  / pull  in progress
 * interrupted merge / merge in progress
 * interrupted commit, commit --amend, or tag editing
 * rebase in progress (including interactive rebase and rebasing
   using merge engine)
 * git-am (apply mbox) in progress

Perhaps we should also include git-count-objects in git-info, like
git-verify-tag functionality was included in 'git tag --verify'...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
