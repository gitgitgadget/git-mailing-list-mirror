From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-grep: small suggestion, -w flag
Date: Sun, 22 Feb 2009 18:23:00 +0100
Message-ID: <20090222172300.GF6570@elte.hu>
References: <20090222103448.GA32119@elte.hu> <49A133C9.2030601@lsrfire.ath.cx> <20090222161410.GA24886@elte.hu> <20090222172055.GW4371@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Feb 22 18:24:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbI4F-0007uG-5x
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 18:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754470AbZBVRXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 12:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753504AbZBVRXJ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 12:23:09 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:39969 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752407AbZBVRXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 12:23:09 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1LbI2g-0000O7-Kr
	from <mingo@elte.hu>; Sun, 22 Feb 2009 18:23:05 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 684C43E2132; Sun, 22 Feb 2009 18:23:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090222172055.GW4371@genesis.frugalware.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111027>


* Miklos Vajna <vmiklos@frugalware.org> wrote:

> On Sun, Feb 22, 2009 at 05:14:10PM +0100, Ingo Molnar <mingo@elte.hu> wrote:
> >  earth4:~/tip> git grep -lw schedule
> >  usage: git grep <option>* [-e] <pattern> <rev>* [[--] <path>...]
> > 
> > 
> > should have been 'git grep -l -w schedule'.
> 
> Yeah, that's because git-grep does not use parseopt yet.
> 
> I'm willing to work on it once mv/parseopt-ls-files is settled 
> down.

As long as it's planned eventually i'm a happy camper! No rush.

	Ingo
