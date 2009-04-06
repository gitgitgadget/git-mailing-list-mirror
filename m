From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 07/14] difftool: add a -y shortcut for --no-prompt
Date: Tue, 7 Apr 2009 00:17:25 +0200
Message-ID: <200904070017.25501.markus.heidelberg@web.de>
References: <1239006689-14695-1-git-send-email-davvid@gmail.com> <1239006689-14695-7-git-send-email-davvid@gmail.com> <1239006689-14695-8-git-send-email-davvid@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, charles@hashpling.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 00:19:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqxA5-0004NU-Jn
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 00:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759424AbZDFWRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 18:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759887AbZDFWRQ
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 18:17:16 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:58015 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759820AbZDFWRP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 18:17:15 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 19BDCFF7DF5D;
	Tue,  7 Apr 2009 00:17:13 +0200 (CEST)
Received: from [89.59.82.208] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1Lqx7w-0005M1-00; Tue, 07 Apr 2009 00:17:13 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1239006689-14695-8-git-send-email-davvid@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19gKL9YbQAJJyvC40aSlY4hU8Z48JJmOushVAGn
	PVIGKxZ6mhFzxOY7VHpq2KYkXnB2GSjLtJ+S7bQSY+FaoaQo0E
	lkjv1Ow4KkQ9huXPEDPg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115888>

David Aguilar, 06.04.2009:
> diff --git a/contrib/difftool/git-difftool.txt b/contrib/difftool/git-difftool.txt
> index 2b7bc03..4dff529 100644
> --- a/contrib/difftool/git-difftool.txt
> +++ b/contrib/difftool/git-difftool.txt
> @@ -3,35 +3,32 @@ git-difftool(1)
>  
>  NAME
>  ----
> -git-difftool - compare changes using common merge tools
> +git-difftool - Show changes using common diff tools
>  
>  SYNOPSIS
>  --------
> -'git difftool' [--tool=<tool>] [--no-prompt] ['git diff' options]
> +'git difftool' [-t|--tool=<tool>] [-y|--no-prompt] [<'git diff' options>]

"-t <tool>" would be more correct than only "-t". But I'm not sure if it
should go in there, mergetool doesn't have it either. It's only the
synopsis, is there any "official" guideline on how much to include
there and whether to avoid different options with the same meaning?
