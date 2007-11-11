From: Theodore Tso <tytso@mit.edu>
Subject: Re: Deprecate git-fetch-pack?
Date: Sun, 11 Nov 2007 17:21:17 -0500
Message-ID: <20071111222117.GA7392@thunk.org>
References: <Pine.LNX.4.64.0711101752490.29952@iabervon.org> <7v4pftip42.fsf@gitster.siamese.dyndns.org> <74415967-7F49-426C-8BF5-1A0210C337AB@develooper.com> <Pine.LNX.4.64.0711111103240.4362@racer.site> <7vd4ugcwkm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ask =?iso-8859-1?Q?Bj=F8rn?= Hansen <ask@develooper.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 23:21:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrLBj-00022e-ML
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 23:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923AbXKKWVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 17:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755235AbXKKWVk
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 17:21:40 -0500
Received: from thunk.org ([69.25.196.29]:44437 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754896AbXKKWVj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 17:21:39 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IrLLZ-0002CW-Ib; Sun, 11 Nov 2007 17:32:05 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1IrLB8-0001xo-7b; Sun, 11 Nov 2007 17:21:18 -0500
Content-Disposition: inline
In-Reply-To: <7vd4ugcwkm.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64526>

On Sun, Nov 11, 2007 at 01:16:09PM -0800, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > This should be a non-issue.  We really should start deprecating 
> > "git-<command>" in favour of "git <command>" for real.
> >
> > New users should not even be told that this is correct usage.
> >
> 
> If you can write "git-commit" and "git commit" interchangeably
> while you cannot say "git-cat-file" and are forced to say "git
> cat-file", I suspect that would lead to a great confusion and
> unhappy users.

One of the reasons why I use git-diff and git-commit and in particular
"git-rebase --interactive master" very often is that it allows my
shell's bang completion to work.  (i.e., "!git-rebase").  If we tell
people they can not use "git-rebase", and must instead use "git
rebase" instead, I would consider that pretty annoying/obnoxious.

					- Ted
