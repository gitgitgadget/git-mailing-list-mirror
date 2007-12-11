From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-bisect feature suggestion: "git-bisect diff"
Date: Tue, 11 Dec 2007 15:05:08 +0100
Message-ID: <20071211140508.GA12204@elte.hu>
References: <20071207093439.GA21896@elte.hu> <200712080636.12982.chriscool@tuxfamily.org> <20071211092446.GA4703@elte.hu> <20071211092916.GF30948@artemis.madism.org> <m3ve75sfn3.fsf@roke.D-201> <20071211115914.GJ30948@artemis.madism.org> <20071211122539.GA13945@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 11 15:06:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J25k7-0002QE-5h
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 15:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361AbXLKOFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 09:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752367AbXLKOFa
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 09:05:30 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:45025 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752303AbXLKOF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 09:05:29 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1J25jW-0007Nk-3F
	from <mingo@elte.hu>; Tue, 11 Dec 2007 15:05:20 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 82E793E2193; Tue, 11 Dec 2007 15:05:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071211122539.GA13945@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67858>


* Jeff King <peff@peff.net> wrote:

> On Tue, Dec 11, 2007 at 12:59:14PM +0100, Pierre Habouzit wrote:
> 
> > > Not exactly, as it does not give us email address.
> > 
> >   maybe it should be "fixed" so that it does, not to mention that other
> > concerns ingo raised look legit to me.
> 
> Perhaps Junio is a time-traveller.
> 
> $ git show 4602c17d
> commit 4602c17d8911e14d537f6f87db02faab6e3f5d69
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Fri Dec 7 17:19:31 2007 -0800
> 
>     git-shortlog -e: show e-mail address as well
> 
>     This option shows the author's email address next to the name.
> 
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>

please switch around the column too so that the commit count comes 
first, this is way too ugly:

 Junio C Hamano: 4826
 Shawn O. Pearce: 1146
 Linus Torvalds: 950
 Johannes Schindelin: 497
 Eric Wong: 383
 Jakub Narebski: 317
 Simon Hausmann: 243
 Nicolas Pitre: 235

	Ingo
