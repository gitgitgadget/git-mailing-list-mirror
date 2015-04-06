From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Fix bad English grammar "Matches none Commit Info"
Date: Mon, 6 Apr 2015 13:46:50 +1000
Message-ID: <20150406034649.GC26765@iris.ozlabs.ibm.com>
References: <1428008706-10894-1-git-send-email-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ottxor@gentoo.org, git@vger.kernel.org
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 06:39:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yeyod-0003Yt-5b
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 06:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbbDFEiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2015 00:38:55 -0400
Received: from ozlabs.org ([103.22.144.67]:57979 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734AbbDFEiy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 00:38:54 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id E569514027F; Mon,  6 Apr 2015 14:38:52 +1000 (AEST)
Content-Disposition: inline
In-Reply-To: <1428008706-10894-1-git-send-email-alexhenrie24@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266830>

On Thu, Apr 02, 2015 at 03:05:06PM -0600, Alex Henrie wrote:
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  gitk | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gitk b/gitk
> index 9a2daf3..30fcd30 100755
> --- a/gitk
> +++ b/gitk
> @@ -4066,7 +4066,7 @@ set known_view_options {
>      {committer t15  .  "--committer=*"  {mc "Committer:"}}
>      {loginfo   t15  .. "--grep=*"       {mc "Commit Message:"}}
>      {allmatch  b    .. "--all-match"    {mc "Matches all Commit Info criteria"}}
> -    {igrep     b    .. "--invert-grep"  {mc "Matches none Commit Info criteria"}}
> +    {igrep     b    .. "--invert-grep"  {mc "Matches no Commit Info criteria"}}

Thanks, applied.

Paul.
