X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Fri, 08 Dec 2006 12:25:05 +0100
Organization: At home
Message-ID: <elbhu9$ke2$1@sea.gmane.org>
References: <Pine.LNX.4.64.0612061847190.3615@woody.osdl.org> <45778AA3.7080709@zytor.com> <Pine.LNX.4.64.0612061940170.3615@woody.osdl.org> <4577A84C.3010601@zytor.com> <Pine.LNX.4.64.0612070953290.3615@woody.osdl.org> <45785697.1060001@zytor.com> <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org> <457868AA.2030605@zytor.com> <20061207193012.GA84678@dspnet.fr.eu.org> <4578722E.9030402@zytor.com> <20061207235039.GA423@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 8 Dec 2006 11:23:16 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 31
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33687>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsdow-0006vB-5X for gcvg-git@gmane.org; Fri, 08 Dec
 2006 12:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425403AbWLHLXF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 06:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425359AbWLHLXF
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 06:23:05 -0500
Received: from main.gmane.org ([80.91.229.2]:59521 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1425403AbWLHLXC
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 06:23:02 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gsdoe-0002Sr-RJ for git@vger.kernel.org; Fri, 08 Dec 2006 12:22:57 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 12:22:56 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 08 Dec 2006
 12:22:56 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Olivier Galibert wrote:

> On Thu, Dec 07, 2006 at 11:57:34AM -0800, H. Peter Anvin wrote:
>> Olivier Galibert wrote:
>>>On Thu, Dec 07, 2006 at 11:16:58AM -0800, H. Peter Anvin wrote:
>>>>
>>>>Unfortunately, the most common queries are also extremely expensive.
>>>
>>>Do you have a top-ten of queries ?  That would be the ones to optimize
>>>for.
>> 
>> The front page, summary page of each project, and the RSS feed for each 
>> project.
> 
> Hmmm, maybe you could have the summaries and rss feed generated on
> push, which could also generate elementary files with lines of the
> front page.  That would make these top offenders static page serving.

The "extremely aggresive caching solution" could be as follows: cache
everything, invalidate (remove) on push caches of variable variety related
to push (list of projects and OPML on any push; summary page and every
page without h=<hash> or hb=<hash>;f=<filename> for a given project).

The most important problem is that kernel.org uses old gitweb, the last
version before incorporating gitweb into git (and also reducing
significantly the time needed for summary, heads and tags pages).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

