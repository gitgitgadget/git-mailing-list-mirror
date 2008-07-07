From: Mike Hommey <mh@glandium.org>
Subject: Re: [FIXED PATCH] Make rebase save ORIG_HEAD if changing current
	branch
Date: Mon, 7 Jul 2008 07:48:16 +0200
Organization: glandium.org
Message-ID: <20080707054816.GA11153@glandium.org>
References: <1215379370-34265-1-git-send-email-benji@silverinsanity.com> <7v7iby9ucx.fsf@gitster.siamese.dyndns.org> <20080707054105.GB9737@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 07:49:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFjbD-0000sX-Gc
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 07:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbYGGFsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 01:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbYGGFsW
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 01:48:22 -0400
Received: from vuizook.err.no ([194.24.252.247]:33352 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220AbYGGFsW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 01:48:22 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KFja9-0002iF-Mf; Mon, 07 Jul 2008 07:48:19 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KFjaC-0002ww-4v; Mon, 07 Jul 2008 07:48:16 +0200
Content-Disposition: inline
In-Reply-To: <20080707054105.GB9737@glandium.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87581>

On Mon, Jul 07, 2008 at 07:41:05AM +0200, Mike Hommey wrote:
> On Sun, Jul 06, 2008 at 09:43:58PM -0700, Junio C Hamano wrote:
> > Brian Gernhardt <benji@silverinsanity.com> writes:
> > 
> > > This makes rebase act a little more like merge when working on the
> > > current branch.  This is particularly useful for `git pull --rebase`
> > >
> > > Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
> > > ---
> > >
> > >  ARG!  This is what v3 was supposed to be.  I should make sure I am sending in
> > >  the correct patch.
> > 
> > Yeah, I was scratching my head about the discrepancy between the revision
> > comment and the patch in the previous one.
> > 
> > Having said that, thanks to updates to git-rebase, rebased_branch@{1} has
> > useful information these days, so I do not see much practical upside, even
> > though I _will_ apply this patch, just for the sake of consistency.
> > 
> > We would make it _appear_ rebase and merge are interchangeable even more.
> > But the thing is, I am not convinced if promoting that appearance is
> > necessarily a good thing.
> > 
> > You now do not have to say something like:
> > 
> > 	After a 'git pull' you can view 'git diff ORIG_HEAD..' to check
> > 	what are new, but 'git pull --rebase' is different and you would
> > 	say 'git diff branch@{1}.." instead.
> > 
> > and you can tell the users that ORIG_HEAD can be used in both cases.
> 
> And in both cases, you could use HEAD@{1} instead of ORIG_HEAD.

Forget it, I just woke up, I'm writing crap.

Mike
