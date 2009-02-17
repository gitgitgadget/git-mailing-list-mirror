From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Google has renamed the imap folder
Date: Tue, 17 Feb 2009 10:39:17 -0800
Message-ID: <7vprhg52ne.fsf@gitster.siamese.dyndns.org>
References: <200902171012.15755.johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 19:41:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZUsM-0001Ih-EA
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 19:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbZBQSjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 13:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbZBQSjY
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 13:39:24 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39030 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741AbZBQSjX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 13:39:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A8AC9A468;
	Tue, 17 Feb 2009 13:39:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E9B1F9A45F; Tue,
 17 Feb 2009 13:39:18 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4B17392E-FD22-11DD-98CB-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110436>

John Tapsell <johnflux@gmail.com> writes:

> Also add a comment that the web interface wraps the lines
>
> Signed-off-by: John Tapsell <johnflux@gmail.com>
> ---
>  Documentation/SubmittingPatches |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 9b559ad..aa41c9e 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -491,12 +491,18 @@ message, complete the addressing and subject fields, and press send.
>  Gmail
>  -----
>  
> +GMail does not appear to have any way to turn off line wrapping in the web
> +interface, so this will mangle any emails that you send.  You can however
> +use any IMAP email client to connect to the google imap server, and forward
> +the emails through that.  Just make sure to disable line wrapping in that
> +email client.
> +
>  Submitting properly formatted patches via Gmail is simple now that
>  IMAP support is available. First, edit your ~/.gitconfig to specify your
>  account settings:
>  
>  [imap]
> -	folder = "[Gmail]/Drafts"
> +	folder = "[Google Mail]/Drafts"
>  	host = imaps://imap.gmail.com
>  	user = user@gmail.com
>  	pass = p4ssw0rd
> @@ -513,3 +519,5 @@ command to send the patch emails to your Gmail Drafts folder.
>  
>  Go to your Gmail account, open the Drafts folder, find the patch email, fill
>  in the To: and CC: fields and send away!
> +If you get an error that the "Folder doesn't exist" try with folder = "[Gmail]/Drafts".
> +

Are there any Gmail insiders who can comment on this alleged change?  Is
it for everybody?  Is it only for new accounts?  If I ask google about
"gmail imap draft folder", I seem to be getting '[Gmail]/Drafts' version,
and not the '[Google Mail]/Drafts' version, e.g.

    http://mail.google.com/support/bin/answer.py?hl=en&answer=78892
    http://mail.google.com/support/bin/answer.py?hl=en&answer=82367

It is not that I think John is talking BS.  If there is a transition of
some sort, we may want to keep the more prevalent one in the main example,
while suggesting minority one as a ballback altenative.
