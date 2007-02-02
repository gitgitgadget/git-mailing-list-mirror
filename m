From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] Teach 'git remote' how to cleanup stale tracking branches.
Date: Fri, 02 Feb 2007 11:53:56 +0100
Organization: At home
Message-ID: <epv55j$8js$1@sea.gmane.org>
References: <58b74d176fd10417a58d42d9437c631d03f4c4f6.1170392736.git.spearce@spearce.org> <20070202050608.GB20505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 02 11:53:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCw2x-0002p5-TK
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 11:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932967AbXBBKxc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 05:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933339AbXBBKxc
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 05:53:32 -0500
Received: from main.gmane.org ([80.91.229.2]:49996 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932967AbXBBKxb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 05:53:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCw2Y-0003Io-4c
	for git@vger.kernel.org; Fri, 02 Feb 2007 11:53:13 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 11:53:10 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 11:53:10 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38490>

Shawn O. Pearce wrote:


> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
> index 358c1ac..817651e 100644
> --- a/Documentation/git-remote.txt
> +++ b/Documentation/git-remote.txt
> @@ -12,6 +12,7 @@ SYNOPSIS
>  'git-remote'
>  'git-remote' add <name> <url>
>  'git-remote' show <name>
> +'git-remote' prune <name>
>  
>  DESCRIPTION
>  -----------
> @@ -26,6 +27,10 @@ update remote-tracking branches <name>/<branch>.
>  
>  In the third form, gives some information about the remote <name>.
>  
> +In the fourth form, deletes all stale tracking branches under <name>.
> +These stale branches have already been removed from the remote repository
> +referenced by <name>, but are still locally available in "remotes/<name>".
> +

Wouldn't it be better to refer to subcommand by name, instead of
the number of subcommand ("fourth form")? Compare git-rerere(1).

P.S. I wanted to refer to documentation of other commands with
subcommands, but git-bisect(1) is not good example; git-rerere(1)
I think is.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
