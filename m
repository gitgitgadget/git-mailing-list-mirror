From: Eric Wong <normalperson@yhbt.net>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 1 Dec 2007 00:55:36 -0800
Message-ID: <20071201085536.GA11900@muzzle>
References: <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org> <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org> <7vfxz89x9q.fsf@gitster.siamese.dyndns.org> <7vabpctx3b.fsf@gitster.siamese.dyndns.org> <7vsl30eyuk.fsf@gitster.siamese.dyndns.org> <7vve7tuz3a.fsf@gitster.siamese.dyndns.org> <7v4pfakr4j.fsf@gitster.siamese.dyndns.org> <7vzlwv6sxr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steven Grimm <koreth@midwinter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 09:56:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyO8m-0006cN-HS
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 09:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbXLAIzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 03:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbXLAIzi
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 03:55:38 -0500
Received: from hand.yhbt.net ([66.150.188.102]:44096 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915AbXLAIzi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 03:55:38 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 5DF127DC0FE;
	Sat,  1 Dec 2007 00:55:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vzlwv6sxr.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66706>

Junio C Hamano <gitster@pobox.com> wrote:
> * ew/svn (Thu Nov 22 13:44:42 2007 +0000) 4 commits
>  - git-svn: add support for pulling author from From: and Signed-off-
>    by:
>  - git-svn: add a show-externals command.
>  - git-svn now reads settings even if called in subdirectory
>  - git-svn: Remove unnecessary Git::SVN::Util package
> 
> Picked up from the list with Eric's Acks, but haven't merged, as my next
> pull from Eric would hopefully bring them in anyway.

Hi,

I've pushed the following out to git://git.bogomips.org/git-svn.git ,
along with Steven's patch:

Andy Whitcroft (1):
      git-svn: add support for pulling author from From: and Signed-off-by:

David D. Kilzer (1):
      git-svn: Remove unnecessary Git::SVN::Util package

Gustaf Hendeby (1):
      git-svn now reads settings even if called in subdirectory

Steven Grimm (1):
      git-svn: Don't create a "master" branch every time rebase is run

Vineet Kumar (1):
      git-svn: add a show-externals command.


-- 
Eric Wong
