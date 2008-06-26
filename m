From: Theodore Tso <tytso@mit.edu>
Subject: Re: policy and mechanism for less-connected clients
Date: Thu, 26 Jun 2008 01:23:10 -0400
Message-ID: <20080626052310.GC8610@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Jeske <jeske@willowmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 07:25:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBjyh-0007dQ-Hy
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 07:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbYFZFXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 01:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbYFZFXe
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 01:23:34 -0400
Received: from www.church-of-our-saviour.org ([69.25.196.31]:36900 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751467AbYFZFXe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 01:23:34 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KBjx1-0005bv-3P; Thu, 26 Jun 2008 01:23:19 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KBjws-0004CX-HB; Thu, 26 Jun 2008 01:23:10 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86393>

On Wed, Jun 25, 2008 at 11:03:02PM -0000, David Jeske wrote:
> I don't want to replicate CVS behavior, just the workflow.

It's not clear exactly what you want.  If you want the CVS workflow
(with all of its downsides), then just use "git pull; hack hack hack;
git push" all on the master branch.  If you are going to preserve the
workflow of CVS, then you're also going to preserve all of the
downsides of CVS.  If you aren't willing to make the users learn
anything new, then what's the point?

And if you are willing to make the users change their behaviour a
somewhat -- how much change are you willing to make them deviate from
the CVS workflow, and how much smarts are you willing to assume that
they have?

							- Ted
