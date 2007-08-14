From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance on Windows (msysgit) with latest patches
Date: Tue, 14 Aug 2007 09:22:24 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708140918480.30176@woody.linux-foundation.org>
References: <46C1735C.4050701@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 18:23:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKzAl-0007af-Jy
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 18:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758966AbXHNQXH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 12:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755453AbXHNQXF
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 12:23:05 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49379 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756297AbXHNQXD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Aug 2007 12:23:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7EGMTvl005604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 14 Aug 2007 09:22:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7EGMOHb026122;
	Tue, 14 Aug 2007 09:22:24 -0700
In-Reply-To: <46C1735C.4050701@trolltech.com>
X-Spam-Status: No, hits=-2.739 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55840>



On Tue, 14 Aug 2007, Marius Storm-Olsen wrote:
> 
> git-status got a 1.6X speed-up, and git-commit on a single file got a 2.5X
> speed-up. However, git-add and git-commit of all 100K files got a slight
> slowdown.

The slight slowdown might be noise in the measurements (for example, just 
IO differences due to layout changes). Did you run it multiple times both 
ways to see how stable the numbers are? The changes really shouldn't have 
any visible slowdown, ever.

(Of course, it may be that something else changed, or simply things like 
code layout changed cachelines etc, so small performance differences can 
be due to any number of other factors too).

			Linus
