From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Test failures on cygwin (v1.6.0)
Date: Wed, 27 Aug 2008 08:12:39 +0200
Message-ID: <20080827061239.GA7805@blimp.local>
References: <48B4405E.2020507@ramsay1.demon.co.uk>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Aug 27 08:14:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYEI4-0005xa-Sr
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 08:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbYH0GMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 02:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752531AbYH0GMn
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 02:12:43 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:57403 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbYH0GMm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 02:12:42 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20hf4ELeSQ==
Received: from tigra.home (Faa6c.f.strato-dslnet.de [195.4.170.108])
	by post.webmailer.de (mrclete mo21) (RZmta 16.47)
	with ESMTP id 602124k7R4H9Mc ; Wed, 27 Aug 2008 08:12:39 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 7ED7F277AE;
	Wed, 27 Aug 2008 08:12:39 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 59F0736D1A; Wed, 27 Aug 2008 08:12:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48B4405E.2020507@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93857>

Ramsay Jones, Tue, Aug 26, 2008 19:41:50 +0200:
> Also, the new test summary shows (on Linux and cygwin):
> 
>           Linux    Cygwin
> fixed     1        3
> success   3748     3511
> failed    0        0

You have no failed tests.

> broken    2        2
> total     3751     3520
> [time:    5m47s    47m]
> 
> Note the number of fixed on cygwin. It took some time to find, but it
> appears that the additional FIXED where t0050-filsystem.sh tests
> 5 "merge (case change)" and 6 "add (with different case)".  Again, I
> haven't investigated yet.

That's normal for cygwin: the microsoft filesystems are
case-insensitive and the tests were skipped because of that.
