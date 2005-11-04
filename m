From: Chris Wedgwood <cw@f00f.org>
Subject: Re: binary safe?
Date: Thu, 3 Nov 2005 19:49:10 -0800
Message-ID: <20051104034910.GB5179@taniwha.stupidest.org>
References: <86br115r0z.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0511031447020.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 04:50:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXsb1-0002q1-VB
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 04:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030564AbVKDDuF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 22:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030595AbVKDDuF
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 22:50:05 -0500
Received: from [216.184.48.14] ([216.184.48.14]:35060 "HELO main.xsigo.com")
	by vger.kernel.org with SMTP id S1030564AbVKDDuE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2005 22:50:04 -0500
Received: from stupidest.org ([10.10.253.1]) by main.xsigo.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 3 Nov 2005 19:49:40 -0800
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 98572528F22; Thu,  3 Nov 2005 19:49:10 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511031447020.27915@g5.osdl.org>
X-OriginalArrivalTime: 04 Nov 2005 03:49:40.0230 (UTC) FILETIME=[C89BFA60:01C5E0F2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11119>

On Thu, Nov 03, 2005 at 02:50:21PM -0800, Linus Torvalds wrote:

> So the _only_ problem should be "git diff" (and related patch-based
> tools - git-apply etc). They'll simply not work. For similar
> reasons, a three-way merge will obviously fail.

I always thought it would be nice for binary files if SCMs could
export a summary of what ranges of bytes changes or even xdelta'ish
details.

Given that people do stick large multi-MB binary blobs in SCMs and
sometimes these update only a few bytes at a time it has some value.
