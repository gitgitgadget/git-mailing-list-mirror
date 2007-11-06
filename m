From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in git, help users out.
Date: Tue, 6 Nov 2007 10:29:42 +0100
Organization: glandium.org
Message-ID: <20071106092942.GB3197@glandium.org>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org> <CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com> <7vlk9cmiyq.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711052325090.4362@racer.site> <7vsl3kjdct.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711060317220.4362@racer.site> <7vode8j7o5.fsf@gitster.siamese.dyndns.org> <20071106084925.GC4435@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 10:32:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpKn4-0001wB-2d
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 10:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbXKFJb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 04:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753383AbXKFJb4
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 04:31:56 -0500
Received: from vawad.err.no ([85.19.200.177]:35623 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752585AbXKFJbz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 04:31:55 -0500
Received: from aputeaux-153-1-9-88.w82-124.abo.wanadoo.fr ([82.124.55.88] helo=vaio.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IpKmV-0003IE-Nm; Tue, 06 Nov 2007 10:31:38 +0100
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1IpKkg-0000rg-Kr; Tue, 06 Nov 2007 10:29:42 +0100
Content-Disposition: inline
In-Reply-To: <20071106084925.GC4435@artemis.corp>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 5.0): Status=No hits=4.9 required=5.0 tests=RCVD_IN_DSBL,RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63651>

On Tue, Nov 06, 2007 at 09:49:25AM +0100, Pierre Habouzit <madcoder@debian.org> wrote:
> On Tue, Nov 06, 2007 at 04:54:02AM +0000, Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > On Mon, 5 Nov 2007, Junio C Hamano wrote:
> > >
> > >> Allowing people to revert or cherry pick partially by using paths 
> > >> limiter is a very good idea; the whole "it comes from a commit so we 
> > >> also commit" feels an utter nonsense, though.
> > >
> > > No.
> > >
> > > When "git revert <commit>" commits the result, "git revert <commit> -- 
> > > <file>" should, too.
> > 
> > I was not questioning about that part.  "If 'git revert <some
> > other form> foo' does not talk about commit, it should not
> > commit" was what I was referring to.
> 
>   Well, I don't really know how closely you read #git, but I'd say that
> "how do I undo my local changes in a git repository" is among the top 3
> questions. There _IS_ an UI issue for that.
> 
> If git revert <commitish> -- path1 path2 path3 is going to work at some
> point, I see no harm in saying that git revert HEAD -- path1 path2 path3
> work. We can also in that case spit an error message:

It seems to me git revert HEAD -- path1 path2 path3 should revert the changes
made in the commit pointed to by HEAD, not revert the changes in the working
tree or the index...

Mike
