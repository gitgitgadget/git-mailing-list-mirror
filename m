From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] allow user aliases for the --author parameter
Date: Thu, 21 Aug 2008 19:41:18 +0200
Message-ID: <20080821174118.GB5119@blimp.local>
References: <g8jbvd$18k$1@ger.gmane.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Thu Aug 21 19:42:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWEAy-0006GH-Nz
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 19:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760814AbYHURlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 13:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760970AbYHURlW
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 13:41:22 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:41593 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760967AbYHURlU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 13:41:20 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg201f5UW7
Received: from tigra.home (Faf2f.f.strato-dslnet.de [195.4.175.47])
	by post.webmailer.de (fruni mo36) (RZmta 16.47)
	with ESMTP id x00294k7LFWmgH ; Thu, 21 Aug 2008 19:41:18 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id 5796F277AE;
	Thu, 21 Aug 2008 19:41:18 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 3324536D18; Thu, 21 Aug 2008 19:41:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <g8jbvd$18k$1@ger.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93181>

Michael J Gruber, Thu, Aug 21, 2008 11:19:41 +0200:
> This allows the use of author abbreviations when specifying commit
> authors via the --author option to git commit. "--author=$key" is
> resolved by looking up "user.$key.name" and "user.$key.email" in the
> config.

Isn't there existing well-known formats for mail aliases?
For instance, Mutt uses simple text file:

    alias nickname1 Author Name <mail@address>
    alias nickname2 "Author Name 2" <mail2@address>

I don't know how well-known this is, but is surely more known than
git's config (and there are aliases in that format already).
Maybe just reference such files in git's config?
