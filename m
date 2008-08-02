From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash completion: Add more long options for 'git log'
Date: Sat, 2 Aug 2008 14:00:30 -0700
Message-ID: <20080802210030.GC24723@spearce.org>
References: <1217638613-57366-1-git-send-email-lee.marlow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Lee Marlow <lee.marlow@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 23:01:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPOEG-0007YB-Pz
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 23:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbYHBVAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 17:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbYHBVAb
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 17:00:31 -0400
Received: from george.spearce.org ([209.20.77.23]:54339 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbYHBVAb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 17:00:31 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 052EC38420; Sat,  2 Aug 2008 21:00:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1217638613-57366-1-git-send-email-lee.marlow@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91178>

Lee Marlow <lee.marlow@gmail.com> wrote:
> Options added: --parents --children --full-history
> 
> Signed-off-by: Lee Marlow <lee.marlow@gmail.com>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 30d8701..7132a68 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -853,6 +853,7 @@ _git_log ()
>  			--stat --numstat --shortstat
>  			--decorate --diff-filter=
>  			--color-words --walk-reflogs
> +			--parents --children --full-history
>  			"
>  		return
>  		;;

-- 
Shawn.
