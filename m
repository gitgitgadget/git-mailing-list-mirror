From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Fri, 20 Jun 2008 12:02:24 +0200
Message-ID: <20080620100224.GC10704@elte.hu>
References: <20080620082034.GA24913@elte.hu> <7v7icko61g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 12:03:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9dSu-0004vH-JA
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 12:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbYFTKCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 06:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbYFTKCh
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 06:02:37 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:40759 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751566AbYFTKCg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 06:02:36 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1K9dRr-0005hv-4Y
	from <mingo@elte.hu>; Fri, 20 Jun 2008 12:02:35 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 117A93E21DD; Fri, 20 Jun 2008 12:02:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v7icko61g.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0019]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85614>


* Junio C Hamano <gitster@pobox.com> wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> 
> >     a) -R is not recognized by git-diff (so i cannot just standardize 
> >        myself on -R and have to waste neurons on remembering the 
> >        distinction ;-)
> 
> Huh?  Have you actually tried "git diff -R"?  My copy of git 1.0.0 
> knows about it.  What year are you still in ;-)?

yeah, i tried it and somehow messed up so this is a red herring - i'll 
just use -R from now on :-)

the HEAD..^ format suggestion still stands, to express the range from 
HEAD to HEAD-1.

	Ingo
