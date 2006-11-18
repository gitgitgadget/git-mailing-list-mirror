X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: Define symref and update HEAD description
Date: Sat, 18 Nov 2006 11:55:37 -0800
Message-ID: <7v64dccyx2.fsf@assigned-by-dhcp.cox.net>
References: <20061118194408.27106.65771.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 19:56:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061118194408.27106.65771.stgit@machine.or.cz> (Petr Baudis's
	message of "Sat, 18 Nov 2006 20:44:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31799>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlWIC-0005QL-25 for gcvg-git@gmane.org; Sat, 18 Nov
 2006 20:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756411AbWKRTzj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 14:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756414AbWKRTzj
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 14:55:39 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:16852 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1756413AbWKRTzi
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 14:55:38 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061118195538.SZNO7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Sat, 18
 Nov 2006 14:55:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id oKvA1V0021kojtg0000000; Sat, 18 Nov 2006
 14:55:10 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> HEAD was still described as a symlink instead of a symref.
>...
>  HEAD::
> +	A symref (see glossary) to the `refs/heads/` namespace
> +	describing the currently active branch.  It does not mean
> +	much if the repository is not associated with any working tree
>  	(i.e. a 'bare' repository), but a valid git repository
> +	*must* have the HEAD file; some porcelains may use it to
> +	guess the designated "default" branch of the repository
> +	(usually 'master').  It is legal if the named branch
> +	'name' does not (yet) exist.  In some legacy setups, it is
> +	a symbolic link instead of a symref, but this has been
> +	deprecated long ago.

We fully support dealing with repositories with symlinked HEAD,
and will continue to do so; I do not think we ever talked about
deprecating it.  Public "distribution point" repositories that
have been established long ago that do not have reason to switch
HEAD to point at different branch still have symlinked HEAD and
they should continue to work.

What we _don't_ do these days is to set up new repositories with
symlinked HEAD, but that does not have anything to do with
deprecating symlinked HEAD.


