From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Fri, 20 Jun 2008 12:00:38 +0200
Message-ID: <20080620100038.GB10704@elte.hu>
References: <20080620082034.GA24913@elte.hu> <7v7icko61g.fsf@gitster.siamese.dyndns.org> <7v3an8o5mm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 12:02:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9dRb-0004T8-6y
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 12:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbYFTKAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 06:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbYFTKAw
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 06:00:52 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:40088 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751641AbYFTKAv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 06:00:51 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1K9dQ9-0005Ot-97
	from <mingo@elte.hu>; Fri, 20 Jun 2008 12:00:50 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 6E3A03E21DD; Fri, 20 Jun 2008 12:00:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v3an8o5mm.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0008]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85613>


* Junio C Hamano <gitster@pobox.com> wrote:

> By the way, not linking --reverse (traverse the history normally and 
> then show the commits in the reverse order than usual) to -R (show 
> diff in the opposite way while showing the change each commit 
> introduces) allows you to even say "log --reverse -R", which did not 
> come from a conscious design, but being able to say this _is_ a 
> conscious design:
> 
> 	$ git fetch j6t
> 	$ git log --reverse -p ..j6t/for-junio
> 
> When I review a branch somebody else offers me, I may want to view the 
> commits on them in reverse order (so that they build a bit by bit on 
> top of my tree), but I _certainly_ do not want to view the patch in 
> reverse!

yes, i too do that occasionally (and some of my export/import scripts 
rely on it in fact), and i was not suggesting to change any existing 
functionality anyway.

	Ingo
