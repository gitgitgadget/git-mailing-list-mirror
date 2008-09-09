From: Petr Baudis <pasky@suse.cz>
Subject: Re: Revert behavior [Was: Re: [ANNOUNCE] yap: Yet Another (Git)
	Porcelain]
Date: Tue, 9 Sep 2008 23:28:34 +0200
Message-ID: <20080909212834.GC10544@machine.or.cz>
References: <51419b2c0809090626p2196c590j7569fb471e470f0d@mail.gmail.com> <200809091538.13961.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>,
	Govind Salinas <govind@sophiasuchtig.com>,
	Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 23:29:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdAmO-00081c-7Z
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 23:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212AbYIIV2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 17:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754053AbYIIV2h
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 17:28:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37694 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751224AbYIIV2g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 17:28:36 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id B1D31393A6C5; Tue,  9 Sep 2008 23:28:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809091538.13961.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95441>

On Tue, Sep 09, 2008 at 03:38:13PM +0200, Jakub Narebski wrote:
> By the way, I think the fact that in different SCMs meaning of
> "$scm revert" and of "$scm reset" differs widely caused Mercurial
> to adopt "hg backout" for creating a commit which reverts changes
> (cherry-pick -R), and "hg rollback" to undo last commit.

This brings up a point I wanted to raise - sometimes when the meanings
across the systems (including Git) are too conflicting, it should be
considered to use a completely different command name whatsoever to
reduce the confusion. This is e.g. the reason Cogito had no "pull"
(but "update") or "checkout" (but "restore" and "switch") commands.

				Petr "Pasky" Baudis
