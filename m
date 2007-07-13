From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Volume of commits
Date: Fri, 13 Jul 2007 02:40:41 +0200
Organization: At home
Message-ID: <f76hm5$fde$1@sea.gmane.org>
References: <m3ps2xu5hc.fsf@pc7.dolda2000.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 02:42:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I99DW-00030t-Mf
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 02:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867AbXGMAlC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 20:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754655AbXGMAlA
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 20:41:00 -0400
Received: from main.gmane.org ([80.91.229.2]:53628 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753415AbXGMAlA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 20:41:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I99DH-00023q-9Z
	for git@vger.kernel.org; Fri, 13 Jul 2007 02:40:51 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Jul 2007 02:40:51 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Jul 2007 02:40:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52351>

Fredrik Tolf wrote:


> When I develop for myself, I usually commit incrementally quite a
> bit, if for no other reason because Git won't let me switch between
> branches if I don't commit first. I usually try to keep my commits
> well-defined, but I don't manage to get anywhere close to what I see
> when I look at the history of Linux or Git.

First, if you commit only to switch branches you can always instead
of adding commit on top of whis WIP commit, just --amend it.

Second, there is git-stash just created for saving state to go back
to it.

Third, I guess that the neat patch series are result of reworking
existing series using tools like StGIT (which I use and find very
nice to work with, going and correcting back and forth between patches
in series), or guilt (similar to StGIT), or git-gui, or new interactive mode
of git-rebase, or git-cherry-pick...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
