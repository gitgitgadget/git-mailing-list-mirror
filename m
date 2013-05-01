From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: added an --include-path flag (resent fixing
 mail format)
Date: Wed, 1 May 2013 20:46:16 +0000
Message-ID: <20130501204616.GA12203@dcvr.yhbt.net>
References: <20130424212856.GA23696@dcvr.yhbt.net>
 <1366842790-18877-1-git-send-email-pjwhams@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Paul Walmsley <pjwhams@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 22:46:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXdux-0000Pg-J0
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 22:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757088Ab3EAUqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 16:46:19 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51379 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756740Ab3EAUqS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 16:46:18 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BCE11F425;
	Wed,  1 May 2013 20:46:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1366842790-18877-1-git-send-email-pjwhams@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223140>

Paul Walmsley <pjwhams@gmail.com> wrote:
> The SVN::Fetcher module is now able to filter for inclusion as well
> as exclusion (as used by --ignore-path). Also added tests, documentation
> changes and git completion script.
> 
> If you have an SVN repository with many top level directories and you
> only want a git-svn clone of some of them then using --ignore-path is
> difficult as it requires a very long regexp. In this case it's much
> easier to filter for inclusion.

Thanks, comments inline.

A Signed-off-by is necessary (especially for new contributors)

(not _my_ policy, but project policy, see Documentation/SubmittingPatches)

> @@ -1,5 +1,5 @@
>  package Git::SVN::Fetcher;
> -use vars qw/@ISA $_ignore_regex $_preserve_empty_dirs $_placeholder_filename
> +use vars qw/@ISA $_ignore_regex $_include_regex $_preserve_empty_dirs $_placeholder_filename
>              @deleted_gpath %added_placeholder $repo_id/;

Please wrap long lines at 80 columns.

> --- /dev/null
> +++ b/t/t9147-git-svn-include-paths.sh
> @@ -0,0 +1,150 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2009 Vitaly Shukela
> +# Copyright (c) 2009 Eric Wong
> +#

I already commented on this in the previous email, please add your
own copyright header (you can add a note saying this is based on
t9134 by Vitaly).

Thanks again.
