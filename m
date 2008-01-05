From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-reflog.c: typo ref --> argv[i], could cause segfault
Date: Fri, 04 Jan 2008 17:22:02 -0800
Message-ID: <7vzlvlf4n9.fsf@gitster.siamese.dyndns.org>
References: <477ED949.1030909@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Jan 05 02:22:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAxkE-0001rP-Ds
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 02:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081AbYAEBWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 20:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753828AbYAEBWK
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 20:22:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53831 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630AbYAEBWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 20:22:09 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 92CFD5044;
	Fri,  4 Jan 2008 20:22:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AC145043;
	Fri,  4 Jan 2008 20:22:03 -0500 (EST)
In-Reply-To: <477ED949.1030909@nrlssc.navy.mil> (Brandon Casey's message of
	"Fri, 04 Jan 2008 19:11:37 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69626>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
>  builtin-reflog.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-reflog.c b/builtin-reflog.c
> index f422693..5e54989 100644
> --- a/builtin-reflog.c
> +++ b/builtin-reflog.c
> @@ -394,7 +394,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
>  		int recno;
>  
>  		if (!spec) {
> -			status |= error("Not a reflog: %s", ref);
> +			status |= error("Not a reflog: %s", argv[i]);
>  			continue;
>  		}

Bad Brandon!  Looking at 'next' while everybody is asked to work
on finding and fixing bugs on 'master' while -rc freeze.

Just kidding.  Thanks, the code is obviously correct, and will
queue.

I am not so surprised to see bugs in relatively new code that is
only in 'next', especially this one that no Porcelains already
use.
