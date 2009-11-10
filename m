From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC, PATCH] git send-email: Make --no-chain-reply-to the default
Date: Tue, 10 Nov 2009 19:29:42 +0100
Message-ID: <20091110182942.GA15677@elte.hu>
References: <1257786206-9208-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
 <1257789555.4108.348.camel@laptop>
 <20091110040847.GC29454@elte.hu>
 <7v4op3gd6f.fsf@alter.siamese.dyndns.org>
 <20091110071927.GB11942@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <peterz@infradead.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 19:30:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7vTe-0007xo-BT
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 19:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757528AbZKJS3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 13:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757508AbZKJS3v
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 13:29:51 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:49881 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752693AbZKJS3u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 13:29:50 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1N7vTP-0006NE-US
	from <mingo@elte.hu>; Tue, 10 Nov 2009 19:29:53 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id C30053E22E0; Tue, 10 Nov 2009 19:29:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091110071927.GB11942@elte.hu>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx2.mail.elte.hu: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.2.5
	_SUMMARY_
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132585>


* Ingo Molnar <mingo@elte.hu> wrote:

> * Junio C Hamano <gitster@pobox.com> wrote:
> 
> > [Footnote]
> > 
> > *1* To spell it out...  The people who are in the "hate 
> > chain-reply-to very much" camp would have already done their own 
> > configuration to get the behaviour they want by now, so changing the 
> > default would not help them much, while potentially hurting "love 
> > chain-reply-to" people who have been content because they got what 
> > they wanted without setting any configuration.
> 
> Stupid question: i researched the Git mailing list archive (and read 
> the link you provided) and found no arguments (at all) in favor of the 
> nested chaining. Are you aware of any?

Btw., dont get me wrong - i'm perfectly happy with the fix in 1.7.0. You 
are also right that behavioral changes dont belong into stable releases.

( I'm just seeing this problem through the biased eyes of someone who is
  affected by it, so i naturally want to have the benefit of the change
  ASAP - without fully perceiving the risks of the change.)

Thanks,

	Ingo
