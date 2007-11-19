From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Doc fix for git-reflog: mention @{...} syntax, and <ref> in synopsys.
Date: Mon, 19 Nov 2007 12:13:46 -0800
Message-ID: <7vtznim1s5.fsf@gitster.siamese.dyndns.org>
References: <vpqtznirtlk.fsf@bauges.imag.fr>
	<1195497342-26334-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Nov 19 21:14:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuD0U-0006T5-Vd
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 21:14:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbXKSUNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 15:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbXKSUNx
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 15:13:53 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:33039 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbXKSUNx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 15:13:53 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B85A92F0;
	Mon, 19 Nov 2007 15:14:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C20BF97854;
	Mon, 19 Nov 2007 15:14:10 -0500 (EST)
In-Reply-To: <1195497342-26334-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Mon, 19 Nov 2007 19:35:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65494>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The HEAD@{...} syntax was documented in git-rev-parse manpage, which
> is hard to find by someone looking for the documentation of porcelain.
> git-reflog is probably the place where one expects to find this.
>
> While I'm there, "git revlog show whatever" was also undocumented.

Thanks.  The new HEAD@{N} description is concise and nice.

>  The subcommand "show" (which is also the default, in the absence of any
>  subcommands) will take all the normal log options, and show the log of
> -`HEAD`, which will cover all recent actions, including branch switches.
> +`HEAD`, or of the reference provided in the command-line, which will
> +cover all recent actions, including branch switches.
>  It is basically an alias for 'git log -g --abbrev-commit
>  --pretty=oneline', see gitlink:git-log[1].

But the wording added with "While I'm there" change seems wrong
to me.  "..., which will cover all recent actions" is about the
reflog attached to HEAD but the new phrase inserted in the
middle makes it unclear.
