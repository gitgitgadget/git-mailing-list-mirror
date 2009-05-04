From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/3] git-am.txt: add an 'a', say what 'it' is, simplify
 a sentence
Date: Mon, 04 May 2009 13:43:25 +0200
Message-ID: <49FED4DD.3090103@drmicha.warpmail.net>
References: <1241419618-20304-1-git-send-email-bebarino@gmail.com> <1241419618-20304-2-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 13:43:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0waF-0004RD-Tk
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 13:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbZEDLnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 07:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808AbZEDLnf
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 07:43:35 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43023 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752153AbZEDLne (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 May 2009 07:43:34 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 11F9D338340;
	Mon,  4 May 2009 07:43:34 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 04 May 2009 07:43:34 -0400
X-Sasl-enc: Cpj1OXNrd6PZlSIsf350KF7wvw1Fgt7u070J955NyIva 1241437413
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 41D80474CC;
	Mon,  4 May 2009 07:43:33 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090504 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <1241419618-20304-2-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118226>

Stephen Boyd venit, vidit, dixit 04.05.2009 08:46:
> It's nice to know that 'it' is git-am or the subject line. Whitespace
> implies characters so just remove characters.
> 
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
>  Documentation/git-am.txt |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 1e71dd5..715531b 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -32,7 +32,7 @@ OPTIONS
>  
>  -s::
>  --signoff::
> -	Add `Signed-off-by:` line to the commit message, using
> +	Add a `Signed-off-by:` line to the commit message, using
>  	the committer identity of yourself.
>  
>  -k::
> @@ -118,8 +118,8 @@ The commit author name is taken from the "From: " line of the
>  message, and commit author time is taken from the "Date: " line
>  of the message.  The "Subject: " line is used as the title of
>  the commit, after stripping common prefix "[PATCH <anything>]".
> -It is supposed to describe what the commit is about concisely as
> -a one line text.
> +The "Subject: " line is supposed to concisely describe what the
> +commit is about in one line of text.
>  
>  The body of the message (the rest of the message after the blank line
>  that terminates the RFC2822 headers) can begin with "Subject: " and
> @@ -128,8 +128,8 @@ to override the values of these fields.
>  
>  The commit message is formed by the title taken from the
>  "Subject: ", a blank line and the body of the message up to
> -where the patch begins.  Excess whitespace characters at the end of the
> -lines are automatically stripped.
> +where the patch begins.  Excess whitespace at the end of each
> +line is automatically stripped.
>  
>  The patch is expected to be inline, directly following the
>  message.  Any line that is of the form:
> @@ -141,7 +141,7 @@ message.  Any line that is of the form:
>  is taken as the beginning of a patch, and the commit log message
>  is terminated before the first occurrence of such a line.
>  
> -When initially invoking it, you give it the names of the mailboxes
> +When initially invoking 'git-am', you give it the names of the mailboxes

We try to spell git commands in the form 'git am' these days. Also, `git
am` should be the quoting for commands, although we don't have a style
guide and things are not consistent anyways.

>  to process.  Upon seeing the first patch that does not apply, it
>  aborts in the middle.  You can recover from this in one of two ways:
>  
