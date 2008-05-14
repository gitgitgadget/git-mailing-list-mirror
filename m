From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: + wireless-fix-iwlwifi-unify-init-driver-flow.patch added to
 -mm tree
Date: Wed, 14 May 2008 10:50:42 -0700
Message-ID: <20080514105042.12a112e4.akpm@linux-foundation.org>
References: <200805140405.m4E45oBc015343@imap1.linux-foundation.org>
	<20080513.213927.191790810.davem@davemloft.net>
	<20080513215737.fe1bdebd.akpm@linux-foundation.org>
	<20080513.221529.20855966.davem@davemloft.net>
	<20080514123432.GB3349@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
	ron.rindjunsky@intel.com, sfr@canb.auug.org.au,
	tomas.winkler@intel.com, git@vger.kernel.org
To: "John W. Linville" <linville@tuxdriver.com>
X-From: git-owner@vger.kernel.org Wed May 14 19:52:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwL93-0004ip-DZ
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 19:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762383AbYENRvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 13:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763291AbYENRvL
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 13:51:11 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45375 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762352AbYENRvI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 May 2008 13:51:08 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4EHohIX004130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 May 2008 10:50:44 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m4EHogVB013134;
	Wed, 14 May 2008 10:50:42 -0700
In-Reply-To: <20080514123432.GB3349@tuxdriver.com>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-2.78 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82121>

On Wed, 14 May 2008 08:34:32 -0400 "John W. Linville" <linville@tuxdriver.com> wrote:

> On Tue, May 13, 2008 at 10:15:29PM -0700, David Miller wrote:
> 
> > I used to play this game, it's a lot of work and it sucks.  One
> > "drib" can require fixing up 200 patches down the chain.  And
> > I've had this happen to me all the time in the past when I was
> > rebasing all the time.
> 
> I have to agree with Dave.
> 
> Moreover, I used to get regular complaints about the old "regular
> rebase" process.  We switched to a "pull and merge" process for 2.6.25,
> and in that period nearly all of the process-related complaints
> disappeared for me.
> 

Well.  Have you ever been an hour and a half into a bisection at 3AM
then hit a massive oops deep in the TCP code which was spread across a
large number of commits?  I have and it wasn't fun.  iirc I gave up and
went to bed.

> To some degree this is a "pick your poison" issue, and for most people
> rebasing seems like the deadlier poison.

Well yes.  We'd like the best of both worlds, only we cannot have it. 
And the sole _reason_ we cannot have it is due to restrictions in git
<stimulate, stimulate>.
