From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/3] Makes the bash completion script try *bash*
	completions before simple, filetype completions when a git
	completion is not found. If bash, completions aren't available, the
	default file completions are used. This, behavior was inspired by
	Mercurial's bash completion script.
Date: Tue, 13 Jan 2009 08:38:16 -0800
Message-ID: <20090113163816.GR10179@spearce.org>
References: <496CBCED.80402@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 17:39:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMmIn-0001Q2-0Y
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 17:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbZAMQiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 11:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753220AbZAMQiR
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 11:38:17 -0500
Received: from george.spearce.org ([209.20.77.23]:39473 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbZAMQiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 11:38:16 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2695938210; Tue, 13 Jan 2009 16:38:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <496CBCED.80402@tedpavlic.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105508>

Ted Pavlic <ted@tedpavlic.com> wrote:
>
> Second in a series of patches that make bash completions more robust to
> different interactive shell configurations and editors.
>
>
> [PATCH 2/3] Makes the bash completion script try *bash* completions  
> before simple
>  filetype completions when a git completion is not found. If bash
>  completions aren't available, the default file completions are used. This
>  behavior was inspired by Mercurial's bash completion script.

Again, I would have used this as my commit message:

	bash-completion: Try bash completions before file completions

	Try bash completions before any simple file completions
	whenever a git completion is not found.  This may help
	users to complete BLAH BLAH BLAH WHAT THE HECK IS THIS GOOD
	FOR ANYWAY.

	Behavior was inspired by Mercurial's bash completion script.

No ack, because I still don't understand why this is a good thing.
Yes, I could look it up online in the bash docs.  I shouldn't need
to go do research like that to understand the justification for
a change, it should be better explained in the message.

-- 
Shawn.
