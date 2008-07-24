From: Ingo Molnar <mingo@elte.hu>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Thu, 24 Jul 2008 17:27:42 +0200
Message-ID: <20080724152742.GA23585@elte.hu>
References: <20080723130518.GA17462@elte.hu> <20080723135621.GJ22606@neumann> <20080723140441.GA9537@elte.hu> <7v8wvscqtm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 17:29:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM2kW-0003zb-VS
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 17:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbYGXP16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 11:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754730AbYGXP16
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 11:27:58 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:51079 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754679AbYGXP15 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 11:27:57 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KM2jI-0005Rd-IU
	from <mingo@elte.hu>; Thu, 24 Jul 2008 17:27:50 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 7EABD3E21AB; Thu, 24 Jul 2008 17:27:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v8wvscqtm.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89894>


* Junio C Hamano <gitster@pobox.com> wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> 
> > hm, it's very slow:
> >
> >   $ time git branch --no-merged
> >   [...]
> >
> >   real    0m9.177s
> >   user    0m9.027s
> >   sys     0m0.129s
> >
> > when running it on tip/master:
> >
> >   http://people.redhat.com/mingo/tip.git/README
> 
> Hmmm, does not reproduce for me with a copy of that repository.

perhaps you need to run tip-create-local-branches.sh to create all the 
local branches? You can find it in:

  tip/tip .tip/bin/tip-create-local-branches.sh

(does/should the presence of local branches matter?)

	Ingo
