X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: Re: egit/jgit wishlist
Date: Mon, 04 Dec 2006 09:58:23 -0800
Message-ID: <457461BF.6080706@midwinter.com>
References: <20061204172836.GB6011@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 4 Dec 2006 17:58:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
In-Reply-To: <20061204172836.GB6011@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33209>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrI4z-0008DM-U8 for gcvg-git@gmane.org; Mon, 04 Dec
 2006 18:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936091AbWLDR6L (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 12:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936111AbWLDR6L
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 12:58:11 -0500
Received: from tater.midwinter.com ([216.32.86.90]:47566 "HELO midwinter.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S936091AbWLDR6K
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 12:58:10 -0500
Received: (qmail 23691 invoked from network); 4 Dec 2006 17:58:09 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.130?)
 (koreth@76.21.17.123) by tater.midwinter.com with SMTP; 4 Dec 2006 17:58:09
 -0000
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

I am definitely looking forward to a usable Eclipse plugin! A few comments:

My usual git working style is to not switch branches with a dirty 
working directory; I always commit to the current branch before 
switching to a new one. I mention that because I assume it'll be easier 
to implement that workflow first; once you have commit capability, you 
can do that style of branch switching (either preventing the switch or 
doing an implicit commit when the working directory is dirty) without 
having to worry about merging.

And finally, it would be swell -- but put it at the bottom of your 
priority list -- to have git-svn interoperability; sadly most of my git 
usage at the moment is in cloned svn repositories and it would be great 
if egit could do the right thing when the current git repo is cloned 
from svn. What "the right thing" is, exactly, is debatable, but I 
suppose some kind of integration with the Subclipse plugin is one 
possibility (and if nothing else, that plugin probably has code that can 
be reused.) I'd like to be able to update from and commit to the parent 
svn repository.

-Steve
