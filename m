From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [PATCH v2 2/3] blame,cat-file: Demonstrate --textconv is wrongly running converter on symlinks
Date: Fri, 24 Sep 2010 22:20:41 +0400
Message-ID: <20100924182041.GA13943@landau.phys.spbu.ru>
References: <cover.1285013802.git.kirr@landau.phys.spbu.ru> <cover.1285013802.git.kirr@landau.phys.spbu.ru> <3c344d9b8f014ccb96dc37dc42668426fb5a3c30.1285013802.git.kirr@landau.phys.spbu.ru> <vpqvd6086fq.fsf@bauges.imag.fr> <20100921183959.GB4390@landau.phys.spbu.ru> <vpqzkvaetq4.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Cl?ment Poulain <clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Sep 24 20:20:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzCtG-0001xu-EI
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 20:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757394Ab0IXSUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 14:20:45 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:35535 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757385Ab0IXSUn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 14:20:43 -0400
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id 46E3BFF704; Fri, 24 Sep 2010 22:20:41 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <vpqzkvaetq4.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157029>

On Tue, Sep 21, 2010 at 10:18:11PM +0200, Matthieu Moy wrote:
> Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:
> 
> > I know about --- and that content after it and up to patch itself goes
> > to /dev/null. The text here was intended to stay in the commit message,
> > and ~~~~ served as a separator in that message (git commit hook merges
> > several blank lines into one, so one can't separate text parts with
> > several empty lines, that's why I used this separator).
> >
> > If it's ugly, let's omit it - I don't insist, but i don't understand why
> > 'NOTE:' looks odd?
> 
> That was especially about the combination of both, but I don't really
> care. Consider my remarks as food for thoughts, not real objections.

Ok

> > This note clearly says "git diff is not affected, that's why we don't
> > write new tests for it".
> 
> I disagree with the implication. Git diff is not affected because it
> was done right, but behaving correctly doesn't mean you don't need
> tests. Checking the behavior of diff with tests wouldn't harm (but
> that's not serious not to do it).

Yes, my implication was not correct, and I agree tests woudn't harm. But
as Jeff already wrote in another mail, he'll test-cover the diff case,
so I'll let myself to be lazy here (thanks Jeff!) :)

> >> Reviewed-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> >
> > Thanks :)
> >
> > Is it for this one patch, or does it apply to the whole series?
> 
> To the serie, yes.

Thanks. Will repost v3 soon. Hopefuly it will be ok to merge it then.

Kirill
