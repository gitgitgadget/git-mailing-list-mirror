From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: [PATCH] git-completion: offer references for 'git reflog'
Date: Tue, 04 Oct 2011 10:48:26 +0200
Message-ID: <4E8AC85A.2070009@elegosoft.com>
References: <4E7F05A6.30505@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 04 10:51:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB0j5-0003Ur-L2
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 10:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015Ab1JDItR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 04:49:17 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:47618 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754945Ab1JDItQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 04:49:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 51525DE730;
	Tue,  4 Oct 2011 10:49:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lGd55WhxVY9i; Tue,  4 Oct 2011 10:49:10 +0200 (CEST)
Received: from [10.10.10.197] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 52CC1DE727;
	Tue,  4 Oct 2011 10:49:10 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0.1) Gecko/20111001 Thunderbird/7.0.1
In-Reply-To: <4E7F05A6.30505@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182750>

On 09/25/2011 12:42 PM, Michael Schubert wrote:
> 'git reflog <ref>' is a valid command, therefore offer reference
> completion.
> 
> Signed-off-by: Michael Schubert <mschub@elegosoft.com>
> ---
>  contrib/completion/git-completion.bash |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 8648a36..63d0f08 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1774,7 +1774,7 @@ _git_reflog ()
>  	local subcommand="$(__git_find_on_cmdline "$subcommands")"
>  
>  	if [ -z "$subcommand" ]; then
> -		__gitcomp "$subcommands"
> +		__gitcomp "$subcommands $(__git_refs)"
>  	else
>  		__gitcomp "$(__git_refs)"
>  	fi

Ping.?
