From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] t/t91XX-svn: start removing use of "git-" from these tests
Date: Mon, 8 Sep 2008 03:27:59 -0700
Message-ID: <20080908102759.GC13085@hand.yhbt.net>
References: <20080908190205.6117@nanako3.lavabit.com> <20080908101631.GA6948@toroid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Abhijit Menon-Sen <ams@toroid.org>
X-From: git-owner@vger.kernel.org Mon Sep 08 12:29:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcdzc-0007c7-Sc
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 12:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbYIHK2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 06:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752078AbYIHK2E
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 06:28:04 -0400
Received: from hand.yhbt.net ([66.150.188.102]:44198 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055AbYIHK2D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 06:28:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 157B82DC01B;
	Mon,  8 Sep 2008 03:28:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080908101631.GA6948@toroid.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95235>

Abhijit Menon-Sen <ams@toroid.org> wrote:
> At 2008-09-08 19:02:05 +0900, nanako3@lavabit.com wrote:
> >
> > This first step replaces literal strings "remotes/git-svn" and
> > "git-svn-id" by introducing $remotes_git_svn and $git_svn_id
> > constants defined as shell variables.
> 
> I'm sorry, but... why? I don't see the point at all. These are not even
> commands; and, as someone who was just reading the svn tests, the change
> certainly doesn't make them *easier* to follow.

They'll show up as false positives when grepping for "git-"

The commit message should've mentioned that, though (assuming I'm
reading Nanako's mind correctly :)

Nanako: I'm fine with the patches, too sleepy and tired to actually test
them, though.

-- 
Eric Wong
