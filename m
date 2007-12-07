From: Al Boldi <a1426z@gawab.com>
Subject: Re: git guidance
Date: Fri, 7 Dec 2007 07:37:18 +0300
Message-ID: <200712070737.18519.a1426z@gawab.com>
References: <20071129105220.v40i22q4gw4cgoso@intranet.digizenstudio.com> <200712072155.04643.a1426z@gawab.com> <Pine.LNX.4.64.0712062119090.21625@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Phillip Susi <psusi@cfl.rr.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jing Xue <jingxue@digizenstudio.com>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 07 05:42:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0V39-0000Ge-2m
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 05:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbXLGEmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 23:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753109AbXLGEmc
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 23:42:32 -0500
Received: from [212.12.190.105] ([212.12.190.105]:40442 "EHLO raad.intranet"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752973AbXLGEmb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 23:42:31 -0500
Received: from localhost ([10.0.0.111])
	by raad.intranet (8.8.7/8.8.7) with ESMTP id HAA13594;
	Fri, 7 Dec 2007 07:40:52 +0300
User-Agent: KMail/1.5
In-Reply-To: <Pine.LNX.4.64.0712062119090.21625@wbgn129.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67377>

Johannes Schindelin wrote:
> Hi,

Hi

> On Fri, 7 Dec 2007, Al Boldi wrote:
> > You need to re-read the thread.
>
> I don't know why you write that, and then say thanks.  Clearly, what you
> wrote originally, and what Andreas pointed out, were quite obvious
> indicators that git already does what you suggest.
>
> You _do_ work "transparently" (whatever you understand by that overused
> term) in the working directory, unimpeded by git.

If you go back in the thread, you may find a link to a gitfs client that 
somebody kindly posted.  This client pretty much defines the transparency 
I'm talking about.  The only problem is that it's read-only.

To make it really useful, it has to support versioning locally, disconnected 
from the server repository.  One way to implement this, could be by 
committing every update unconditionally to an on-the-fly created git 
repository private to the gitfs client.

With this transparently created private scratch repository it should then be 
possible for the same gitfs to re-expose the locally created commits, all 
without any direct user-intervention.

Later, this same scratch repository could then be managed by the normal 
git-management tools/commands to ultimately update the backend git 
repositories.

BTW:  Sorry for my previous posts that contained the wrong date; it seems 
that hibernation sometimes advances the date by a full 24h.  Has anybody 
noticed this as well?


Thanks!

--
Al
