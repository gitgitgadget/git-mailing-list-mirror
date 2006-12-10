X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Documentation/git-commit: rewrite to make it more end-user friendly.
Date: Sun, 10 Dec 2006 01:30:47 +0100
Message-ID: <200612100130.48812.Josef.Weidendorfer@gmx.de>
References: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612082141260.2630@xanadu.home> <7vd56tei20.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 00:31:15 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	"J. Bruce Fields" <bfields@fieldses.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.5
In-Reply-To: <7vd56tei20.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33855>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtCaz-0004MQ-Ck for gcvg-git@gmane.org; Sun, 10 Dec
 2006 01:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759876AbWLJAa4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 19:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759878AbWLJAa4
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 19:30:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:49591 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1759876AbWLJAa4
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006 19:30:56 -0500
Received: (qmail invoked by alias); 10 Dec 2006 00:30:54 -0000
Received: from p5496B595.dip0.t-ipconnect.de (EHLO noname) [84.150.181.149]
 by mail.gmx.net (mp001) with SMTP; 10 Dec 2006 01:30:54 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Very nice.

On Saturday 09 December 2006 06:48, Junio C Hamano wrote:
>  DESCRIPTION
>  -----------
> -Updates the index file for given paths, or all modified files if
> -'-a' is specified, and makes a commit object.  The command specified
> -by either the VISUAL or EDITOR environment variables are used to edit
> -the commit log message.
> +Use 'git commit' when you want to record your changes into the repository
> +along with a log message describing what the commit is about. All changes
> +to be committed must be explicitly identified using one of the following

What about: "... must be explicitly identified (that is,
must be "staged") ..."

This way, it will be clear for the reader that "to explicitly identify" is the
same thing as "to stage", which is used quite often later.

> +methods:
>  
> -Several environment variable are used during commits.  They are
> -documented in gitlink:git-commit-tree[1].
> +1. by using gitlink:git-add[1] to incrementally "add" changes to the
> +   next commit before using the 'commit' command (Note: even modified
> +   files must be "added");

Regarding this note: Of course unmodified files do not have to be added ;-)

What about: "(Note: changes in files already known to git, and even new
changes done after a previous `git add` for a given file, still must
be staged again)" 

