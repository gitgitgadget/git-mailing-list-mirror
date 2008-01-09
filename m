From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] additional help when editing during interactive rebase
Date: Tue, 08 Jan 2008 18:55:27 -0800
Message-ID: <7vsl17pv1c.fsf@gitster.siamese.dyndns.org>
References: <1199845915-sup-797@south>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, William Morgan <wmorgan-git@masanjin.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 09 03:56:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCR6z-00086S-8U
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 03:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbYAICzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 21:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751622AbYAICzp
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 21:55:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36536 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbYAICzp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 21:55:45 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DAA131A7;
	Tue,  8 Jan 2008 21:55:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CFE9931A6;
	Tue,  8 Jan 2008 21:55:38 -0500 (EST)
In-Reply-To: <1199845915-sup-797@south> (William Morgan's message of "Tue, 08
	Jan 2008 18:32:17 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69945>

William Morgan <wmorgan-git@masanjin.net> writes:

> I personally would have found this message useful the first time I used
> git rebase --interactive. YMMV.

Aside from this message being inappropriate as a proposed commit
log message, I think what the patch tries to achieve is a worthy
UI improvement.

I would have removed those empty lines around the instruction if
I were patching this, though.  Losing 5 lines out of 25-line
terminal was marginally Ok.  Losing 9 lines 4 lines too many and
is unacceptable.

Thoughts?

> Signed-off-by: William Morgan <wmorgan-git@masanjin.net>
> ---
>  git-rebase--interactive.sh |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index acdcc54..d53d283 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -263,6 +263,10 @@ do_next () {
>  		warn
>  		warn "	git commit --amend"
>  		warn
> +		warn "Once amended, continue with"
> +		warn
> +		warn "	git rebase --continue"
> +		warn
>  		exit 0
>  		;;
>  	squash|s)
> -- 
> 1.5.4.rc2.68.ge708a-dirty
>
>
> -- 
> William <wmorgan-git@masanjin.net>
