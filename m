From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in
 git, help users out.
Date: Tue, 6 Nov 2007 12:32:24 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711061230540.4362@racer.site>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org>
 <CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com>
 <7vlk9cmiyq.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711052325090.4362@racer.site>
 <7vsl3kjdct.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711060317220.4362@racer.site>
 <7vode8j7o5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Grimm <koreth@midwinter.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 13:33:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpNcd-0008Qo-D0
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 13:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416AbXKFMdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 07:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755028AbXKFMdU
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 07:33:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:54333 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751019AbXKFMdT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 07:33:19 -0500
Received: (qmail invoked by alias); 06 Nov 2007 12:33:17 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 06 Nov 2007 13:33:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19da8BZEOhda6NuV8ToC8H4wvqfxf7FMPov0lMYkl
	9v6NM/LBjCFfhT
X-X-Sender: gene099@racer.site
In-Reply-To: <7vode8j7o5.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63669>

Hi,

On Mon, 5 Nov 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 5 Nov 2007, Junio C Hamano wrote:
> >
> >> Allowing people to revert or cherry pick partially by using paths 
> >> limiter is a very good idea; the whole "it comes from a commit so we 
> >> also commit" feels an utter nonsense, though.
> >
> > No.
> >
> > When "git revert <commit>" commits the result, "git revert <commit> -- 
> > <file>" should, too.
> 
> I was not questioning about that part.  "If 'git revert <some
> other form> foo' does not talk about commit, it should not
> commit" was what I was referring to.

Well, I think that _if_ we allow "git revert <path>" to mean "revert the 
changes to <path>, relative to the index" (which would be the same as "git 
checkout <path>"), then committing that change just does not make sense.

And it is this behaviour that people are seeking, not "git revert <commit> 
<path>".

Ciao,
Dscho
