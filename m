From: Mike Hommey <mh@glandium.org>
Subject: Re: git rebase --skip
Date: Thu, 8 Nov 2007 20:22:31 +0100
Organization: glandium.org
Message-ID: <20071108192231.GA22658@glandium.org>
References: <20071107222105.GA31666@glandium.org> <20071108032308.GA5638@sigill.intra.peff.net> <20071108102412.GA31187@atjola.homenet> <Pine.LNX.4.64.0711081332550.29952@iabervon.org> <20071108191601.GA22353@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-15?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 20:24:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqCzO-0008Me-Vh
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 20:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbXKHTYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 14:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758555AbXKHTYI
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 14:24:08 -0500
Received: from vawad.err.no ([85.19.200.177]:52588 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552AbXKHTYI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 14:24:08 -0500
Received: from aputeaux-153-1-36-161.w82-124.abo.wanadoo.fr ([82.124.128.161] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IqCyt-0006eO-8d; Thu, 08 Nov 2007 20:24:02 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IqCxT-0005vE-PL; Thu, 08 Nov 2007 20:22:31 +0100
Content-Disposition: inline
In-Reply-To: <20071108191601.GA22353@glandium.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64066>

On Thu, Nov 08, 2007 at 08:16:01PM +0100, Mike Hommey wrote:
> On Thu, Nov 08, 2007 at 01:43:05PM -0500, Daniel Barkalow wrote:
> > > git commit
> > > git rebase --skip
> > 
> > I guess that works, and nothing else presently does. But I don't think 
> > that's at all intuitive as the correct thing to do (plus it feels too easy 
> > to get into losing your commit message). Maybe we should have a "git 
> > rebase --amend", which does the obvious thing (acts like --continue, but 
> > lets you edit the message). It's not like you just did something totally 
> > different; the commit is still the replacement for D, it's just less the 
> > same.
> 
> Maybe some commands such as commit should fail or at least emit warning
> when used during a rebase ?

Or, in the present case, doing the same as what "edit" would do in a
git-rebase --interactive could be enough.

Mike
