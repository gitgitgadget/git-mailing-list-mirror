From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC, PATCH] git send-email: Make --no-chain-reply-to the default
Date: Tue, 10 Nov 2009 08:19:27 +0100
Message-ID: <20091110071927.GB11942@elte.hu>
References: <1257786206-9208-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
 <1257789555.4108.348.camel@laptop>
 <20091110040847.GC29454@elte.hu>
 <7v4op3gd6f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <peterz@infradead.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 08:19:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7l0y-0005EY-6i
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 08:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbZKJHTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 02:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbZKJHT3
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 02:19:29 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:36391 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034AbZKJHT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 02:19:29 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1N7l0m-00069g-2b
	from <mingo@elte.hu>; Tue, 10 Nov 2009 08:19:32 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 78B543E22F5; Tue, 10 Nov 2009 08:19:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v4op3gd6f.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.5
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132541>


* Junio C Hamano <gitster@pobox.com> wrote:

> [Footnote]
> 
> *1* To spell it out...  The people who are in the "hate chain-reply-to 
> very much" camp would have already done their own configuration to get 
> the behaviour they want by now, so changing the default would not help 
> them much, while potentially hurting "love chain-reply-to" people who 
> have been content because they got what they wanted without setting 
> any configuration.

Stupid question: i researched the Git mailing list archive (and read the 
link you provided) and found no arguments (at all) in favor of the 
nested chaining. Are you aware of any?

And i dont 'hate' it - i am just the one suffering from it as a 
maintainer. _I_ can certainly fix my scripts as you suggest above, but 
that is not my problem: my problem are the many people sending 
first-time Git based patch series to me (and there's quite a few of 
them) always, in every single case, get it wrong.

The ones not using Git (using Quilt for example) and sending me series 
get it right in pretty much every case.

So i can see it when developers start using Git to submit patches - in 
each and every case - the discussion threading is all messed up ;-)

These people dont 'do their own configuration' - they are mostly newbies 
or developrs new to Git workflows. And the first reaction they get from 
their upstream maintainer counterpart is some grumbling about the 
threading. Not good, me thinks ;-)

	Ingo
