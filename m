From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 14 Sep 2007 14:30:28 -0400
Message-ID: <20070914183028.GV3099@spearce.org>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org> <7v1wd1d0le.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 20:35:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWFw4-0006Ul-Ks
	for gcvg-git-2@gmane.org; Fri, 14 Sep 2007 20:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755345AbXINSad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 14:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755135AbXINSac
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 14:30:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40124 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754870AbXINSac (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 14:30:32 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IWFwE-0005v0-MO; Fri, 14 Sep 2007 14:30:46 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 046CD20FBAE; Fri, 14 Sep 2007 14:30:29 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v1wd1d0le.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58172>

Junio C Hamano <gitster@pobox.com> wrote:
> * db/fetch-pack (Fri Sep 14 03:31:25 2007 -0400) 22 commits
...
> This is Daniel's fetch-pack in C plus fixups from Shawn.
> Unfortunately the fixups breaks t3200 ("*** glibc detected ***
> fetch: free(): invalid pointer xxx ***"), which I haven't looked
> into yet.

Doesn't crash out on my Mac OS X system but I am getting the
above failure on my amd64 Linux system.  I'm debugging it now.
I'll have to quit in about an hour and pick it up later, so don't
expect a patch immediately.  But I'll certainly send something soon.
Clearly I made a change in my fixups that I shouldn't have.  ;-)

-- 
Shawn.
