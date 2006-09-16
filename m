From: Nathaniel Smith <njs@pobox.com>
Subject: Re: Re: cvs import
Date: Fri, 15 Sep 2006 23:21:09 -0700
Message-ID: <20060916062109.GB1779@frances.vorpus.org>
References: <45084400.1090906@bluegap.ch>
	<9e4733910609131201q7f583029r72dac66cd0dd098f@mail.gmail.com>
	<46a038f90609131341se42b2dcne73c017cf757d13a@mail.gmail.com>
	<450872AE.5050409@bluegap.ch>
	<9e4733910609131438n686b6d72u4d5799533c7473d7@mail.gmail.com>
	<4508EA78.5030001@alum.mit.edu> <20060914155003.GB9657@spearce.org>
	<450A581E.2050509@bluegap.ch> <20060916033917.GA24269@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>, monotone-devel@nongnu.org,
	Jon Smirl <jonsmirl@gmail.com>, dev@cvs2svn.tigris.org,
	Git Mailing List <git@vger.kernel.org>
X-From: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org Sat Sep 16 08:21:22 2006
Return-path: <monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org>
Envelope-to: gcvmd-monotone-devel@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOTYE-0007ly-To
	for gcvmd-monotone-devel@m.gmane.org; Sat, 16 Sep 2006 08:21:19 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1GOTYE-0008MY-9U
	for gcvmd-monotone-devel@m.gmane.org; Sat, 16 Sep 2006 02:21:18 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1GOTYA-0008K8-0h
	for monotone-devel@nongnu.org; Sat, 16 Sep 2006 02:21:14 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1GOTY9-0008Jt-C4
	for monotone-devel@nongnu.org; Sat, 16 Sep 2006 02:21:13 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1GOTY9-0008Jq-4Y
	for monotone-devel@nongnu.org; Sat, 16 Sep 2006 02:21:13 -0400
Received: from [208.210.124.79] (helo=rune.pobox.com)
	by monty-python.gnu.org with esmtp (Exim 4.52) id 1GOTaT-0003sR-TN
	for monotone-devel@nongnu.org; Sat, 16 Sep 2006 02:23:37 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 75C1680291;
	Sat, 16 Sep 2006 02:21:34 -0400 (EDT)
Received: from frances.frop.org (adsl-66-159-194-130.dslextreme.com
	[66.159.194.130]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 6C6EC8021B;
	Sat, 16 Sep 2006 02:21:27 -0400 (EDT)
Received: from njs by frances.frop.org with local (Exim 4.63)
	(envelope-from <njs@pobox.com>)
	id 1GOTY5-0000oC-EK; Fri, 15 Sep 2006 23:21:09 -0700
To: Shawn Pearce <spearce@spearce.org>
Mail-Followup-To: Shawn Pearce <spearce@spearce.org>,
	Markus Schiltknecht <markus@bluegap.ch>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	monotone-devel@nongnu.org, Jon Smirl <jonsmirl@gmail.com>,
	dev@cvs2svn.tigris.org, Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060916033917.GA24269@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-BeenThere: monotone-devel@nongnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: developer discussion for monotone <monotone-devel.nongnu.org>
List-Unsubscribe: <http://lists.nongnu.org/mailman/listinfo/monotone-devel>,
	<mailto:monotone-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/monotone-devel>
List-Post: <mailto:monotone-devel@nongnu.org>
List-Help: <mailto:monotone-devel-request@nongnu.org?subject=help>
List-Subscribe: <http://lists.nongnu.org/mailman/listinfo/monotone-devel>,
	<mailto:monotone-devel-request@nongnu.org?subject=subscribe>
Sender: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org
Errors-To: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27112>

On Fri, Sep 15, 2006 at 11:39:18PM -0400, Shawn Pearce wrote:
> On the other hand from what I understand of Monotone it needs
> the revisions in oldest->newest order, as does SVN.

Monotone stores file deltas new->old, similar to git.  It should be
reasonably efficient at turning them around if it has to, though -- so
long as you give all the versions of a single file at a time, so
there's some reasonable locality, instead of jumping all around the
tree.

-- Nathaniel

-- 
"...All of this suggests that if we wished to find a modern-day model
for British and American speech of the late eighteenth century, we could
probably do no better than Yosemite Sam."
