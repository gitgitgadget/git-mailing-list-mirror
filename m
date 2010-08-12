From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] push: mention "git pull" in error message for non-fast forwards
Date: Thu, 12 Aug 2010 12:03:29 +0200
Message-ID: <vpqvd7gp2q6.fsf@bauges.imag.fr>
References: <1280756564-3932-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 12 12:03:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjUda-0007ei-8r
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 12:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759628Ab0HLKDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 06:03:43 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51993 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752676Ab0HLKDm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 06:03:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o7C9qZvl009451
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 12 Aug 2010 11:52:35 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OjUdF-0006YV-MH; Thu, 12 Aug 2010 12:03:29 +0200
In-Reply-To: <1280756564-3932-1-git-send-email-Matthieu.Moy@imag.fr> (Matthieu Moy's message of "Mon\,  2 Aug 2010 15\:42\:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 12 Aug 2010 11:52:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7C9qZvl009451
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1282211558.54087@rTR6+STsa6uU715jh/WlGA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153359>

Hi,

I'm sorry to insist, but nothing has happened to this patch, and I'd
really like it to get merged. The only reaction appart from Junio was
Jonathan, and althought it contained a disgression about "if I were
running the world", it started with "Your change is good." ;-).

Thanks,

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The message remains fuzzy to include "git pull", "git pull --rebase" and
> others, but directs the user to the simplest solution in the vast
> majority of cases.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> When the message was added, it was decided explicitely not to say
> explicitely "use git pull", first because there are other ways to
> merge, and then to encourage the users to read the docs.
>
> After a few months of teaching newbies/students to use Git, the
> question "it doesn't want to push, what shall I do" still comes in the
> top questions asked. Each time I've been asked, the newbie's face was
> enlightened by hearing just the word "pull".
>
> So I guess those few extra characters in the error message would save
> me a lot of time ;-).
>
>  builtin/push.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index f4358b9..69bc2f2 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -130,8 +130,8 @@ static int push_with_options(struct transport *transport, int flags)
>  
>  	if (nonfastforward && advice_push_nonfastforward) {
>  		fprintf(stderr, "To prevent you from losing history, non-fast-forward updates were rejected\n"
> -				"Merge the remote changes before pushing again.  See the 'Note about\n"
> -				"fast-forwards' section of 'git push --help' for details.\n");
> +				"Merge the remote changes (e.g. 'git pull') before pushing again.  See the\n"
> +				"'Note about fast-forwards' section of 'git push --help' for details.\n");
>  	}
>  
>  	return 1;

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
