From: walt <wa1ter@myrealbox.com>
Subject: Re: Problem with Linus's git repository?
Date: Thu, 28 Jun 2007 06:37:49 -0700 (PDT)
Organization: none
Message-ID: <Pine.LNX.4.64.0706280632540.5321@x2.ybpnyarg>
References: <f5r8q5$pbr$1@sea.gmane.org> <alpine.LFD.0.98.0706260935440.8675@woody.linux-foundation.org>
   <Pine.LNX.4.64.0706270636140.7038@x2.ybpnyarg>
 <alpine.LFD.0.98.0706270932040.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 28 16:42:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3vCU-000812-VC
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 16:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754199AbXF1OmZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 10:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbXF1OmY
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 10:42:24 -0400
Received: from psmtp-in.myrealbox.com ([72.8.126.107]:2702 "EHLO myrealbox.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753799AbXF1OmY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 10:42:24 -0400
X-Greylist: delayed 3824 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jun 2007 10:42:23 EDT
Received: from k2 wa1ter@myrealbox.com [69.234.197.172]
	by myrealbox.com with M+ Extreme Email Engine 5.0.0
	via secured & encrypted transport (TLS);
	Thu, 28 Jun 2007 07:39:07 -0600
X-MailFrom: wa1ter@myrealbox.com
In-Reply-To: <alpine.LFD.0.98.0706270932040.8675@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51112>



On Wed, 27 Jun 2007, Linus Torvalds wrote:

>
>
> On Wed, 27 Jun 2007, walt wrote:
> > >
> > > It's not missing, it's packed. I tend to re-pack after I make a release,
> > > and this time I did it after -rc6...
> >
> > Sometime overnight this problem disappeared.  I haven't actually
> > tested this idea, but I have a hunch that your commit yesterday
> > of "Fix zero-object version-2 packs" is the reason.
>
> No, I think the reason is simply that I pushed more updates to kernel.org,
> so now the kernel git repo has an explicit and separate "master" branch
> again.
>
> What is your git version? The _real_ fix probably is to just upgrade. Are
> you using that broken(*) Debian git package by any chance?

No, every morning I pull from you and Junio and Petr Baudis using cg-update,
so I'm very much current.  I notice that cg-update specifically does an
http GET on kernel/git/torvalds/linux-2.6.git/HEAD which is actually a
symlink to your refs/heads/master.  Your 'master' now exists, but didn't
exist two days ago as far I could see from my end.

The kernel.org server returned a 'you don't have permission to read
kernel/git/torvalds/linux-2.6.git/HEAD on this server', not a 404.
I tried two different ftp clients which also could not see your
'master' file until yesterday.

I notice that Petr hasn't made any changes to cogito for a long
time, so maybe it needs some updating?  Dunno.



--- Scanned by M+ Guardian Messaging Firewall ---
