From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI revamp
Date: Thu, 30 Oct 2008 15:59:28 +0100
Organization: glandium.org
Message-ID: <20081030145928.GA21707@glandium.org>
References: <1225338485-11046-1-git-send-email-sam@vilain.net> <alpine.LFD.2.00.0810301024300.13034@xanadu.home> <20081030145253.GK14786@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Sam Vilain <sam@vilain.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 16:01:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvZ16-0007xW-7o
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 16:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735AbYJ3O7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 10:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbYJ3O7m
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 10:59:42 -0400
Received: from vuizook.err.no ([194.24.252.247]:58620 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753133AbYJ3O7l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 10:59:41 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=vaio.glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1KvYzi-0004Yh-DI; Thu, 30 Oct 2008 15:59:33 +0100
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1KvYzg-0005nk-Vq; Thu, 30 Oct 2008 15:59:28 +0100
Content-Disposition: inline
In-Reply-To: <20081030145253.GK14786@spearce.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99480>

On Thu, Oct 30, 2008 at 07:52:53AM -0700, Shawn O. Pearce <spearce@spearce.org> wrote:
> Nicolas Pitre <nico@cam.org> wrote:
> > On Wed, 29 Oct 2008, Sam Vilain wrote:
> > > From: Sam Vilain <samv@vilain.net>
> > > 
> > > For cross-command CLI changes to be effective, they need to be
> > > cohesively planned.  Add a planning document for this next set of
> > > changes.
> > > 
> > > Signed-off-by: Sam Vilain <sam@vilain.net>
> > [...]
> > 
> > > +  * 'git checkout branch' would, if there is a remote branch called
> > > +    'branch' on exactly one remote, do what
> > > +    'git checkout -b branch thatremote/branch' does now.  If it is
> > > +    ambiguous, it would be an error, forcing the explicit notation.
> > 
> > I can't do otherwise but disagree with this.  Currently, when a remote 
> > branch is checked out, the commit corresponding to that remote branch is 
> > put on a detached head which is IMHO completely sane and coherent. It 
> > even tells you how to create a local branch from there if that's what 
> > you wanted to do.  So if it is still too confusing at that point then 
> > more explanations are needed and not the removal of a perfectly fine 
> > feature. Please don't change that behavior.
> 
> +1 to Nico's NAK.
> 
> Although I was at the GitTogether I don't remember this change to
> checkout being discussed.  I must have been asleep reading email
> or something.  I am _NOT_ in favor of this change; I think the
> current behavior of "git checkout origin/master" is correct and as
> sane as we can make it.

Except he was talking about 'git checkout branch', not 'git checkout
origin/branch'. And I would be fine with 'git checkout branch' doing
what 'git checkout -b branch $remote/branch' does if $remote is unique
(i.e. there is no other 'branch' branch in any other remote) and the
'branch' branch doesn't already exist.

Mike
