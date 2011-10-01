From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH] gitk: Show patch for initial commit
Date: Sat, 01 Oct 2011 11:54:11 +0200
Message-ID: <4E86E343.5070704@in.waw.pl>
References: <20110930215021.GA3005@kennedy.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Marcus Karlsson <mk@acc.umu.se>
X-From: git-owner@vger.kernel.org Sat Oct 01 11:54:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9wH4-0007E0-DP
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 11:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755009Ab1JAJyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 05:54:21 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:41329 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753928Ab1JAJyU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 05:54:20 -0400
Received: from 86-85-n1.aster.pl ([85.222.86.85] helo=[192.168.1.6])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1R9wGx-0003e9-1a; Sat, 01 Oct 2011 11:54:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110807 Icedove/5.0
In-Reply-To: <20110930215021.GA3005@kennedy.acc.umu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182544>

On 09/30/2011 11:50 PM, Marcus Karlsson wrote:
> Make gitk show the patch for the initial commit.
>
> Signed-off-by: Marcus Karlsson<mk@acc.umu.se>
> ---
>   gitk-git/gitk |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 4cde0c4..20aeae6 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -7436,7 +7436,7 @@ proc diffcmd {ids flags} {
>   	    lappend cmd HEAD
>   	}
>       } else {
> -	set cmd [concat | git diff-tree -r $flags $ids]
> +	set cmd [concat | git diff-tree -r --root $flags $ids]
>       }
>       return $cmd
>   }
Cool, this works for me! But I think I would be really nice if gitk 
respected the configuration value of log.showroot. This would give nice 
consistency amongst the various tools.

Zbyszek
