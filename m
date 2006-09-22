From: "Matthias Urlichs" <matthias@urlichs.de>
Subject: Re: Git user survey and `git pull`
Date: Fri, 22 Sep 2006 21:05:23 +0000 (UTC)
Message-ID: <ef1j6j$8sn$1@sea.gmane.org>
References: <20060921162401.GD3934@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sat Sep 23 08:10:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR0iX-0003VV-G6
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 08:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWIWGKW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 02:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWIWGKW
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 02:10:22 -0400
Received: from main.gmane.org ([80.91.229.2]:36033 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751102AbWIWGKV (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 02:10:21 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GR0iC-0003Qu-2F
	for git@vger.kernel.org; Sat, 23 Sep 2006 08:10:04 +0200
Received: from smurf.noris.de ([192.109.102.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Sep 2006 08:10:04 +0200
Received: from matthias by smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Sep 2006 08:10:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: smurf.noris.de
User-Agent: pan 0.109 (Beable)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27564>

For what it's worth, I'm in favor of renaming the things.

IMHO, we do not need that kind of baggage. Sure, you explain it once and
people hopefully remember -- except that they don't, not always anyway,
and novice users can't be expected to be notice, let alone repair, that
kind of damage.

*I* make that stupid pull/fetch/merge mistake sometimes, 
and I'm not exactly new to git...


On Thu, 21 Sep 2006 12:24:01 -0400, Shawn Pearce wrote:

>   Current            Shoulda Been
>   ---------------    ----------------
>   git-push           git-push
>   git-fetch          git-pull
>   git-pull . foo     git-merge foo
>   git-pull           git-pull --merge
>   git-merge          git-merge-driver
> 
The new programs can (for the most part) recognize when they're called with
"old" semantics, and spit out a warning.

-- 
Matthias Urlichs
