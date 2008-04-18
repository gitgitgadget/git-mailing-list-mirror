From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH] Document option --only of git commit
Date: Fri, 18 Apr 2008 11:28:54 +0200
Message-ID: <9CE1A95F-941C-474F-9F18-1B01B73113B2@ai.rug.nl>
References: <1207827189-7509-1-git-send-email-johannes.sixt@telecom.at> <1207827189-7509-2-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Apr 19 02:40:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmmvT-0003ks-Qq
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 11:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbYDRJ31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2008 05:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756044AbYDRJ3R
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 05:29:17 -0400
Received: from smtp-4.orange.nl ([193.252.22.249]:22079 "EHLO smtp-4.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754450AbYDRJ3J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2008 05:29:09 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6312.orange.nl (SMTP Server) with ESMTP id DC42E1C000A1;
	Fri, 18 Apr 2008 11:29:03 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6312.orange.nl (SMTP Server) with ESMTP id 806251C00098;
	Fri, 18 Apr 2008 11:28:55 +0200 (CEST)
X-ME-UUID: 20080418092901525.806251C00098@mwinf6312.orange.nl
In-Reply-To: <1207827189-7509-2-git-send-email-johannes.sixt@telecom.at>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79870>

Hi,

On 10 apr 2008, at 13:33, Johannes Sixt wrote:
> Its documentation was removed by  
> 6c96753df9db7f790a2ac4d95ec2a868394cd5ff,
> even though it is referenced from a few places, including builtin- 
> commit.c
> (as part of the commentary in the commit message template).
>
> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>

> +-o|--only::
> +	Make a commit only from the paths specified on the
> +	command line, disregarding any contents that have been
> +	staged so far. This is the default mode of operation of
> +	'git commit' if any paths are given on the command line,
> +	in which case this option can be omitted.
> +	If this option is specified together with '--amend', then
> +	no paths need be specified, which can be used to amend
> +	the last commit without committing changes that have
> +	already been staged.
> +

I find this addition to the manpage very confusing. If -o commits  
paths only from the command line, and it is also the default operation  
when run with paths, why is this text at the -o option? This behaviour  
is already documented in the description of git-commit:

        3. by listing files as arguments to the commit command, in  
which case the commit will
           ignore changes staged in the index, and instead record the  
current content of the
           listed files;

I'd suggest only using the second part (about --amend), or optionally  
adding something about what happens if you specify -o without --amend  
and without paths.

- Pieter
