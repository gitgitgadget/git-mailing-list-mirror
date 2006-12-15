X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Provide more meaningful output from 'git init-db'.
Date: Fri, 15 Dec 2006 15:14:15 +0100
Organization: At home
Message-ID: <eluaf0$v7q$2@sea.gmane.org>
References: <Pine.LNX.4.64.0612142141420.18171@xanadu.home> <20061215054458.GA27750@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 15 Dec 2006 14:15:23 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 25
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34504>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvDqD-0007YO-9y for gcvg-git@gmane.org; Fri, 15 Dec
 2006 15:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752201AbWLOOPJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 09:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752204AbWLOOPJ
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 09:15:09 -0500
Received: from main.gmane.org ([80.91.229.2]:36546 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1752201AbWLOOPG
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 09:15:06 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GvDq2-00034b-Fw for git@vger.kernel.org; Fri, 15 Dec 2006 15:15:02 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 15:15:02 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 15 Dec 2006
 15:15:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Shawn O. Pearce wrote:

> So now we print out what we did ("Initialized empty" or
> "Reinitialized existing"), what type of repository ("" or "shared"),
> and what location the repository will be in ("$GIT_DIR").

>  ----------------
> -defaulting to local storage area
> +Initialized empty Git repository in .git/
>  ----------------

> +     printf("%s%s Git repository in %s/\n",
> +             reinit ? "Reinitialized existing" : "Initialized empty",
> +             shared_repository ? " shared" : "",
> +             git_dir);

It seems like this lack this " in " part you have mentioned in
commit message and in tutorial.

+1. Very nice. Making git more newbie-friendly.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

