From: Mike Hommey <mh@glandium.org>
Subject: Re: Proposed git mv behavioral change
Date: Sat, 20 Oct 2007 09:46:54 +0200
Organization: glandium.org
Message-ID: <20071020074654.GA3497@glandium.org>
References: <c594999b2337.2337c594999b@nyroc.rr.com> <20071019015419.GV14735@spearce.org> <1192859758.13347.148.camel@g4mdd.entnet> <20071020063014.GU14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ari Entlich <lmage11@twcny.rr.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 20 09:48:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij94O-0004pv-On
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 09:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbXJTHsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 03:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbXJTHsQ
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 03:48:16 -0400
Received: from vawad.err.no ([85.19.200.177]:58969 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752299AbXJTHsP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 03:48:15 -0400
Received: from aputeaux-153-1-53-209.w82-124.abo.wanadoo.fr ([82.124.139.209] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1Ij942-0005a8-Tf; Sat, 20 Oct 2007 09:48:07 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1Ij92s-0000um-HX; Sat, 20 Oct 2007 09:46:54 +0200
Content-Disposition: inline
In-Reply-To: <20071020063014.GU14735@spearce.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.3): Status=No hits=0.3 required=5.0 tests=MAILTO_TO_SPAM_ADDR version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61808>

On Sat, Oct 20, 2007 at 02:30:14AM -0400, Shawn O. Pearce wrote:
> Ari Entlich <lmage11@twcny.rr.com> wrote:
> > On Thu, 2007-10-18 at 21:54 -0400, Shawn O. Pearce wrote:
> > > --index is used in Git for places were we update *both* the index
> > > and the working directory (git-apply --index). So actually I should
> > > have suggested "git-mv --index".  Whoops.
> > 
> > Alright then, I don't know about that particular convention. If this
> > behavior can't be made default, git mv --index should activate it? I
> > there anything else that might be more descriptive?
> 
> That's always the hard part.  I actually think the current behavior
> should be called --index as it does not only the working tree
> update but also stages the whole file into the index, which is what
> git-apply --index does.
> 
> What about just -u for "keep unstaged"?

Why not --staged ? It would be more meaningful than the --cached in some
other commands.

Mike
