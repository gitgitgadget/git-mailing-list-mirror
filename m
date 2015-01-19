From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Regarding the determinacy of 'git describe'
Date: Mon, 19 Jan 2015 17:10:18 +0100
Message-ID: <20150119161018.GA12632@inner.h.apk.li>
References: <20150116130113.GA3220@inner.h.apk.li> <20150116132917.GB7660@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 17:10:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDEuJ-0001o5-N5
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 17:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbbASQKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2015 11:10:23 -0500
Received: from continuum.iocl.org ([217.140.74.2]:60414 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbbASQKW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2015 11:10:22 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id t0JGAIv13497;
	Mon, 19 Jan 2015 17:10:18 +0100
Content-Disposition: inline
In-Reply-To: <20150116132917.GB7660@inner.h.apk.li>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262636>

On Fri, 16 Jan 2015 14:29:17 +0000, Andreas Krey wrote:
...
> === /tmp/tmp-ws-20150116-11355-v7zfcc
> 
> searching to describe HEAD
>  lightweight        4 r2.4/bl-0
>  lightweight        4 r2.4/bl-1
> traversed 5 commits
> r2.4/bl-0-4-g689e350

Apparently, this comes because two of the commit have the same timestamp,
affecting the log ordering (and presumably the order in which they
are used by 'git describe' as well). Also explains why it happens with
different probability on different machines.

But should 'git describe' behave this way?

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
