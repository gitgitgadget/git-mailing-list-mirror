From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH] completion: --list option for git-branch
Date: Thu, 16 Feb 2012 10:28:42 +0100
Message-ID: <4F3CCC4A.5010100@in.waw.pl>
References: <1329338218-9822-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org, gitster@pobox.com
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 10:29:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxxe8-0003kN-45
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 10:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab2BPJ25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 04:28:57 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52688 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828Ab2BPJ2y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 04:28:54 -0500
Received: from [193.0.105.130]
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1Rxxdx-000192-JE; Thu, 16 Feb 2012 10:28:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <1329338218-9822-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190889>

On 02/15/2012 09:36 PM, Ralf Thielow wrote:
> Signed-off-by: Ralf Thielow<ralf.thielow@googlemail.com>
> ---
>   contrib/completion/git-completion.bash |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index d7367e9..1505cff 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1137,7 +1137,7 @@ _git_branch ()
>   		__gitcomp "
>   			--color --no-color --verbose --abbrev= --no-abbrev
>   			--track --no-track --contains --merged --no-merged
> -			--set-upstream --edit-description
> +			--set-upstream --edit-description --list
>   			"
>   		;;
>   	*)
Normally one would use just a bare 'git branch' to list branches.
Why would you want to use --list in an interactive environment (as 
opposed to a script)? Isn't it better not to clutter the completion
options with something that the user actually has not need for?

Zbyszek
