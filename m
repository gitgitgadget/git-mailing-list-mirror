From: Ingo Molnar <mingo@elte.hu>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Thu, 24 Jul 2008 17:29:12 +0200
Message-ID: <20080724152912.GB23585@elte.hu>
References: <20080723130518.GA17462@elte.hu> <20080723135621.GJ22606@neumann> <20080723140441.GA9537@elte.hu> <7vy73seb2p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 17:30:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM2lt-0004a8-CT
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 17:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbYGXP3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 11:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757224AbYGXP3Z
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 11:29:25 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:51477 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755524AbYGXP3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 11:29:24 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KM2km-0005Xk-Rx
	from <mingo@elte.hu>; Thu, 24 Jul 2008 17:29:22 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id B86893E21AB; Thu, 24 Jul 2008 17:29:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vy73seb2p.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89895>


* Junio C Hamano <gitster@pobox.com> wrote:

> (with patch)
> 0.15user 0.03system 0:00.18elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k

> (without patch)
> 0.58user 0.03system 0:00.61elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k

cool - a 3.3x speedup :-) Will check that out.

	Ingo
