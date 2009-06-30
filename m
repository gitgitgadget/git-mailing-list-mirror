From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Official git repository history?
Date: Tue, 30 Jun 2009 12:01:57 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906301058100.3605@localhost.localdomain>
References: <h2aj43$ab0$1@ger.gmane.org> <7vhbxy9n9q.fsf@alter.siamese.dyndns.org> <h2chap$i27$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 21:12:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward2.uio.no ([129.240.10.71])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLik5-0007Xp-22
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 21:11:45 +0200
Received: from exim by mail-out2.uio.no with local-bsmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLiao-0001PL-1I
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 21:02:10 +0200
Received: from mail-mx3.uio.no ([129.240.10.44])
	by mail-out2.uio.no with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLiao-0001PI-08
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 21:02:10 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx3.uio.no with esmtp  (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLiam-0007YD-UW
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 21:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbZF3TB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 15:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbZF3TB4
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 15:01:56 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53926 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752514AbZF3TB4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Jun 2009 15:01:56 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5UJ1vJi024088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Jun 2009 12:01:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5UJ1vXG024014;
	Tue, 30 Jun 2009 12:01:57 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <h2chap$i27$1@ger.gmane.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.468 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3, uiobl=NO, uiouri=_URIID_)
X-UiO-Scanned: 9164F1B2B210A88988CB902787225B620EEC37CD
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 80 minaction 2 bait 0 mail/h: 11 total 2548403 max/h 849 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122528>



On Tue, 30 Jun 2009, Graeme Geldenhuys wrote:
> 
> Last night I played further with the first ever commit. I managed to 
> figure out the sequence in which commands had to be run. Kudos to the 
> people that decided the make the commands easier in the later versions. 
> :-)

Well, in all fairness, even _I_ didn't enjoy using it at that stage. It 
was all very hacky, with the manual "write-tree" + "commit-tree" stuff. 

But it's interesting to look at the timing:

 - Start early April

 - First git commit April 7

 - first kernel commit April 16

 - first merge: April 17 (14:47)

The time of that first merge is interesting, because it's worth 
correlating the git tree with the early kernel tree there. What preceded 
that first merge? Yup: the git 'merge-base' program was written a couple 
of hours before.

But the really interesting thing (to me) is that while I had tools/scripts 
to apply patches and to do relatively fancy tthings like merges etc 
basically just a couple of weeks after starting, it's telling just how 
long it took for something as simple as "git commit" to happen: May 30.

Never mind that it was actually just a totally trivial shell script, 
literally just a few lines. So it wasn't about the technology, it's very 
much a sign of what mattered to me.

I mean, I had a tool to create merges with conflicts back in mid-april! 
But something as simple as just committing the existing tree? No tools, 
you had to do that whole 

	git-update-index ..
	commit=$(git-commit-tree $(git-write-tree) -p HEAD)
	.. type in message ..
	echo $commit > .git/HEAD

song-and-dance by hand.

Or use cogito, which explains the success of early wrappers - other people 
had rather different priorities than I did.

			Linus
