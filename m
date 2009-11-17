From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: Re: [PATCH] Doc: mention the crlf attribute in config autocrlf section
Date: Mon, 16 Nov 2009 20:59:45 -0700
Message-ID: <20091117035945.GA1728@comcast.net>
References: <1258223700-4009-1-git-send-email-mmogilvi_git@miniinfo.net> <20091116195048.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 05:00:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAFEx-0008RB-6b
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 05:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568AbZKQEAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 23:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753367AbZKQEAI
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 23:00:08 -0500
Received: from qmta03.emeryville.ca.mail.comcast.net ([76.96.30.32]:40364 "EHLO
	QMTA03.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753172AbZKQEAI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Nov 2009 23:00:08 -0500
Received: from OMTA21.emeryville.ca.mail.comcast.net ([76.96.30.88])
	by QMTA03.emeryville.ca.mail.comcast.net with comcast
	id 63fl1d0061u4NiLA340DHZ; Tue, 17 Nov 2009 04:00:15 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA21.emeryville.ca.mail.comcast.net with comcast
	id 63zr1d0035FCJCg8h3zyWY; Tue, 17 Nov 2009 04:00:06 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 03B8089115; Mon, 16 Nov 2009 20:59:46 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <20091116195048.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.4i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133055>

On Mon, Nov 16, 2009 at 07:50:48PM +0900, Nanako Shiraishi wrote:
> Quoting Matthew Ogilvie <mmogilvi_git@miniinfo.net>
> 
> > The reverse reference has long existed, and the autocrlf description
> > was actually obsolete and wrong (saying only file content is used),
> > not just incomplete.
> 
> What do you mean by "reverse reference"?
> 

I'm refering to the fact that the "crlf" section of
Documentation/gitattributes.txt mentions core.autocrlf,
which is in the opposite (reverse) direction as this new reference
I'm adding.

The crlf section has a much more thorough description of
the various knobs and settings and how they interact.  But
I just checked, and although the gitattributes crlf section
describes core.autocrlf in reasonable detail, it does not have an
actual link (reference?) to git-config or the core.autocrlf
section.  So the commit message isn't as clear as it could be.

Do I need to resubmit the patch, in order to rephrase the commit
message?

--
Matthew Ogilvie   [mmogilvi_git@miniinfo.net]
