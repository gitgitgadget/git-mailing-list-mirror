From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] show git tag output in pager
Date: Tue, 27 Sep 2011 16:19:39 +0200
Message-ID: <vpqehz2cbk4.fsf@bauges.imag.fr>
References: <20110927134235.GA27478@zelva.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michal Vyskocil <mvyskocil@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 27 16:20:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8YWP-00028S-Vr
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 16:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291Ab1I0OU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 10:20:29 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36129 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752742Ab1I0OU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 10:20:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p8REHUcd002357
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 27 Sep 2011 16:17:30 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1R8YVX-0004T4-Hx; Tue, 27 Sep 2011 16:19:39 +0200
In-Reply-To: <20110927134235.GA27478@zelva.suse.cz> (Michal Vyskocil's message
	of "Tue, 27 Sep 2011 15:42:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 27 Sep 2011 16:17:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p8REHUcd002357
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1317737852.14623@VNOOgngZ5/yHHjPlUGA18Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182239>

The commit message should explain why this is needed, and in particular
why you prefer this to setting pager.tag in your ~/.gitconfig.

Michal Vyskocil <mvyskocil@suse.cz> writes:

> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -147,6 +147,8 @@ static int list_tags(const char **patterns, int lines,
>  			struct commit_list *with_commit)
>  {
>  	struct tag_filter filter;
> +        
> +        setup_pager();

Git indents with tabs, not spaces, and does not leave trailing
whitespaces.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
