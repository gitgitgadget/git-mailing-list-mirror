From: Alexander Strasser <eclipse7@gmx.net>
Subject: Re: [PATCH v2] diff: Only count lines in show_shortstats
Date: Fri, 15 Jun 2012 23:19:41 +0200
Message-ID: <20120615211941.GA26486@akuma>
References: <20120615190248.GA28377@akuma>
 <7vr4tg9xhr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	mj@ucw.cz
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 23:20:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sfdvx-0001vY-R2
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 23:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755737Ab2FOVTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 17:19:54 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:49462 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751755Ab2FOVTx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 17:19:53 -0400
Received: (qmail invoked by alias); 15 Jun 2012 21:19:50 -0000
Received: from p5DC36C83.dip.t-dialin.net (EHLO gmx.net) [93.195.108.131]
  by mail.gmx.net (mp035) with SMTP; 15 Jun 2012 23:19:50 +0200
X-Authenticated: #8251126
X-Provags-ID: V01U2FsdGVkX18LPpxazdsL8vh8RnbvqSjK8apoUrab6Hox10GXKb
	/HOXUBOKdhHTl2
Received: by gmx.net (sSMTP sendmail emulation); Fri, 15 Jun 2012 23:19:41 +0200
Content-Disposition: inline
In-Reply-To: <7vr4tg9xhr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200100>

Hi,

Junio C Hamano wrote:
> Alexander Strasser <eclipse7@gmx.net> writes:
> 
> > Do not mix byte and line counts. Binary files have byte counts;
> > skip them when accumulating line insertions/deletions.
> >
> > The regression was introduced in e18872b.
> >
> > Signed-off-by: Alexander Strasser <eclipse7@gmx.net>
> > ---
> 
> Administrivia.
> 
> Please do not use Mail-Followup-To: header to deflect direct

  I did not know about that mail header. I am not sure about the
exact ramifications but I hope I told my MUA to stop inserting
that header behind my back.

[...]
> > +test_expect_success 'diff --shortstat output for binary file change' '
> > +	echo " 4 files changed, 2 insertions(+), 2 deletions(-)" >expected &&
> > +	git diff --shortstat >current &&
> > +	test_i18ncmp expected current
> > +'
> > +
> 
> It would also have been interesting if we can see the result for a
> diff that involves _only_ binary files, no?

  Seems like an interesting test to me. I will add it and send as v3
in a moment.

[...]

  Alexander
