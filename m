From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: Git log of all (modifying) commands run on a repo?
Date: Thu, 08 Feb 2007 09:26:39 +0100
Organization: eudaptics software gmbh
Message-ID: <45CADEBF.D1F286BD@eudaptics.com>
References: <17866.20355.744025.133326@lisa.zopyra.com> <Pine.LNX.4.64.0702071441160.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 08 09:26:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF4bp-00005m-74
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 09:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161543AbXBHIZ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 03:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422936AbXBHIZ2
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 03:25:28 -0500
Received: from main.gmane.org ([80.91.229.2]:52506 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161550AbXBHIZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 03:25:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HF4ab-0000CR-Rp
	for git@vger.kernel.org; Thu, 08 Feb 2007 09:25:09 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 09:25:09 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 09:25:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39045>

Linus Torvalds wrote:
> 
> On Wed, 7 Feb 2007, Bill Lear wrote:
> >
> > I thought that it would be very useful to have a history of git
> > commands that have been run against a repo, in order to hopefully
> > debug this sort of thing --- perhaps only those that modify the repo.
> 
> The "reflog" is kind of that, and you can literally do
> 
>         less .git/logs/refs/heads/master
> 
> to get some kind of idea what's up.

Or something like this:

find .git/logs -type f | xargs cat | sort -t'>' -k2 -n | less

-- Hannes
