From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/4] completion: Use consistent if [...] convention. No
	test.
Date: Wed, 11 Feb 2009 10:07:05 -0800
Message-ID: <20090211180705.GL30949@spearce.org>
References: <1234375406-27099-1-git-send-email-ted@tedpavlic.com> <1234375406-27099-2-git-send-email-ted@tedpavlic.com> <1234375406-27099-3-git-send-email-ted@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:08:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXJVj-0000i5-HY
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755066AbZBKSHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755260AbZBKSHI
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:07:08 -0500
Received: from george.spearce.org ([209.20.77.23]:56347 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755066AbZBKSHI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:07:08 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id B53D838211; Wed, 11 Feb 2009 18:07:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1234375406-27099-3-git-send-email-ted@tedpavlic.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109466>

Ted Pavlic <ted@tedpavlic.com> wrote:
> The local coding convention in bash completion is to use [...] rather
> than test. Additionally,
> 
>     if [...]; then
> 
> is preferred over
> 
>     if [...]
>     then
> 
> and so matching "if [...]\nthen" were changed accordingly.
> 
> Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
> ---
>  contrib/completion/git-completion.bash |   31 +++++++++++--------------------
>  1 files changed, 11 insertions(+), 20 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 6bbe09a..7706170 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -84,39 +84,30 @@ __git_ps1 ()
>  	if [ -n "$g" ]; then
>  		local r
>  		local b
> -		if [ -d "$g/rebase-apply" ]
> -		then
> -			if test -f "$g/rebase-apply/rebasing"
> -			then
> +		if [ -d "$g/rebase-apply" ]; then
> +			if [ -f "$g/rebase-apply/rebasing" ]; then
>  				r="|REBASE"
> -			elif test -f "$g/rebase-apply/applying"
> -			then
> +            elif [ -f "$g/rebase-apply/applying" ]; then

There is some sort of whitespace damage right here, the elif doesn't
seem to line up correctly.

-- 
Shawn.
