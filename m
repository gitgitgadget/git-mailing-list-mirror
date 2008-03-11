From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: git message
Date: Tue, 11 Mar 2008 14:30:49 +0100
Message-ID: <200803111430.49927.barra_cuda@katamail.com>
References: <20080310144600.GA15556@roadking.ldev.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Mike Miller <mike.miller@hp.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 14:21:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ4QN-0004MD-B2
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 14:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbYCKNUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 09:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbYCKNUy
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 09:20:54 -0400
Received: from smtp.katamail.com ([62.149.157.154]:49616 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751282AbYCKNUx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 09:20:53 -0400
Received: (qmail 9558 invoked by uid 89); 11 Mar 2008 13:19:59 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=RDNS_NONE autolearn=disabled
	version=3.2.3
Received: from unknown (HELO host41-56-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.56.41)
  by smtp2-pc with SMTP; 11 Mar 2008 13:19:58 -0000
User-Agent: KMail/1.9.7
In-Reply-To: <20080310144600.GA15556@roadking.ldev.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76841>

On Monday 10 March 2008, Mike Miller wrote:
> I see some patches referring to this message but I don't understand what it
> means:
> 
> Warning: Remote HEAD refers to nonexistent ref, unable to checkout.
> 
> Would someone please explain the message? Is my repository complete?

When you clone from a repository, git clone does a default checkout using
the branch referred to by HEAD. If HEAD does not exist on the remote repo,
git clone simply does not checkout any branch (but your local repo is ok).

At least that's what I understood from reading git-clone.sh.

You can see all the remote branches with

	git branch -a

and checkout a new local branch on top of them with

	git checkout -b local_branch remote_branch
