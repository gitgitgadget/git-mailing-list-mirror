From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: don't offer remote transport helpers as
	subcommands
Date: Thu, 28 Jan 2010 07:19:51 -0800
Message-ID: <20100128151951.GB20185@spearce.org>
References: <1264157691-27187-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: SZEDER G??bor <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 16:20:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaWA8-00086u-21
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 16:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007Ab0A1PT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 10:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753760Ab0A1PT4
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 10:19:56 -0500
Received: from mail-qy0-f182.google.com ([209.85.221.182]:54553 "EHLO
	mail-qy0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013Ab0A1PT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 10:19:56 -0500
Received: by qyk12 with SMTP id 12so335116qyk.21
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 07:19:55 -0800 (PST)
Received: by 10.224.107.210 with SMTP id c18mr6323807qap.137.1264691995378;
        Thu, 28 Jan 2010 07:19:55 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm730284qyk.0.2010.01.28.07.19.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Jan 2010 07:19:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1264157691-27187-1-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138255>

SZEDER G??bor <szeder@ira.uka.de> wrote:
> Since commits a2d725b7 (Use an external program to implement fetching
> with curl, 2009-08-05) and c9e388bb (Make the
> "traditionally-supported" URLs a special case, 2009-09-03) remote
> transport helpers like 'remote-ftp' and 'remote-curl' are offered by the
> completion script as available subcommands.  Not good, since they are
> helpers, therefore should not be offered, so filter them out.
> 
> Signed-off-by: SZEDER G??bor <szeder@ira.uka.de>
> ---
> 
> Maybe maint-worthy?  1.6.5 was the first release with this bug, but
> nobody complained since then.

Yup, should be in maint.

Acked-by: Shawn O. Pearce <spearce@spearce.org>
 
>  contrib/completion/git-completion.bash |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 9651720..7def62c 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -568,6 +568,7 @@ __git_list_porcelain_commands ()
>  		read-tree)        : plumbing;;
>  		receive-pack)     : plumbing;;
>  		reflog)           : plumbing;;
> +		remote-*)         : transport;;
>  		repo-config)      : deprecated;;
>  		rerere)           : plumbing;;
>  		rev-list)         : plumbing;;
> -- 
> 1.6.6.1.361.gc5121

-- 
Shawn.
