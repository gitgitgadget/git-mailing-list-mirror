X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Re: Getting CVS and Git to play nicely in the same box
Date: Thu, 30 Nov 2006 13:54:07 +0000
Organization: Insert Joke Here
Message-ID: <1164894847.21950.98.camel@okra.transitives.com>
References: <1164890354.21950.92.camel@okra.transitives.com>
	 <ekml1n$ask$1@sea.gmane.org>
Reply-To: kernel-hacker@bennee.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 13:54:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ekml1n$ask$1@sea.gmane.org>
X-Mailer: Evolution 2.6.0 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32745>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpmMi-0001zt-1b for gcvg-git@gmane.org; Thu, 30 Nov
 2006 14:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936412AbWK3NyK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 08:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936413AbWK3NyK
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 08:54:10 -0500
Received: from mx.transitive.com ([217.207.128.220]:6530 "EHLO
 pennyblack.transitives.com") by vger.kernel.org with ESMTP id S936412AbWK3NyJ
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 08:54:09 -0500
Received: from [192.168.1.82] (helo=okra.transitives.com) by
 pennyblack.transitives.com with esmtp (Exim 4.50) id 1GpmDR-0004w4-9y; Thu,
 30 Nov 2006 13:44:41 +0000
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Thu, 2006-11-30 at 14:08 +0100, Jakub Narebski wrote:
> Alex Bennee wrote:
> 
> > Has anyone successfully set up such a working environment? Can anyone
> > offer any tips on how to make it all work nicely?
> 
> Why not use git-cvsserver? Or port git-svn to CVS (or use Tailor)?

I can't use git-cvsserver because the main repository is going to have
to stay on CVS for the time being. I don't think it could be used as a
drop in replacement for our existing server anyway as it doesn't support
tagging or branching.

Using git is my own personal indulgence (At least until I can
demonstrate it's worth while the other migrating ;-).

It looks like git-svn  is the sort of tool I'd want for CVS although I'm
not sure how it would live with our CVS branched development model. I'll
have a poke around Tailor and see if that offers any help.

-- 
Alex, homepage: http://www.bennee.com/~alex/
Nobody wants constructive criticism. It's all we can do to put up with
constructive praise.
