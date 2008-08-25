From: bdowning@lavos.net (Brian Downing)
Subject: Re: [RFC] mtn to git conversion script
Date: Mon, 25 Aug 2008 16:09:32 -0500
Message-ID: <20080825210932.GL31114@lavos.net>
References: <94a0d4530808240218j4bedbe3di99303da9addc93a4@mail.gmail.com> <20080825163530.GJ31114@lavos.net> <94a0d4530808251347g4d6246bv7ebd5cc86294dd05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, monotone-devel@nongnu.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 23:10:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXjKs-0005lK-TJ
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 23:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbYHYVJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 17:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753377AbYHYVJq
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 17:09:46 -0400
Received: from qmta02.emeryville.ca.mail.comcast.net ([76.96.30.24]:37396 "EHLO
	QMTA02.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753309AbYHYVJq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Aug 2008 17:09:46 -0400
Received: from OMTA14.emeryville.ca.mail.comcast.net ([76.96.30.60])
	by QMTA02.emeryville.ca.mail.comcast.net with comcast
	id 6jf81a00H1HpZEsA2l9dch; Mon, 25 Aug 2008 21:09:37 +0000
Received: from mnementh.lavos.net ([98.212.138.194])
	by OMTA14.emeryville.ca.mail.comcast.net with comcast
	id 6l9a1a00L4BqYqi8al9bez; Mon, 25 Aug 2008 21:09:36 +0000
X-Authority-Analysis: v=1.0 c=1 a=powJzsOIrdUA:10 a=kob-ntAsRcggK0ah0OoA:9
 a=BjpkM1vyilypnEvolFjdm34cSP0A:4 a=GB4YReQY-hoA:10 a=LY0hPdMaydYA:10
Received: by mnementh.lavos.net (Postfix, from userid 1000)
	id C1E06309F23; Mon, 25 Aug 2008 16:09:32 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <94a0d4530808251347g4d6246bv7ebd5cc86294dd05@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93679>

On Mon, Aug 25, 2008 at 11:47:53PM +0300, Felipe Contreras wrote:
> On Mon, Aug 25, 2008 at 7:35 PM, Brian Downing <bdowning@lavos.net> wrote:
> > Here's a simple monotone to git converter I wrote.  You'll need the
> > Monotone::AutomateStdio perl module to use it (which I think I got it
> > from monotone's net.venge.monotone.contrib.lib.automate-stdio branch).
> > It is very fast; it can convert the OpenEmbedded repo in something like
> > 5-10 minutes on my machine.
> 
> Interesting, how many commits?

:; git rev-list --all | wc -l
23498 revisions
:; git ls-tree -r org.openembedded.stable | wc -l
17502 files in HEAD

(Some of those files are .gitignore files, which I create in every
directory to hold open empty ones.)

-bcd
