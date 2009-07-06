From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] List send-email config options in config.txt.
Date: Sun, 05 Jul 2009 23:58:01 -0700
Message-ID: <7v3a9ae1s6.fsf@alter.siamese.dyndns.org>
References: <cover.1246834883.git.ydirson@altern.org>
	<112440b74f47290e55209b23d1bfc66ed2423297.1246834884.git.ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon Jul 06 08:58:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNi9U-0004pp-Jz
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 08:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbZGFG6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 02:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752709AbZGFG57
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 02:57:59 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:48177 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbZGFG57 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 02:57:59 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090706065802.WKZR25927.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 6 Jul 2009 02:58:02 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id CWy11c0074aMwMQ03Wy1iy; Mon, 06 Jul 2009 02:58:01 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=Qz1tpyKqTZYA:10 a=hpJ7GBawAAAA:8
 a=lBvqdsPOKSSOh3J8orkA:9 a=Q6G-gfpjoXDm7DVpkaDc8HBiHbkA:4 a=JjKPPc8r7fgA:10
X-CM-Score: 0.00
In-Reply-To: <112440b74f47290e55209b23d1bfc66ed2423297.1246834884.git.ydirson@altern.org> (Yann Dirson's message of "Mon\,  6 Jul 2009 01\:05\:28 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122774>

Yann Dirson <ydirson@altern.org> writes:

> Signed-off-by: Yann Dirson <ydirson@altern.org>
> ---
>  Documentation/config.txt |   40 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 40 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 2fecbe3..55fa938 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1379,6 +1379,46 @@ rerere.enabled::
>  	default enabled if you create `rr-cache` directory under
>  	`$GIT_DIR`, but can be disabled by setting this option to false.
>  
> +sendemail.aliasesfile::
> +	To avoid typing long email addresses, point this to one or more
> +	email aliases files.  You must also supply 'sendemail.aliasfiletype'.
> +
> +sendemail.aliasfiletype::
> +	Format of the file(s) specified in sendemail.aliasesfile. Must be
> +	one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus'.
> +
> +sendemail.bcc::
> +sendemail.cc::
> +sendemail.cccmd::
> +sendemail.chainreplyto::
> +

At least, we would want to have some description for these.  Something
along the lines of "Specifies values used for the corresponding command
line options when they are not given." should suffice.

> +sendemail.confirm::
> +	Sets the default for whether to confirm before sending. Must be
> +	one of 'always', 'never', 'cc', 'compose', or 'auto'. See '--confirm'
> +	in the previous section for the meaning of these values.
> +
> +sendemail.multiedit::
> +	If true (default), a single editor instance will be spawned to edit
> +	files you have to edit (patches when '--annotate' is used, and the
> +	summary when '--compose' is used). If false, files will be edited one
> +	after the other, spawning a new editor each time.
> +
> +sendemail.envelopesender::
> +sendemail.from::
> +sendemail.identity::
> +sendemail.<identity>.*::
> +sendemail.signedoffbycc::
> +sendemail.smtpencryption::
> +sendemail.smtppass::
> +sendemail.suppresscc::
> +sendemail.suppressfrom::
> +sendemail.to::
> +sendemail.smtpserver::
> +sendemail.smtpserverport::
> +sendemail.smtpuser::
> +sendemail.thread::
> +sendemail.validate::
> +

Likewise.

>  showbranch.default::
>  	The default set of branches for linkgit:git-show-branch[1].
>  	See linkgit:git-show-branch[1].
> -- 
> 1.6.3.3
