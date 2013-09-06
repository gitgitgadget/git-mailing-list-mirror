From: Tim Chase <git@tim.thechases.com>
Subject: Re: coming from git, understanding mercurial branching
Date: Fri, 6 Sep 2013 14:29:27 -0500
Message-ID: <20130906142927.279a994a@bigbox.christie.dr>
References: <20130905212714.636db4c4@bigbox.christie.dr>
	<20130906175124.7d08947410503681449642ad@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 06 21:28:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI1he-0002we-TZ
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 21:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233Ab3IFT2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 15:28:19 -0400
Received: from boston.accountservergroup.com ([50.22.11.22]:46851 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751059Ab3IFT2S (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Sep 2013 15:28:18 -0400
Received: from 172-0-250-128.lightspeed.rcsntx.sbcglobal.net ([172.0.250.128]:55304 helo=bigbox.christie.dr)
	by boston.accountservergroup.com with esmtpsa (SSLv3:DHE-RSA-AES128-SHA:128)
	(Exim 4.80)
	(envelope-from <git@tim.thechases.com>)
	id 1VI1ha-0008ww-5u
	for git@vger.kernel.org; Fri, 06 Sep 2013 14:28:18 -0500
In-Reply-To: <20130906175124.7d08947410503681449642ad@domain007.com>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
X-Get-Message-Sender-Via: boston.accountservergroup.com: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234089>

On 2013-09-06 17:51, Konstantin Khomoutov wrote:
> I found this guide [1] very useful back in the time I tried to grok
> Mercurial.
> 
> 1.
> http://stevelosh.com/blog/2009/08/a-guide-to-branching-in-mercurial/

Indeed, after reading it, that's the most sense I've been able to make
of Mercurial's strange branching.  I guess it boils down to the
following rough heuristic:

- if you want to dink around locally, but don't want to publish your
  branches (yet), default to bookmarks using "hg bookmark"

- once you want a branch to be public, consider making a "real"
  branch using "hg branch"

- if you want complete isolation in case you screw up something like
  merging, use a clone


I still prefer Git's way, but at least I'm not left scratching my
head when I have to play with Mercurial branches.

Thanks, all.

-tkc
