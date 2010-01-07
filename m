From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [spf:guess] Re: [PATCH 1/2] git-svn: ignore changeless commits
	when checking for a cherry-pick
Date: Wed, 6 Jan 2010 22:49:16 -0800
Message-ID: <20100107064916.GA8557@dcvr.yhbt.net>
References: <1262808529-1575-1-git-send-email-amyrick@apple.com> <20100106214338.GA5115@dcvr.yhbt.net> <4B4510EE.4090504@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Myrick <amyrick@apple.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Jan 07 07:49:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSmBO-0000VX-Uj
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 07:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287Ab0AGGtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 01:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753590Ab0AGGtS
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 01:49:18 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:55847 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753264Ab0AGGtR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 01:49:17 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AEFA1F4F5;
	Thu,  7 Jan 2010 06:49:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4B4510EE.4090504@vilain.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136326>

Sam Vilain <sam@vilain.net> wrote:
> Eric Wong wrote:
> > Andrew Myrick <amyrick@apple.com> wrote:
> >   
> >> diff --git a/git-svn.perl b/git-svn.perl
> >
> > Hi Andrew,
> >
> > I'll again defer to Sam for Acks on these.  Test cases would be nice to
> > have, too.
> >   
> 
> They look fine to me, agreed a test case would be nice and make sure the
> features aren't lost later inadvertently.

Thanks Sam,

Shall I consider this an Ack and push Andrew's new changes
up while waiting for test cases?

-- 
Eric Wong
