From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Fix references to deprecated commands
Date: Mon, 12 Nov 2007 00:22:40 -0800
Message-ID: <7vbq9z50vj.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711072253580.4362@racer.site>
	<7vlk998u6r.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711080041120.4362@racer.site>
	<20071108145435.GA18727@diku.dk> <4733249B.9020504@op5.se>
	<20071108160114.GB20988@diku.dk>
	<7vzlxo1mga.fsf@gitster.siamese.dyndns.org>
	<20071109002001.GB5082@diku.dk>
	<7vy7d8xlej.fsf_-_@gitster.siamese.dyndns.org>
	<20071112002410.GA21970@diku.dk> <20071112003251.GB21970@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon Nov 12 09:23:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrUZV-0006OS-T1
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 09:23:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615AbXKLIWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 03:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754590AbXKLIWu
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 03:22:50 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:53996 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753812AbXKLIWt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 03:22:49 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id BD38B2F9;
	Mon, 12 Nov 2007 03:23:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 353CB94AE3;
	Mon, 12 Nov 2007 03:23:06 -0500 (EST)
In-Reply-To: <20071112003251.GB21970@diku.dk> (Jonas Fonseca's message of
	"Mon, 12 Nov 2007 01:32:51 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64573>

Jonas Fonseca <fonseca@diku.dk> writes:

> diff --git a/Documentation/git-get-tar-commit-id.txt b/Documentation/git-get-tar-commit-id.txt
> index 9b5f86f..ef1b19c 100644
> --- a/Documentation/git-get-tar-commit-id.txt
> +++ b/Documentation/git-get-tar-commit-id.txt
> @@ -14,12 +14,12 @@ SYNOPSIS
>  DESCRIPTION
>  -----------
>  Acts as a filter, extracting the commit ID stored in archives created by
> -git-tar-tree.  It reads only the first 1024 bytes of input, thus its
> +gitlink:git-archive[1].  It reads only the first 1024 bytes of input, thus its
>  runtime is not influenced by the size of <tarfile> very much.
>  
>  If no commit ID is found, git-get-tar-commit-id quietly exists with a
>  return code of 1.  This can happen if <tarfile> had not been created
> -using git-tar-tree or if the first parameter of git-tar-tree had been
> +using git-archive or if the <treeish> parameter of git-archive had been
>  a tree ID instead of a commit ID or tag.
>
> -- 
> Jonas Fonseca

How did you prepare this hunk?  I count 10 lines preimage and
postimage, followed by a blank line and the signature separator
"-- " you added in your MUA, but the header claims to have 12
lines.
