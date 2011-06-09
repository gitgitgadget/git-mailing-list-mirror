From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Command-line interface thoughts
Date: Thu, 9 Jun 2011 15:30:43 +0200
Message-ID: <201106091530.43555.trast@student.ethz.ch>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <4DF08D30.7070603@alum.mit.edu> <4DF09A3D.8040908@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Jun 09 15:37:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUfPw-0000tN-3X
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 15:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757646Ab1FINgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 09:36:55 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:30205 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756020Ab1FINgy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 09:36:54 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jun 2011 09:36:54 EDT
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.289.1; Thu, 9 Jun
 2011 15:30:41 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.289.8; Thu, 9 Jun
 2011 15:30:43 +0200
User-Agent: KMail/1.13.7 (Linux/2.6.39.1-31-desktop; KDE/4.6.3; x86_64; ; )
In-Reply-To: <4DF09A3D.8040908@op5.se>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175524>

Andreas Ericsson wrote:
> On 06/09/2011 11:06 AM, Michael Haggerty wrote:
> > THEIRS -- equivalent to the tree from MERGE_HEAD
> 
> Except there might be any number of THEIRS in the case of an octopus
> merge. The most common case is just one though.

Not really, the current implementation bails out and tells you not to
use an octopus:

  Trying simple merge with t/man-unquote-apos-3
  Simple merge did not work, trying automatic merge.
  Auto-merging Documentation/Makefile
  ERROR: content conflict in Documentation/Makefile
  Auto-merging Makefile
  fatal: merge program failed
  Automated merge did not work.
  Should not be doing an Octopus.
  Merge with strategy octopus failed.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
