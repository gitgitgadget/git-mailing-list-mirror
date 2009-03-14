From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: fetch--tool, was Re: Migrate bisect to C
Date: Sat, 14 Mar 2009 13:09:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903141308180.10279@pacific.mpi-cbg.de>
References: <20090312085103.e83b34a5.chriscool@tuxfamily.org> <200903130702.01039.chriscool@tuxfamily.org> <7vfxhhj4mh.fsf@gitster.siamese.dyndns.org> <200903140846.17599.chriscool@tuxfamily.org> <7v63iccydg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>, John Tapsell <johnflux@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 13:09:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiSg1-0006VJ-5O
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 13:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430AbZCNMHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 08:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754372AbZCNMHr
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 08:07:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:32790 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750844AbZCNMHq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 08:07:46 -0400
Received: (qmail invoked by alias); 14 Mar 2009 12:07:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp020) with SMTP; 14 Mar 2009 13:07:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18QillaeuwQPhFzpdThlCGXbREuyBStjfJbsV3WCU
	gfWcCqC+8xnrNI
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v63iccydg.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113246>

Hi,

On Sat, 14 Mar 2009, Junio C Hamano wrote:

> 	Side note.  That was how git-fetch--tool was started; it was a 
> 	helper to partially migrate slower parts of git-fetch.sh to C.  I 
> 	suspect we can almost remove it but not quite yet...

Funny.  I was looking at that last week, and yes, there is still a user.  
Through several functions in parse-remote.sh, git-pull.sh uses 
fetch--tool.

Now, git-pull.sh is not all that large/complicated...

Ciao,
Dscho
