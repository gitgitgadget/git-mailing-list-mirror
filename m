From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-archive.txt: Note attributes
Date: Tue, 03 Mar 2009 10:27:08 -0800
Message-ID: <7vab82bgxv.fsf@gitster.siamese.dyndns.org>
References: <1236099168-20231-1-git-send-email-roylee@andestech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Roy Lee <roylee17@gmail.com>
To: roylee@andestech.com
X-From: git-owner@vger.kernel.org Tue Mar 03 19:29:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeZMb-0006FN-S9
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 19:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbZCCS1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 13:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753209AbZCCS1S
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 13:27:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731AbZCCS1S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 13:27:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EE73E9E577;
	Tue,  3 Mar 2009 13:27:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7FB5D9E569; Tue,
  3 Mar 2009 13:27:10 -0500 (EST)
In-Reply-To: <1236099168-20231-1-git-send-email-roylee@andestech.com>
 (roylee@andestech.com's message of "Wed, 4 Mar 2009 00:52:48 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EB6E2028-0820-11DE-9AF3-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112143>

roylee@andestech.com writes:

> From: Roy Lee <roylee17@gmail.com>
>
> ---

Please add a sign-off.  What the patch text says looks perfect, even
though the lines are too long and would better be rewrapped and the lines
under ATTRIBUTES must match the length of the word it underlines (this is
text marked-up with asciidoc, not just freeform).

Thanks.

>  Documentation/git-archive.txt |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
> index 41cbf9c..96f5424 100644
> --- a/Documentation/git-archive.txt
> +++ b/Documentation/git-archive.txt
> @@ -88,6 +88,17 @@ tar.umask::
>  	archiving user's umask will be used instead.  See umask(2) for
>  	details.
>  
> +ATTRIBUTES
> +----------------
> +
> +export-ignore::
> +	Files and directories with the attribute export-ignore won't be added to archive files.
> +	See linkgit:gitattributes[5] for details.
> +
> +export-subst::
> +	If the attribute export-subst is set for a file then git will expand several placeholders when adding this file
> +	to an archive.  See linkgit:gitattributes[5] for details.
> +
>  EXAMPLES
>  --------
>  git archive --format=tar --prefix=junk/ HEAD | (cd /var/tmp/ && tar xf -)::
> @@ -110,6 +121,11 @@ git archive --format=zip --prefix=git-docs/ HEAD:Documentation/ > git-1.4.0-docs
>  	Put everything in the current head's Documentation/ directory
>  	into 'git-1.4.0-docs.zip', with the prefix 'git-docs/'.
>  
> +
> +SEE ALSO
> +--------
> +linkgit:gitattributes[5]
> +
>  Author
>  ------
>  Written by Franck Bui-Huu and Rene Scharfe.
> -- 
> 1.6.1.3
