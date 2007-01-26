From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] diff --check: use colour
Date: Fri, 26 Jan 2007 18:26:39 +0100
Organization: At home
Message-ID: <epddi9$f2r$1@sea.gmane.org>
References: <Pine.LNX.4.63.0701241505260.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vr6tkdnee.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701251015390.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vk5za925w.fsf@assigned-by-dhcp.cox.net> <17849.13327.527531.262943@lisa.zopyra.com> <Pine.LNX.4.63.0701260034320.22628@wbgn013.biozentrum.uni-wuerzburg.de> <17850.8953.478146.754550@lisa.zopyra.com> <17850.10014.251824.979660@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 18:26:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAUps-0007b8-U3
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 18:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbXAZRZ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 12:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbXAZRZ5
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 12:25:57 -0500
Received: from main.gmane.org ([80.91.229.2]:40714 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752017AbXAZRZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 12:25:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HAUpa-0001EI-0M
	for git@vger.kernel.org; Fri, 26 Jan 2007 18:25:42 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 18:25:41 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 18:25:41 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37876>

[Cc: git@vger.kernel.org]

Bill Lear wrote:

> On Friday, January 26, 2007 at 09:49:13 (-0600) Bill Lear writes:
>>...
>>Assuming that is correct, I should have a patch out before the end of
>>the day.
> 
> I did this:
> 
> git format-patch -s HEAD^
> 
> it produced this file:
> 
> 0001-Document-check-option-to-git-diff.patch
> 
> which looks to be formatted as a mail message:
> 
>>From 2a81f1e97564b89ab622cf32b68e7cebf605eafe Mon Sep 17 00:00:00 2001
>>From: Bill Lear <rael@zopyra.com>
>>Date: Fri, 26 Jan 2007 09:58:07 -0600
>>Subject: [PATCH] Document --check option to git-diff.
>>
>>
>>Signed-off-by: Bill Lear <rael@zopyra.com>
>>---
>> Documentation/diff-options.txt |    5 +++++
>> Documentation/git-diff.txt     |    6 ++++++
>> 2 files changed, 11 insertions(+), 0 deletions(-)
>>...
> 
> 
> Do I optionally edit this file, putting my comments before the
> "Signed-off-by" line, and then just send this off to the list with my
> mail command, i.e.:

Before "Signed-off-by" line you put commit message. Any coments
which are not meant to be in commit message (like for example reply
to some email) are to be put after "---" line, but before diffstat.

Read Documentation/SubmittingPatches

> % mail git@vger.kernel.org < 0001-Document-check-option-to-git-diff.patch

This should work.

% git send-email --to git@vger.kernel.org 0001-Document-check-option-to-git-diff.patch

should also work.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
