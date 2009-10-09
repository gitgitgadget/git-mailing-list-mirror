From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: add support for 'git replace'
Date: Fri, 9 Oct 2009 15:19:54 -0700
Message-ID: <20091009221954.GA9261@spearce.org>
References: <4ACFA1C2.6020001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bj??rn Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 00:21:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwNpj-0002Dt-Lf
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 00:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934662AbZJIWUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 18:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934650AbZJIWUb
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 18:20:31 -0400
Received: from george.spearce.org ([209.20.77.23]:49010 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934392AbZJIWUa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 18:20:30 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 94262381FE; Fri,  9 Oct 2009 22:19:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4ACFA1C2.6020001@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129852>

Acked-by: Shawn O. Pearce <spearce@spearce.org>
 
> +_git_replace ()
> +{
> +	__gitcomp "$(__git_refs)"
> +}
> +
>  _git_reset ()
>  {
>  	__git_has_doubledash && return
> @@ -2162,6 +2167,7 @@ _git ()
>  	push)        _git_push ;;
>  	rebase)      _git_rebase ;;
>  	remote)      _git_remote ;;
> +	replace)     _git_replace ;;

-- 
Shawn.
