From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] Adds a #!bash to the top of bash completions so
	that editors can recognize, it as a bash script. Also adds a few
	simple comments above commands that, take arguments. The comments
	are meant to remind editors of potential, problems that can occur
	when the script is sourced on systems with "set, -u."
Date: Tue, 13 Jan 2009 08:45:18 -0800
Message-ID: <20090113164518.GS10179@spearce.org>
References: <496CBD17.3000207@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 17:47:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMmPf-0004XS-HT
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 17:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbZAMQpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 11:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753092AbZAMQpU
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 11:45:20 -0500
Received: from george.spearce.org ([209.20.77.23]:45889 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053AbZAMQpT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 11:45:19 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id AC0E538210; Tue, 13 Jan 2009 16:45:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <496CBD17.3000207@tedpavlic.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105511>

Ted Pavlic <ted@tedpavlic.com> wrote:
>
> Third in a series of patches that make bash completions more robust to
> different interactive shell configurations and editors.
>
> [PATCH 3/3] Adds a #!bash to the top of bash completions so that editors  
> can recognize
>  it as a bash script. Also adds a few simple comments above commands that
>  take arguments. The comments are meant to remind editors of potential
>  problems that can occur when the script is sourced on systems with "set
>  -u."

Aside from the message format... OK.  The message really should
have looked like this from an mbox point of view:

	From: Ted Pavlic <ted@tedpavlic.com>
	To: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
	Cc: "Shawn O. Pearce" <spearce@spearce.org>
	Bcc: 
	Subject: [PATCH 3/3] bash-completion: Add internal function documentation

	Slightly document the internal functions of the bash
	completion package, so callers are more easily able to
	determine the expected arguments.

	Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
	---

	 Third in a series to improve the bash completion package,
	 so it sucks less.

	 contrib/completion/git-completion.bash |   15 +++++++++++++++
	 1 files changed, 15 insertions(+), 0 deletions(-)

	diff --git a/contrib/completion/git-completion.bash  

See how the stuff that doesn't matter to the commit message itself
goes after the "---" line?  And how the subject is a niceshort, one
line summary of the module impacted and the change?  These show up in
gitk and git shortlog, and thus in the "What's changed in git.git"
newsletters Junio publishes.  Its important that the subject be
really short and sweet.  You can put more detail above the "---"
line, and it will be included in the commit when Junio applies it.

This is all based on the formatting at the time of commit.
Anything up to the first "\n\n" in a commit message goes into the
email subject line.  The rest goes into the email body, but above the
"---" line.  You can then edit the buffer before sending to insert
non-commit message text after the "---" and before the diff stat.

You can include my Ack'd by line below your Signed-off-by when you
resend it.

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> ---
>  contrib/completion/git-completion.bash |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)

-- 
Shawn.
