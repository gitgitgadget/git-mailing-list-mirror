From: Ping Yin <pkufranky@gmail.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words configurable
Date: Tue, 13 May 2008 09:37:53 +0800
Organization: (kooxoo Corp.)
Message-ID: <20080513013753.GA17536@kooxoo235>
References: <46dff0320805061815k6aca9020g285b09da2bcf29c3@mail.gmail.com> <alpine.DEB.1.00.0805071223450.30431@racer> <7viqxqc4gs.fsf@gitster.siamese.dyndns.org> <20080508103436.GB3300@mithlond.arda.local> <46dff0320805100202j54b0922cy50a2c93c4eff1757@mail.gmail.com> <46dff0320805110616s6df19657r1e4c80634267fd81@mail.gmail.com> <7vod7c6c24.fsf@gitster.siamese.dyndns.org> <46dff0320805120931u7609a5a2x5433d78e35a62c48@mail.gmail.com> <m34p934afu.fsf@localhost.localdomain> <7vve1jxrg9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Ping Yin <pkufranky@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 03:38:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvjTd-00087E-Ds
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 03:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756494AbYEMBh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 21:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756430AbYEMBh7
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 21:37:59 -0400
Received: from mail.qikoo.org ([60.28.205.235]:41386 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755904AbYEMBh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 21:37:58 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 77F1E470AE; Tue, 13 May 2008 09:37:53 +0800 (CST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ping Yin <pkufranky@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vve1jxrg9.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81979>

* Junio C Hamano <gitster@pobox.com> [2008-05-12 12:17:26 -0700]:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
> >> To achieve the best, we have to find the pairs of lines (one minus and
> >> one plus for each pair) which most match each other, and then do the
> >> word diff for each pair.
> >
> > Wouldn't be enough to treat run of plus/minus lines as a single block,
> > tokenize, do token-based (as opposed to line-based) diff, then show it
> > using linebreaks of the destination file (pluses line)?
> 
> I tried the "using linebreaks" but I discarded it because I did not think
> it would work.  If we rewrite the last three lines above with this single
> line:
> 
> > Wouldn't be enough to use magic?
> 
> and apply that algorithm between the two, then we would get a long single
> line that has words painted in red, two lines worth, followed by green "to
> use magic?"  and finally an end-of-line.

That's why i said with current implementation we can't get the
best output which i think should be

Wouldn't be enough to {-treat run of plus/minus lines as a single block,}{+use magic?}
{-tokenize, do token-based (as opposed to line-based) diff, then show it}
{-using linebreaks of the destination file (pluses line)?}
