X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: Re: Collection of stgit issues and wishes
Date: Mon, 11 Dec 2006 19:41:05 +0100
Message-ID: <20061211184105.GC17132@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20061208221744.GA3288@nan92-1-81-57-214-146.fbx.proxad.net> <200612101801.58247.jnareb@gmail.com> <b0943d9e0612101426l763d46cahe15683410cb4398d@mail.gmail.com> <200612110002.05847.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 11 Dec 2006 18:43:38 +0000 (UTC)
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612110002.05847.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34027>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtq7f-0001fk-C1 for gcvg-git@gmane.org; Mon, 11 Dec
 2006 19:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937020AbWLKSmd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 13:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937469AbWLKSmd
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 13:42:33 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:50431 "EHLO
 smtp2-g19.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S937020AbWLKSmc (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006
 13:42:32 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp2-g19.free.fr (Postfix) with ESMTP id 63D7D7D28; Mon,
 11 Dec 2006 19:42:30 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000) id C8B591F011;
 Mon, 11 Dec 2006 19:41:05 +0100 (CET)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Mon, Dec 11, 2006 at 12:02:05AM +0100, Jakub Narebski wrote:
> Catalin Marinas wrote:
> > On 10/12/06, Jakub Narebski <jnareb@gmail.com> wrote:
> 
> >> The git commands StGit uses to perform operations automatically record
> >> changes in branches in reflog. What StGit does not provide is the "reason".
> >> You do use git-update-ref?
> > 
> > Yes, only for updating HEAD. The refs in refs/patches/<branch>/ are
> > written directly. I initialy wanted to add patch history support using
> > reflogs and added "git-update-ref -m ..." for the patch commits but I
> > found slow the pushing operation a bit. Do you only want to track the
> > reflogs for HEAD?
> 
> Yes, I want for StGit to provide reasons when updating HEAD.

Apart from the use-case you described in a later mail, this could
provide a path to series-level logging (one of the points in my list);
since the meaningful changes in a series involve changing the HEAD, we
would the have most the needed info that way.

Operations just shuffling the stack (eg. "float -s", or "push XXX;
push --undo") would probably require putting the series file itself
