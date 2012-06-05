From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: Re: [PATCH] Documentation: have ls-files and ls-tree "see also" each
 other
Date: Tue, 5 Jun 2012 00:29:35 -0600
Message-ID: <20120605062935.GA4683@comcast.net>
References: <1338873037-4343-1-git-send-email-mmogilvi_git@miniinfo.net>
 <7vehpuqpob.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 08:29:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbnGw-0005EW-EW
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 08:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819Ab2FEG3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 02:29:38 -0400
Received: from qmta03.emeryville.ca.mail.comcast.net ([76.96.30.32]:39856 "EHLO
	qmta03.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753251Ab2FEG3h (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2012 02:29:37 -0400
Received: from omta01.emeryville.ca.mail.comcast.net ([76.96.30.11])
	by qmta03.emeryville.ca.mail.comcast.net with comcast
	id JWSY1j0030EPchoA3WVdng; Tue, 05 Jun 2012 06:29:37 +0000
Received: from mmogilvi.homeip.net ([75.71.16.168])
	by omta01.emeryville.ca.mail.comcast.net with comcast
	id JWVb1j00s3dZt5F8MWVcu0; Tue, 05 Jun 2012 06:29:36 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 841F21E9601A; Tue,  5 Jun 2012 00:29:35 -0600 (MDT)
Content-Disposition: inline
In-Reply-To: <7vehpuqpob.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199204>

On Mon, Jun 04, 2012 at 10:43:32PM -0700, Junio C Hamano wrote:
> Matthew Ogilvie <mmogilvi_git@miniinfo.net> writes:
> 
> > Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
> > ---
> >
> > I could have used these references when I was looking at git-ls-files
> > documentation and trying to figure out how to make it list files
> > from a specific commit like git-ls-tree.
> 
> I do not like this kind of patches in general.  Where will it end?
> 
> "I wanted to know how to list objects recorded in a commit, and I
> could have used a reference to git-ls-tree from git-commit, so here
> is a patch to make them refer to each other"?
> 
> That kind of overfiew is what the tutorial (for concepts like the
> index, tree objects, commit objects, etc.) and the list of commands
> in git(1).  Is there compelling reason other than "I didn't bother
> to look, and it is likely other people wouldn't" to apply patches
> like this?

Not really.  Certainly this is a low priority change.

But why do many of the man pages have "SEE ALSO"
sections?  Should we just get rid of such sections?  Does anyone
have any guidelines/rules for what makes sense to be in a
"SEE ALSO" section?

My personal impression is that git-ls-files (which lists files
in the working directory or index) and git-ls-tree (which lists files in
a commit or tree object) are so similar that they could almost be
merged into a single command.  Linking them together in the 
documentation seemed obvious, but maybe that's just me.
