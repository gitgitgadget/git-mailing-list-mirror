From: Bill Lear <rael@zopyra.com>
Subject: Re: Git rescue mission
Date: Thu, 8 Feb 2007 17:25:49 -0600
Message-ID: <17867.45437.922483.805945@lisa.zopyra.com>
References: <17866.27739.701406.722074@lisa.zopyra.com>
	<Pine.LNX.4.64.0702080858430.8424@woody.linux-foundation.org>
	<17867.40122.51865.575762@lisa.zopyra.com>
	<Pine.LNX.4.64.0702081408140.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Feb 09 00:26:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFIeY-00083M-KT
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 00:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296AbXBHX0H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 18:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965223AbXBHX0H
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 18:26:07 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61895 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752296AbXBHX0G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 18:26:06 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l18NPtL04156;
	Thu, 8 Feb 2007 17:25:55 -0600
In-Reply-To: <Pine.LNX.4.64.0702081408140.8424@woody.linux-foundation.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39121>

On Thursday, February 8, 2007 at 14:13:47 (-0800) Linus Torvalds writes:
>...
>It's one of the bigger UI warts that got fixed since the last release 
>(although it got fixed by better config management, and as such you'll 
>only *see* the fixes if you end up doing the initial clone with the new 
>git version - if you use a new git version with an old repo, many - but 
>not all - bad semantics will remain).
>...

With regard to the new version and old repos, am I correct in assuming
that we can upgrade our old repo (a bare one) to the new git by first
installing the new git, and then doing this:

% cd /repos/git
% mv project project.old_git
% git --bare clone project.old_git project

or is there something else we must do?


Bill
