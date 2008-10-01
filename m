From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Make maximum surf time really per day
Date: Wed, 1 Oct 2008 16:09:56 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810011606550.3341@nehalem.linux-foundation.org>
References: <alpine.LFD.2.00.0810011240390.3575@nehalem.linux-foundation.org> <alpine.DEB.1.00.0810012229390.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.DEB.1.00.0810012239030.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 02 01:11:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlAqd-0002bx-M6
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 01:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbYJAXKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 19:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbYJAXKB
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 19:10:01 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59128 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751571AbYJAXKA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2008 19:10:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m91N9unM003257
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 1 Oct 2008 16:09:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m91N9uMW009218;
	Wed, 1 Oct 2008 16:09:56 -0700
In-Reply-To: <alpine.DEB.1.00.0810012239030.22125@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.431 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97279>



On Wed, 1 Oct 2008, Johannes Schindelin wrote:
> 
> Earlier, when the maximum time was reached, we would block for 8 hours.
> The program description suggested that the maximum time should be per
> day instead, however.  So rather check that.

I actually prefer the old behavior. Your new one has a "flag time" when 
you get all your time back, and it's not even something logical like 
midnight, it is (if I read the patch right), "midnight UTC" that will do 
it.

So the "you have to be offline for at least 8 hours" thing is actually 
something that even my old tracker worked with, and at least with my kids, 
there is no worry that they'd wake up early just to do it both before 
_and_ after school ;)

		Linus
