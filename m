From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-fast-import segfaults
Date: Fri, 26 Oct 2007 02:53:01 -0400
Message-ID: <20071026065301.GL14735@spearce.org>
References: <de47e4420710251726nb45a19fk15b3105b735a74f8@mail.gmail.com> <de47e4420710251729j5858481cg69146385a2ed798d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: cpettitt <cpettitt@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 26 08:53:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlJ4L-0006iW-Lm
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 08:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbXJZGxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 02:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752564AbXJZGxJ
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 02:53:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51858 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583AbXJZGxH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 02:53:07 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IlJ42-00084b-Jr; Fri, 26 Oct 2007 02:53:02 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CD28F20FBAE; Fri, 26 Oct 2007 02:53:01 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <de47e4420710251729j5858481cg69146385a2ed798d@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62395>

cpettitt <cpettitt@gmail.com> wrote:
> I'm seeing the following errors when I run git-fast-import (on Intel
> OSX) with some data from a git-p4 import:
...
> I believe these errors started showing up in commit
> b449f4cfc972929b638b90d375b8960c37790618. I did a bisect on
> fast-import.c and this was the first commit for that file that
> exhibits this bug with the input.
> 
> I thought I would check with the list to see if this is a known issue
> before I spend time trying to dig into it.

It is a known issue.  Someone else has reported the same thing,
and bisecting pointed at the same commit.  But they weren't able
to supply their input data for debugging by Pierre or myself as it
was a private project and they haven't had a chance to attempt to
debug it on their own.

Any light you can shed on the problem would be most appreciated.

-- 
Shawn.
