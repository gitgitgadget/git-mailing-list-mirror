From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Great subroutines renaming
Date: Tue, 08 Aug 2006 11:38:50 +0200
Organization: At home
Message-ID: <eb9m30$3ef$2@sea.gmane.org>
References: <200608071626.52655.jnareb@gmail.com> <7v3bc82v7l.fsf@assigned-by-dhcp.cox.net> <eb8cdh$s6n$1@sea.gmane.org> <7v4pwo1a0r.fsf@assigned-by-dhcp.cox.net> <eb8e12$2aa$1@sea.gmane.org> <7vejvsyum8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Aug 08 11:40:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAO4Y-00026L-T7
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 11:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWHHJkV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 05:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWHHJkV
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 05:40:21 -0400
Received: from main.gmane.org ([80.91.229.2]:55438 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932177AbWHHJkU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Aug 2006 05:40:20 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GAO4A-00021X-GN
	for git@vger.kernel.org; Tue, 08 Aug 2006 11:40:02 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 11:40:02 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 11:40:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25063>

Junio C Hamano wrote:

> +git-show-refs(1)
> +================
> +
> +NAME
> +----
> +git-show-refs - Lists refs in various formats
[...]
> +EXAMPLES
> +--------
> +
> +Show most recent 16 tags for consumption by gitweb::
> +     git-show-refs --count=16 --sort=-taggerdate,name \
> +             --format='%(taggerdate) %(name)\t%(tag)\t%(subject)' 'tags/*'
> +
> +`git-branch` without argument::
> +     git-show-refs --format='%(ishead)%(name)' 'heads/*'
> +
> +`git-tag -l`::
> +     git-show-refs tags/*

`git-ls-remotes .` is suspiciously missing from the examples.

Format needs to somewhat incorporate line for referencing object for that, 
if it exists.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
