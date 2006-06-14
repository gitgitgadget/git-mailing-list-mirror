From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Porcelain specific metadata under .git?
Date: Wed, 14 Jun 2006 13:32:25 +0200
Organization: At home
Message-ID: <e6os3v$r5g$1@sea.gmane.org>
References: <20060614062240.GA13886@spearce.org> <448FEED7.30701@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Jun 14 13:32:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqTbv-0005GM-Rj
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 13:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWFNLc1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 07:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWFNLc1
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 07:32:27 -0400
Received: from main.gmane.org ([80.91.229.2]:29578 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932350AbWFNLc0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jun 2006 07:32:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FqTbk-0005EE-I4
	for git@vger.kernel.org; Wed, 14 Jun 2006 13:32:24 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jun 2006 13:32:24 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jun 2006 13:32:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21840>

Andreas Ericsson wrote:

> Shawn Pearce wrote:
>> 
>> I already assume/know that refs/heads and refs/tags are completely
>> off-limits as they are for user refs only.
>> 
>> I also think the core GIT tools already assume that anything
>> directly under .git which is strictly a file and which is named
>> entirely with uppercase letters (aside from "HEAD") is strictly a
>> temporary/short-lived state type item (e.g. COMMIT_MSG) used by a
>> Porcelain.
>> 
>> But is saying ".git/refs/eclipse-workspaces" is probably able to
>> be used for this purpose safe?  :-)
>> 
> 
> .git/eclipse/whatever-you-like
> 
> would probably be better. Heads can be stored directly under .git/refs 
> too. Most likely, nothing will ever be stored under ./git/eclipse by 
> either core git or the current (other) porcelains though.

I think if it is a ref, which one wants to be visible to git-fsck (and
git-prune), it should be under .git/refs.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
