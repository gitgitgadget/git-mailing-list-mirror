From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: can't commit files that have been git add'ed because "fatal: you need to resolve your current index first"
Date: Wed, 28 Nov 2007 16:53:47 +0100
Organization: At home
Message-ID: <fik2ua$i8b$1@ger.gmane.org>
References: <820179.5481.qm@web55002.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 16:57:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxPI7-0006pf-3c
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 16:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756989AbXK1P5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 10:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757238AbXK1P5Q
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 10:57:16 -0500
Received: from main.gmane.org ([80.91.229.2]:60366 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756972AbXK1P5P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 10:57:15 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IxPGi-0003PR-4l
	for git@vger.kernel.org; Wed, 28 Nov 2007 15:56:08 +0000
Received: from abvr156.neoplus.adsl.tpnet.pl ([83.8.215.156])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 15:56:08 +0000
Received: from jnareb by abvr156.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 15:56:08 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvr156.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66363>

Bill Priest wrote:

> All,
>   I merged from one branch to another and had lots of
> conflicts.  I've resolved a set of files from the
> conflicts (in a directory) and did a git-add on this
> set of files.  I wasn't able to commit these files. 
> On IRC I was told that all files must be resolved
> before I can commit any of them.  This seems pretty
> limiting.  Why is a commit after a merge all or
> nothing; I thought that git  figured out merges and
> such by the differences between files??

You have to resolve _conflicts_ only. The rest is added
automatically. See git-status, git diff --merge,
git ls-files -u.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
