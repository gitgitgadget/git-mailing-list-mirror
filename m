From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] completion: For consistency, changed "git
	rev-parse" to __gitdir calls.
Date: Wed, 11 Feb 2009 08:22:35 -0800
Message-ID: <20090211162235.GE30949@spearce.org>
References: <1234366634-17900-1-git-send-email-ted@tedpavlic.com> <1234366634-17900-2-git-send-email-ted@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 17:24:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXHsZ-00055u-R1
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 17:24:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755365AbZBKQWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 11:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754497AbZBKQWh
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 11:22:37 -0500
Received: from george.spearce.org ([209.20.77.23]:56794 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890AbZBKQWg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 11:22:36 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 093C138210; Wed, 11 Feb 2009 16:22:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1234366634-17900-2-git-send-email-ted@tedpavlic.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109436>

Ted Pavlic <ted@tedpavlic.com> wrote:
> Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
> ---

Acked-by: Shawn O. Pearce <spearce@spearce.org>

>  contrib/completion/git-completion.bash |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index f44f63c..6bbe09a 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -80,7 +80,7 @@ __gitdir ()
>  # returns text to add to bash PS1 prompt (includes branch name)
>  __git_ps1 ()
>  {
> -	local g="$(git rev-parse --git-dir 2>/dev/null)"
> +	local g="$(__gitdir)"
>  	if [ -n "$g" ]; then
>  		local r
>  		local b
> @@ -1797,7 +1797,7 @@ _gitk ()
>  	__git_has_doubledash && return
>  
>  	local cur="${COMP_WORDS[COMP_CWORD]}"
> -	local g="$(git rev-parse --git-dir 2>/dev/null)"
> +	local g="$(__gitdir)"
>  	local merge=""
>  	if [ -f $g/MERGE_HEAD ]; then
>  		merge="--merge"
> -- 
> 1.6.1.2.390.gba743
> 

-- 
Shawn.
