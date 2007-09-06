From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Thu, 6 Sep 2007 00:59:42 -0400
Message-ID: <20070906045942.GR18160@spearce.org>
References: <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 07:00:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT9T7-0006ea-Vo
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 06:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbXIFE7t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 00:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbXIFE7t
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 00:59:49 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39673 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbXIFE7t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 00:59:49 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IT9Sy-0003ZW-Kc; Thu, 06 Sep 2007 00:59:44 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3E4B220FBAE; Thu,  6 Sep 2007 00:59:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57817>

Dmitry Kakurin <dmitry.kakurin@gmail.com> wrote:
> When I first looked at Git source code two things struck me as odd:
> 1. Pure C as opposed to C++. No idea why. Please don't talk about 
> portability, it's BS.

Git's creator (Linus) codes in C, not C++.  He has at various times
stated reasons why he does not use C++.  I'm sure one can find such
messages with a bit of searching on mailing lists that he frequents.
He has his reasons.  I also happen to agree with at least some
of them.  :)

Git evolved from that initial prototype that Linus created.  I'm not
sure how much code survives from that initial few versions that
Linus managed before Junio took over, but nobody wanted to rewrite
things that already work so it just stayed in C.
"If it works, don't fix it."

C works.  We (now) have 83,215 lines of it.  Its not going away
anytime soon in Git.  It is also a relatively simple language that
a large number of open source programmers know.  This makes it easy
for them to get involved in the project.  Instead of say Haskell,
which has a smaller community.  Or Tcl/Tk as we recently found out
in the Git User Survey.  :-\

-- 
Shawn.
