From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] docs: fix grammar in gitattributes.txt
Date: Fri, 18 Mar 2011 10:40:37 -0400
Message-ID: <4D836EE5.7060003@xiplink.com>
References: <1300454067-9934-1-git-send-email-alcosholik@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexei Sholik <alcosholik@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 15:42:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0asq-0001RL-1G
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 15:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756742Ab1CROm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 10:42:27 -0400
Received: from smtp142.iad.emailsrvr.com ([207.97.245.142]:52524 "EHLO
	smtp142.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756694Ab1CROm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 10:42:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp44.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 2AA4712820E;
	Fri, 18 Mar 2011 10:42:25 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp44.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id A7E2C1282BF;
	Fri, 18 Mar 2011 10:42:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <1300454067-9934-1-git-send-email-alcosholik@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169323>

On 11-03-18 09:14 AM, Alexei Sholik wrote:
> Signed-off-by: Alexei Sholik <alcosholik@gmail.com>
> ---
>  Documentation/gitattributes.txt |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 7e7e121..c151657 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -632,7 +632,7 @@ Performing a three-way merge
>  `merge`
>  ^^^^^^^
>  
> -The attribute `merge` affects how three versions of a file is
> +The attribute `merge` affects how three versions of a file are
>  merged when a file-level merge is necessary during `git merge`,
>  and other commands such as `git revert` and `git cherry-pick`.
>  
> @@ -646,15 +646,15 @@ Unset::
>  
>  	Take the version from the current branch as the
>  	tentative merge result, and declare that the merge has
> -	conflicts.  This is suitable for binary files that does
> +	conflicts.  This is suitable for binary files that do
>  	not have a well-defined merge semantics.
>  
>  Unspecified::
>  
>  	By default, this uses the same built-in 3-way merge
> -	driver as is the case the `merge` attribute is set.
> +	driver as is the case when the `merge` attribute is set.
>  	However, `merge.default` configuration variable can name
> -	different merge driver to be used for paths to which the
> +	different merge driver to be used with paths for which the
>  	`merge` attribute is unspecified.

That last sentence should really start like this:

- 	However, `merge.default` configuration variable can name
+ 	However, the `merge.default` configuration variable can name a

		M.
