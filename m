From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH/RFC] gitweb: Create Gitweb::Git module
Date: Mon, 7 Jun 2010 16:48:52 +0200
Message-ID: <20100607144852.GN20775@machine.or.cz>
References: <1275859451-21787-1-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 16:49:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLddO-0002Ye-4h
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 16:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857Ab0FGOs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 10:48:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50256 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751574Ab0FGOs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 10:48:56 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 51C5D862092; Mon,  7 Jun 2010 16:48:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1275859451-21787-1-git-send-email-pavan.sss1991@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148602>

On Mon, Jun 07, 2010 at 02:54:11AM +0530, Pavan Kumar Sunkara wrote:
> @@ -39,9 +38,8 @@ BEGIN {
>  # with their descriptions is listed in Gitweb::Config.
>  $version = "++GIT_VERSION++";
>  
> -# core git executable to use
> -# this can just be "git" if your webserver has a sensible PATH
> -our $GIT = "++GIT_BINDIR++/git";
> +#only this variable has it's root in Gitweb::Git
> +$GIT = "++GIT_BINDIR++/git";
>  
>  $projectroot = "++GITWEB_PROJECTROOT++";
>  $project_maxdepth = "++GITWEB_PROJECT_MAXDEPTH++";

That comment is super-cryptic, I'd suggest either rewording it or
dropping it completely.

> @@ -1548,21 +1536,6 @@ sub get_feed_info {
>  ## ----------------------------------------------------------------------
>  ## git utility subroutines, invoking git commands

Is there any reason why didn't you move the rest of the commands from
this section to Gitweb::Git as well?

				Petr "Pasky" Baudis
