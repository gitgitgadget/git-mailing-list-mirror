From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] bash-completion: Add non-command git help files to
	bash-completion
Date: Fri, 15 Aug 2008 11:00:59 -0700
Message-ID: <20080815180059.GA17399@spearce.org>
References: <1218816948-7864-1-git-send-email-marcus@griep.us> <1218823168-1753-1-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@uchicago.edu>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Fri Aug 15 20:02:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU3ch-0001Vz-Vb
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 20:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096AbYHOSBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 14:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754650AbYHOSBA
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 14:01:00 -0400
Received: from george.spearce.org ([209.20.77.23]:56792 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879AbYHOSBA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 14:01:00 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A270E38375; Fri, 15 Aug 2008 18:00:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1218823168-1753-1-git-send-email-marcus@griep.us>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92501>

Marcus Griep <marcus@griep.us> wrote:
> Git allows access to the gitattributes man page via `git help attributes`,
> but this is not discoverable via the bash-completion mechanism.  This
> patch adds all current non-command man pages to the completion candidate
> list.
> 
> Signed-off-by: Marcus Griep <marcus@griep.us>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index c0bf7aa..158b912 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -885,7 +885,11 @@ _git_help ()
>  		return
>  		;;
>  	esac
> -	__gitcomp "$(__git_all_commands)"
> +	__gitcomp "$(__git_all_commands)
> +		attributes cli core-tutorial cvs-migration
> +		diffcore gitk glossary hooks ignore modules
> +		repository-layout tutorial tutorial-2
> +		"
>  }
>  
>  _git_init ()

-- 
Shawn.
