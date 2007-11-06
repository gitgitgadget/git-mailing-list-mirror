From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in
	git, help users out.
Date: Tue, 6 Nov 2007 21:13:24 +0100
Organization: glandium.org
Message-ID: <20071106201324.GA30262@glandium.org>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org> <7vode8j7o5.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711061230540.4362@racer.site> <200711062106.57083.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 21:16:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpUqY-0001UK-H9
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 21:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756004AbXKFUQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 15:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755987AbXKFUP7
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 15:15:59 -0500
Received: from vawad.err.no ([85.19.200.177]:49557 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755984AbXKFUP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 15:15:59 -0500
Received: from aputeaux-153-1-78-131.w81-249.abo.wanadoo.fr ([81.249.108.131] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IpUpf-0000eS-BC; Tue, 06 Nov 2007 21:15:33 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IpUnc-0007uQ-KJ; Tue, 06 Nov 2007 21:13:24 +0100
Content-Disposition: inline
In-Reply-To: <200711062106.57083.robin.rosenberg.lists@dewire.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63714>

On Tue, Nov 06, 2007 at 09:06:56PM +0100, Robin Rosenberg wrote:
> tisdag 06 november 2007 skrev Johannes Schindelin:
> > Hi,
> > 
> > On Mon, 5 Nov 2007, Junio C Hamano wrote:
> > 
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > > 
> > > > On Mon, 5 Nov 2007, Junio C Hamano wrote:
> > > >
> > > >> Allowing people to revert or cherry pick partially by using paths 
> > > >> limiter is a very good idea; the whole "it comes from a commit so we 
> > > >> also commit" feels an utter nonsense, though.
> > > >
> > > > No.
> > > >
> > > > When "git revert <commit>" commits the result, "git revert <commit> -- 
> > > > <file>" should, too.
> > > 
> > > I was not questioning about that part.  "If 'git revert <some
> > > other form> foo' does not talk about commit, it should not
> > > commit" was what I was referring to.
> > 
> > Well, I think that _if_ we allow "git revert <path>" to mean "revert the 
> > changes to <path>, relative to the index" (which would be the same as "git 
> > checkout <path>"), then committing that change just does not make sense.
> > 
> > And it is this behaviour that people are seeking, not "git revert <commit> 
> > <path>".
> 
> I'm not convince making every command perform enitrely all kinds of actions 
> just because other SCMs interpret a name differently. git revert today 
> creates a *new* commit. Keep it simple. I think its ok that it mentions 
> another comnand when it detects arguments that does not make sense. There is 
> no right or wrong with interepreting reset either way, but not both ways 
> please. The confusion with checkout and reset is enough.

Maybe the documentation could emphasise on how to undo things when the
user makes mistakes.
Sometimes, saving your repo can be as simple as git reset --hard HEAD@{1}.
This is not, unfortunately, a works-for-all-cases command.

Mike
