From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: bash completion: 'git apply' should use 'fix' not 'strip'
Date: Thu, 14 Aug 2008 13:58:04 -0700
Message-ID: <20080814205804.GP3782@spearce.org>
References: <279b37b20808141012l460e2218lbe440dfe3ee44462@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Raible <raible@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 22:59:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTjuY-0007bJ-Rg
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 22:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbYHNU6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 16:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753618AbYHNU6H
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 16:58:07 -0400
Received: from george.spearce.org ([209.20.77.23]:50985 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbYHNU6G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 16:58:06 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6B03338375; Thu, 14 Aug 2008 20:58:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <279b37b20808141012l460e2218lbe440dfe3ee44462@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92399>

Eric Raible <raible@gmail.com> wrote:
> Bring completion up to date with the man page.
> 
> Signed-off-by: Eric Raible <raible@gmail.com>
> ---
> Seems to me that this qualifies as "obviously correct"...
 
Acked-by: Shawn O. Pearce <spearce@spearce.org>

Be nice if it was in 1.6.0.  Eric posted this patch earlier but it
apparently got missed.

>  contrib/completion/git-completion.bash |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash
> b/contrib/completion/git-completion.bash
> index 3396e35..95040bd 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -501,7 +501,7 @@ __git_has_doubledash ()
>        return 1
>  }
> 
> -__git_whitespacelist="nowarn warn error error-all strip"
> +__git_whitespacelist="nowarn warn error error-all fix"
> 
>  _git_am ()
>  {
> --
> 1.6.0.rc1.1206.gff2cf

-- 
Shawn.
