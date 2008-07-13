From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] bash completion: Improve responsiveness of git-log
	completion
Date: Mon, 14 Jul 2008 00:12:02 +0200
Message-ID: <20080713221202.GA4204@elte.hu>
References: <20080713023742.GA31760@spearce.org> <7vy745piqy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 00:13:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI9oj-0003Wm-4z
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 00:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124AbYGMWMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 18:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754121AbYGMWMS
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 18:12:18 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:60084 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754096AbYGMWMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 18:12:16 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KI9nZ-0000XY-1y
	from <mingo@elte.hu>; Mon, 14 Jul 2008 00:12:13 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 221D13E2205; Mon, 14 Jul 2008 00:12:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vy745piqy.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88352>


* Junio C Hamano <gitster@pobox.com> wrote:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Junio noticed the bash completion has been taking a long time lately....
> 
> The credit actually goes to Ingo.
> 
> > Petr Baudis tracked it down to 72e5e989b ("bash: Add space after
> > unique command name is completed.").  Tracing the code showed
> > we spent significant time inside of this loop within __gitcomp,
> > due to the string copying overhead....
> > ...
> >  Does this make things better?  Or worse?  I'm not seeing a huge
> >  difference on my own system.  Maybe its too fast these days...
> 
> Ingo, I understand you have stopped using the completion long time ago 
> due to this latency issue.  Together with d773c63 (bash: offer only 
> paths after '--', 2008-07-08) that already is in 'maint' and 'master', 
> this hopefully would make the completion usable for you again?

yeah. I've checked out the latest version and applied Shawn's patch and 
added the patched contrib/completion/git-completion.bash back to my 
.bashrc and i'm not seeing the latencies anymore.

Thanks! Please consider this fixed - will follow up if there's any 
problem left.

	Ingo
